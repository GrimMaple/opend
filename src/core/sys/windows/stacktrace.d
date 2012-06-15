/**
 * ...
 *
 * Copyright: Copyright Benjamin Thaut 2010 - 2011.
 * License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
 * Authors:   Benjamin Thaut, Sean Kelly
 * Source:    $(DRUNTIMESRC core/sys/windows/_stacktrace.d)
 */

/*          Copyright Benjamin Thaut 2010 - 2011.
 * Distributed under the Boost Software License, Version 1.0.
 *    (See accompanying file LICENSE or copy at
 *          http://www.boost.org/LICENSE_1_0.txt)
 */
module core.sys.windows.stacktrace;


import core.demangle;
import core.runtime;
import core.stdc.stdlib;
import core.stdc.string;
import core.sys.windows.dbghelp;
import core.sys.windows.windows;

//debug=PRINTF;
debug(PRINTF) import core.stdc.stdio;


extern(Windows) void RtlCaptureContext(CONTEXT* ContextRecord);


private __gshared immutable bool initialized;


class StackTrace : Throwable.TraceInfo
{
public:
    this()
    {
        if( initialized )
            m_trace = trace();
    }


    int opApply( scope int delegate(ref char[]) dg )
    {
        return opApply( (ref size_t, ref char[] buf)
                        {
                            return dg( buf );
                        });
    }


    int opApply( scope int delegate(ref size_t, ref char[]) dg )
    {
        int result;

        foreach( i, e; m_trace )
        {
            if( (result = dg( i, e )) != 0 )
                break;
        }
        return result;
    }


    @safe override string toString() const pure nothrow
    {
        string result;

        foreach( e; m_trace )
        {
            result ~= e ~ "\n";
        }
        return result;
    }


private:
    char[][] m_trace;


    static char[][] trace()
    {
        synchronized( StackTrace.classinfo )
        {
            return traceNoSync();
        }
    }


    static char[][] traceNoSync()
    {
        auto         dbghelp  = DbgHelp.get();
        auto         hThread  = GetCurrentThread();
        auto         hProcess = GetCurrentProcess();
        STACKFRAME64 stackframe;
        DWORD        imageType;
        char[][]     trace;
        CONTEXT      c;

        c.ContextFlags = CONTEXT_FULL;
        RtlCaptureContext( &c );

        //x86
        imageType                   = IMAGE_FILE_MACHINE_I386;
        stackframe.AddrPC.Offset    = cast(DWORD64) c.Eip;
        stackframe.AddrPC.Mode      = ADDRESS_MODE.AddrModeFlat;
        stackframe.AddrFrame.Offset = cast(DWORD64) c.Ebp;
        stackframe.AddrFrame.Mode   = ADDRESS_MODE.AddrModeFlat;
        stackframe.AddrStack.Offset = cast(DWORD64) c.Esp;
        stackframe.AddrStack.Mode   = ADDRESS_MODE.AddrModeFlat;

        static struct BufSymbol
        {
        align(1):
            IMAGEHLP_SYMBOL64 _base;
            TCHAR[1024] _buf;
        }
        BufSymbol bufSymbol=void;
        auto symbol = &bufSymbol._base;
        symbol.SizeOfStruct = IMAGEHLP_SYMBOL64.sizeof;
        symbol.MaxNameLength = bufSymbol._buf.length;

        IMAGEHLP_LINE64 line=void;
        line.SizeOfStruct = IMAGEHLP_LINE64.sizeof;

        debug(PRINTF) printf("Callstack:\n");
        for( int frameNum = 0; ; frameNum++ )
        {
            if( dbghelp.StackWalk64( imageType,
                                     hProcess,
                                     hThread,
                                     &stackframe,
                                     &c,
                                     null,
                                     cast(FunctionTableAccessProc64) dbghelp.SymFunctionTableAccess64,
                                     cast(GetModuleBaseProc64) dbghelp.SymGetModuleBase64,
                                     null) != TRUE )
            {
                debug(PRINTF) printf("End of Callstack\n");
                break;
            }

            if( stackframe.AddrPC.Offset == stackframe.AddrReturn.Offset )
            {
                debug(PRINTF) printf("Endless callstack\n");
                trace ~= "...".dup;
                break;
            }

            if( stackframe.AddrPC.Offset != 0 )
            {
                import core.stdc.stdio : snprintf;

                immutable pc = stackframe.AddrPC.Offset;
                if (dbghelp.SymGetSymFromAddr64(hProcess, pc, null, symbol) &&
                    *symbol.Name.ptr)
                {
                    auto symName = (cast(char*)symbol.Name.ptr)[0 .. strlen(symbol.Name.ptr)];
                    char[2048] demangleBuf=void;
                    symName = demangle(symName, demangleBuf);

                    DWORD disp;
                    if (dbghelp.SymGetLineFromAddr64(hProcess, pc, &disp, &line))
                    {
                        char[11] numBuf=void;
                        static assert(is(typeof(line.LineNumber) == uint));
                        immutable len = snprintf(numBuf.ptr, numBuf.length,
                                                 "%u", line.LineNumber);
                        len < numBuf.length || assert(0);
                        trace ~= symName.dup ~ " at " ~
                            line.FileName[0 .. strlen(line.FileName)] ~
                            "(" ~ numBuf[0 .. len] ~ ")";
                    }
                    else
                        trace ~= symName.dup;
                }
                else
                {
                    char[2+2*size_t.sizeof+1] numBuf=void;
                    immutable len = snprintf(numBuf.ptr, numBuf.length,
                                             "0x%p", cast(void*)pc);
                    len < numBuf.length || assert(0);
                    trace ~= numBuf[0 .. len].dup;
                }
            }
        }
        return trace;
    }
}


// For unknown reasons dbghelp.dll fails to load dmd's embedded
// CodeView information if an explicit base address is specified.
// As a workaround we reload any module without debug information.
extern(Windows) BOOL CodeViewFixup(PCSTR ModuleName, DWORD64 BaseOfDll, PVOID)
{
    auto dbghelp = DbgHelp.get();
    auto hProcess = GetCurrentProcess();

    IMAGEHLP_MODULE64 moduleInfo;
    moduleInfo.SizeOfStruct = IMAGEHLP_MODULE64.sizeof;

    if (!dbghelp.SymGetModuleInfo64(hProcess, BaseOfDll, &moduleInfo))
        return TRUE;
    if (moduleInfo.SymType != SYM_TYPE.SymNone)
        return TRUE;

    if (!dbghelp.SymUnloadModule64(hProcess, BaseOfDll))
        return TRUE;
    auto img = moduleInfo.ImageName.ptr;
    if (!dbghelp.SymLoadModule64(hProcess, null, img, null, 0, 0))
        return TRUE;

    debug(PRINTF) printf("Reloaded symbols for %s\n", img);
    return TRUE;
}


shared static this()
{
    auto dbghelp = DbgHelp.get();

    if( dbghelp is null )
        return; // dbghelp.dll not available

    auto hProcess = GetCurrentProcess();

    auto symOptions = dbghelp.SymGetOptions();
    symOptions |= SYMOPT_LOAD_LINES;
    symOptions |= SYMOPT_FAIL_CRITICAL_ERRORS;
    symOptions  = dbghelp.SymSetOptions( symOptions );

    if (!dbghelp.SymInitialize(hProcess, null, TRUE))
        return;

    dbghelp.SymEnumerateModules64(hProcess, &CodeViewFixup, null);

    initialized = true;
}
