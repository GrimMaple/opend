module std.internal.unicode_norm;
import std.internal.unicode_tables;

package(std):


static if (size_t.sizeof == 4)
{
//1728 bytes
enum nfcQCTrieEntries = TrieEntry!(bool, 8, 5, 8)([ 0x0,  0x40,  0xc0], [ 0x100,  0x100,  0x1e00], [ 0x2020100,  0x3020202,  0x2020204,  0x2050202,  0x2020202,  0x6020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x10000,  0x0,  0x2,  0x30000,  0x50004,  0x70006,  0x80000,  0xa0009,  0x0,  0x0,  0x0,  0x0,  0xb0000,  0x0,  0xc0000,  0xe000d,  0xf0000,  0x0,  0x0,  0x0,  0x10,  0x0,  0x0,  0x11,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x120000,  0x140013,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x160015,  0x170000,  0x190018,  0x0,  0x1a0000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x1b0000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x120012,  0x1c,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x81a9fdf,  0x10361f8,  0x3f,  0x40100000,  0x80,  0x0,  0x0,  0x0,  0x0,  0x0,  0x380000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x10000000,  0xff000000,  0x0,  0x0,  0x40000000,  0xb0800000,  0x0,  0x0,  0x480000,  0x4e000000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x40000000,  0x30c00000,  0x0,  0x0,  0x40000000,  0x800000,  0x0,  0x0,  0x0,  0x400000,  0x0,  0x0,  0x0,  0x600004,  0x0,  0x0,  0x40000000,  0x800000,  0x0,  0x0,  0x0,  0x80008400,  0x0,  0x0,  0x0,  0x10842008,  0x1680200,  0x20080002,  0x2001084,  0x0,  0x0,  0x0,  0x4000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x3ffffe,  0x0,  0xffffff00,  0x7,  0x0,  0x0,  0x200000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x2aaa0000,  0x0,  0x48000000,  0x8080a00,  0x2a00c808,  0x3,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0xc40,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x600,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x10000000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x6000000,  0x0,  0x0,  0x0,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0x7fe53fff,  0xfffffc65,  0xffffffff,  0xffff3fff,  0xffffffff,  0xffffffff,  0x3ffffff,  0x0,  0xa0000000,  0x5f7ffc00,  0x7fdb,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x4000000,  0x0,  0x0,  0x0,  0x80,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x40000000,  0x800000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x24010000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x8000,  0x0,  0x0,  0x0,  0x10000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0xc0000000,  0x1f,  0x0,  0xf8000000,  0x1,  0x0,  0x3fffffff,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0]);
//2048 bytes
enum nfdQCTrieEntries = TrieEntry!(bool, 8, 5, 8)([ 0x0,  0x40,  0xe0], [ 0x100,  0x140,  0x2400], [ 0x2020100,  0x5040302,  0x2020206,  0x2070202,  0x2020202,  0x8020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x10000,  0x30002,  0x50004,  0x50006,  0x70005,  0x90008,  0xb000a,  0xc0005,  0x5000d,  0x50005,  0x50005,  0x50005,  0x50005,  0xe0005,  0x50005,  0x10000f,  0x120011,  0x140013,  0x50005,  0x50005,  0x50005,  0x50015,  0x50005,  0x50005,  0x50016,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x170017,  0x170017,  0x170017,  0x170017,  0x170017,  0x170017,  0x170017,  0x170017,  0x170017,  0x170017,  0x170017,  0x170017,  0x170017,  0x170017,  0x170017,  0x170017,  0x170017,  0x170017,  0x170017,  0x170017,  0x170017,  0x180017,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x170005,  0x1a0019,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x1c001b,  0x1d0005,  0x1f001e,  0x50005,  0x200005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x210005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x170017,  0x50022,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x50005,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x3e7effbf,  0xbe7effbf,  0xfffcffff,  0x7ef1ff3f,  0xfff3f1f8,  0x7fffff3f,  0x0,  0x18003,  0xdfffe000,  0xff31ffcf,  0xcfffffff,  0xfffc0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x1b,  0x40100000,  0x1d7e0,  0x1fc00,  0x187c00,  0x0,  0x200708b,  0x2000000,  0x708b0000,  0xc00000,  0x0,  0x0,  0xfccf0006,  0x33ffcfc,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x7c,  0x0,  0x0,  0x0,  0x0,  0x80005,  0x0,  0x0,  0x120200,  0xff000000,  0x0,  0x0,  0x0,  0xb0001800,  0x0,  0x0,  0x480000,  0x4e000000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x30001900,  0x0,  0x100000,  0x0,  0x1c00,  0x0,  0x0,  0x0,  0x100,  0x0,  0x0,  0x0,  0xd81,  0x0,  0x0,  0x0,  0x1c00,  0x0,  0x0,  0x0,  0x74000000,  0x0,  0x0,  0x0,  0x10842008,  0x1680200,  0x20080002,  0x2001084,  0x0,  0x0,  0x0,  0x40,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x45540,  0x28000000,  0xb,  0x0,  0x0,  0x0,  0x0,  0x0,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xbffffff,  0xffffffff,  0xffffffff,  0x3ffffff,  0x3f3fffff,  0xffffffff,  0xaaff3f3f,  0x3fffffff,  0xffffffff,  0x5fdfffff,  0xefcfffde,  0x3fdcffff,  0x3,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0xc40,  0x0,  0x0,  0xc000000,  0x4000,  0xe000,  0x0,  0x1210,  0x50,  0x292,  0x333e005,  0x333,  0xf000,  0x0,  0x3c0f,  0x0,  0x600,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x10000000,  0x0,  0x0,  0x0,  0x55555000,  0x36db02a5,  0x40100000,  0x55555000,  0x36db02a5,  0x47900000,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xf,  0x0,  0x0,  0x7fe53fff,  0xfffffc65,  0xffffffff,  0xffff3fff,  0xffffffff,  0xffffffff,  0x3ffffff,  0x0,  0xa0000000,  0x5f7ffc00,  0x7fdb,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x14000000,  0x800,  0x0,  0x0,  0x0,  0xc000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x1800,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x58000000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0xc000000,  0x0,  0x0,  0x0,  0x1000000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0xc0000000,  0x1f,  0x0,  0xf8000000,  0x1,  0x0,  0x3fffffff,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0]);
//2848 bytes
enum nfkcQCTrieEntries = TrieEntry!(bool, 8, 5, 8)([ 0x0,  0x40,  0xe0], [ 0x100,  0x140,  0x3d00], [ 0x2020100,  0x4020302,  0x2020205,  0x7060202,  0x2020202,  0x8020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x10000,  0x30002,  0x50004,  0x40006,  0x70004,  0x90008,  0xb000a,  0xd000c,  0xf000e,  0x40004,  0x40004,  0x40004,  0x40004,  0x100004,  0x110004,  0x130012,  0x150014,  0x170016,  0x40018,  0x40004,  0x40004,  0x40019,  0x1b001a,  0x1d001c,  0x1f001e,  0x210020,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x230022,  0x40004,  0x240004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x210004,  0x260025,  0x270021,  0x290028,  0x40004,  0x40004,  0x40004,  0x2a0004,  0x40004,  0x40004,  0x40004,  0x40004,  0x2c002b,  0x2d0004,  0x2f002e,  0x40004,  0x300004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x310004,  0x40004,  0x330032,  0x350034,  0x40004,  0x40004,  0x40004,  0x40004,  0x40036,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40037,  0x380004,  0x40039,  0x40004,  0x40004,  0x40004,  0x3a0004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x210021,  0x4003b,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x40004,  0x0,  0x0,  0x0,  0x0,  0x0,  0x773c8501,  0x0,  0x0,  0x0,  0x800c0000,  0x201,  0x80000000,  0x0,  0x0,  0x1ff0,  0xe0000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x1ff0000,  0x3f000000,  0x1f,  0x81a9fdf,  0x10361f8,  0x3f,  0x44100000,  0xb0,  0x0,  0x7f0000,  0x2370000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x80,  0x0,  0x0,  0x0,  0x0,  0x0,  0x380000,  0x1e00000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x10000000,  0xff000000,  0x0,  0x0,  0x40000000,  0xb0800000,  0x0,  0x0,  0x480000,  0x4e000000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x40000000,  0x30c00000,  0x0,  0x0,  0x40000000,  0x800000,  0x0,  0x0,  0x0,  0x400000,  0x0,  0x0,  0x0,  0x600004,  0x0,  0x0,  0x40000000,  0x800000,  0x0,  0x0,  0x0,  0x80008400,  0x0,  0x0,  0x80000,  0x0,  0x0,  0x0,  0x80000,  0x30000000,  0x0,  0x1000,  0x0,  0x10842008,  0x3e80200,  0x20080002,  0x2001084,  0x0,  0x0,  0x0,  0x4000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x10000000,  0x0,  0x0,  0x0,  0x3ffffe,  0x0,  0xffffff00,  0x7,  0x0,  0x0,  0x200000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0xf7ff7000,  0xffffbfff,  0x10007ff,  0xf8000000,  0xffffffff,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0xc000000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x2aaa0000,  0x0,  0xe8000000,  0xe808ea03,  0x6a00e808,  0x8207ff,  0x50d88070,  0x80800380,  0xfff30000,  0x1fff7fff,  0x100,  0x0,  0x0,  0x3e6ffeef,  0xfbfbbd57,  0xffff03e1,  0xffffffff,  0x200,  0x0,  0x0,  0x0,  0x0,  0x1b000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x600,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0x7ff,  0x1000,  0x0,  0x0,  0x700000,  0x0,  0x0,  0x10000000,  0x0,  0x0,  0x0,  0x0,  0x30000000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x8000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x80000000,  0x0,  0x0,  0x80000,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0x3fffff,  0x0,  0x1,  0x7400000,  0x0,  0x0,  0x9e000000,  0x0,  0x0,  0x80000000,  0x0,  0xfffe0000,  0xffffffff,  0xffffffff,  0xfffc7fff,  0x0,  0x0,  0x0,  0x7fffffff,  0xffffffff,  0xffff00ff,  0x7fffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0x0,  0x0,  0x0,  0x0,  0x30000000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x10000,  0x0,  0x0,  0x0,  0x31c0000,  0x0,  0x0,  0xf0000000,  0x200,  0x0,  0x0,  0x0,  0x0,  0x7fe53fff,  0xfffffc65,  0xffffffff,  0xffff3fff,  0xffffffff,  0xffffffff,  0x3ffffff,  0x0,  0xa0f8007f,  0x5f7fffff,  0xffffffdb,  0xffffffff,  0xffffffff,  0x3ffff,  0xfff80000,  0xffffffff,  0xffffffff,  0x3fffffff,  0xffff0000,  0xffffffff,  0xfffcffff,  0xffffffff,  0xff,  0x1fff0000,  0x3ff0000,  0xffff0000,  0xfff7ff9f,  0xffd70f7f,  0xffffffff,  0xffffffff,  0xffffffff,  0x1fffffff,  0xfffffffe,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0x7fffffff,  0x1cfcfcfc,  0x7f7f,  0x0,  0x0,  0x0,  0x0,  0xffffffbe,  0x7fdffff,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x4000000,  0x0,  0x0,  0x0,  0x80,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x40000000,  0x800000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x24010000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x8000,  0x0,  0x0,  0x0,  0x10000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0xc0000000,  0x1f,  0x0,  0xf8000000,  0x1,  0x0,  0xffffffff,  0xffffffff,  0xffdfffff,  0xffffffff,  0xdfffffff,  0xebffde64,  0xffffffef,  0xffffffff,  0xdfdfe7bf,  0x7bffffff,  0xfffdfc5f,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffff3f,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffcfff,  0xffffffff,  0x0,  0xffff0000,  0xffffffff,  0x3fff,  0x0,  0x0,  0x0,  0x0,  0xffffffef,  0xaf7fe96,  0xaa96ea84,  0x5ef7f796,  0xffffbff,  0xffffbee,  0x0,  0x0,  0xffff07ff,  0xffff7fff,  0xffff,  0x1c00,  0x10000,  0x0,  0x0,  0x0,  0xffff0007,  0xfffffff,  0x301ff,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x3ff0000,  0x3fffffff,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0]);
//2944 bytes
enum nfkdQCTrieEntries = TrieEntry!(bool, 8, 5, 8)([ 0x0,  0x40,  0xf0], [ 0x100,  0x160,  0x3e00], [ 0x2020100,  0x5040302,  0x2020206,  0x8070202,  0x2020202,  0x9020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x2020202,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x10000,  0x30002,  0x50004,  0x70006,  0x80007,  0xa0009,  0xc000b,  0xe000d,  0x7000f,  0x70007,  0x70007,  0x70007,  0x70007,  0x100007,  0x110007,  0x130012,  0x150014,  0x170016,  0x70018,  0x70007,  0x70007,  0x70019,  0x1b001a,  0x1d001c,  0x1f001e,  0x210020,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x230022,  0x70007,  0x240007,  0x210021,  0x210021,  0x210021,  0x210021,  0x210021,  0x210021,  0x210021,  0x210021,  0x210021,  0x210021,  0x210021,  0x210021,  0x210021,  0x210021,  0x210021,  0x210021,  0x210021,  0x210021,  0x210021,  0x210021,  0x210021,  0x250021,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x210007,  0x270026,  0x280021,  0x2a0029,  0x70007,  0x70007,  0x70007,  0x2b0007,  0x70007,  0x70007,  0x70007,  0x70007,  0x2d002c,  0x2e0007,  0x30002f,  0x70007,  0x310007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x320007,  0x70007,  0x340033,  0x360035,  0x70007,  0x70007,  0x70007,  0x70007,  0x70037,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70038,  0x390007,  0x7003a,  0x70007,  0x70007,  0x70007,  0x3b0007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x210021,  0x7003c,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x70007,  0x0,  0x0,  0x0,  0x0,  0x0,  0x773c8501,  0x3e7effbf,  0xbe7effbf,  0xfffcffff,  0xfefdff3f,  0xfff3f3f9,  0xffffff3f,  0x0,  0x18003,  0xdffffff0,  0xff3fffcf,  0xcfffffff,  0xfffc0,  0x0,  0x0,  0x0,  0x1ff0000,  0x3f000000,  0x1f,  0x0,  0x0,  0x1b,  0x44100000,  0x1d7f0,  0x1fc00,  0x7f7c00,  0x2370000,  0x200708b,  0x2000000,  0x708b0000,  0xc00000,  0x0,  0x0,  0xfccf0006,  0x33ffcfc,  0x0,  0x0,  0x0,  0x0,  0x80,  0x0,  0x0,  0x0,  0x0,  0x7c,  0x0,  0x1e00000,  0x0,  0x0,  0x80005,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x120200,  0xff000000,  0x0,  0x0,  0x0,  0xb0001800,  0x0,  0x0,  0x480000,  0x4e000000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x30001900,  0x0,  0x100000,  0x0,  0x1c00,  0x0,  0x0,  0x0,  0x100,  0x0,  0x0,  0x0,  0xd81,  0x0,  0x0,  0x0,  0x1c00,  0x0,  0x0,  0x0,  0x74000000,  0x0,  0x0,  0x80000,  0x0,  0x0,  0x0,  0x80000,  0x30000000,  0x0,  0x1000,  0x0,  0x10842008,  0x3e80200,  0x20080002,  0x2001084,  0x0,  0x0,  0x0,  0x40,  0x0,  0x0,  0x0,  0x0,  0x0,  0x10000000,  0x45540,  0x28000000,  0xb,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0xf7ff7000,  0xffffbfff,  0x10007ff,  0xf8000000,  0xffffffff,  0x0,  0x0,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xfffffff,  0xffffffff,  0xffffffff,  0x3ffffff,  0x3f3fffff,  0xffffffff,  0xaaff3f3f,  0x3fffffff,  0xffffffff,  0xffdfffff,  0xefcfffdf,  0x7fdcffff,  0x8207ff,  0x50d88070,  0x80800380,  0xfff30000,  0x1fff7fff,  0x100,  0x0,  0x0,  0x3e6ffeef,  0xfbfbbd57,  0xffff03e1,  0xffffffff,  0xc000200,  0x4000,  0xe000,  0x0,  0x1210,  0x1b050,  0x292,  0x333e005,  0x333,  0xf000,  0x0,  0x3c0f,  0x0,  0x600,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0x7ff,  0x1000,  0x0,  0x0,  0x700000,  0x0,  0x0,  0x10000000,  0x0,  0x0,  0x0,  0x0,  0x30000000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x8000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x80000000,  0x0,  0x0,  0x80000,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0x3fffff,  0x0,  0x1,  0x7400000,  0x55555000,  0x36db02a5,  0xd8100000,  0x55555000,  0x36db02a5,  0xc7900000,  0x0,  0xfffe0000,  0xffffffff,  0xffffffff,  0xfffc7fff,  0x0,  0x0,  0x0,  0x7fffffff,  0xffffffff,  0xffff00ff,  0x7fffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0x0,  0x0,  0x0,  0x0,  0x30000000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x10000,  0x0,  0x0,  0x0,  0x31c0000,  0x0,  0x0,  0xf0000000,  0x200,  0x0,  0x0,  0x0,  0x0,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xf,  0x0,  0x0,  0x7fe53fff,  0xfffffc65,  0xffffffff,  0xffff3fff,  0xffffffff,  0xffffffff,  0x3ffffff,  0x0,  0xa0f8007f,  0x5f7fffff,  0xffffffdb,  0xffffffff,  0xffffffff,  0x3ffff,  0xfff80000,  0xffffffff,  0xffffffff,  0x3fffffff,  0xffff0000,  0xffffffff,  0xfffcffff,  0xffffffff,  0xff,  0x1fff0000,  0x3ff0000,  0xffff0000,  0xfff7ff9f,  0xffd70f7f,  0xffffffff,  0xffffffff,  0xffffffff,  0x1fffffff,  0xfffffffe,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0x7fffffff,  0x1cfcfcfc,  0x7f7f,  0x0,  0x0,  0x0,  0x0,  0xffffffbe,  0x7fdffff,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x14000000,  0x800,  0x0,  0x0,  0x0,  0xc000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x1800,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x58000000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0xc000000,  0x0,  0x0,  0x0,  0x1000000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0xc0000000,  0x1f,  0x0,  0xf8000000,  0x1,  0x0,  0xffffffff,  0xffffffff,  0xffdfffff,  0xffffffff,  0xdfffffff,  0xebffde64,  0xffffffef,  0xffffffff,  0xdfdfe7bf,  0x7bffffff,  0xfffdfc5f,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffff3f,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffffff,  0xffffcfff,  0xffffffff,  0x0,  0xffff0000,  0xffffffff,  0x3fff,  0x0,  0x0,  0x0,  0x0,  0xffffffef,  0xaf7fe96,  0xaa96ea84,  0x5ef7f796,  0xffffbff,  0xffffbee,  0x0,  0x0,  0xffff07ff,  0xffff7fff,  0xffff,  0x1c00,  0x10000,  0x0,  0x0,  0x0,  0xffff0007,  0xfffffff,  0x301ff,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x3ff0000,  0x3fffffff,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0]);

}


static if (size_t.sizeof == 8)
{
//1728 bytes
enum nfcQCTrieEntries = TrieEntry!(bool, 8, 5, 8)([ 0x0,  0x20,  0x60], [ 0x100,  0x100,  0x1e00], [ 0x302020202020100,  0x205020202020204,  0x602020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x1000000000000,  0x200000000,  0x5000400030000,  0x8000000070006,  0xa0009,  0x0,  0xb000000000000,  0xc000000000000,  0xf0000000e000d,  0x0,  0x1000000000,  0x0,  0x11,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x14001300120000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x17000000160015,  0x190018,  0x1a0000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x1b0000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x1c00120012,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x10361f8081a9fdf,  0x401000000000003f,  0x80,  0x0,  0x0,  0x380000,  0x0,  0x0,  0x1000000000000000,  0xff000000,  0x4000000000000000,  0xb0800000,  0x48000000000000,  0x4e000000,  0x0,  0x0,  0x4000000000000000,  0x30c00000,  0x4000000000000000,  0x800000,  0x0,  0x400000,  0x0,  0x600004,  0x4000000000000000,  0x800000,  0x0,  0x80008400,  0x0,  0x168020010842008,  0x200108420080002,  0x0,  0x400000000000,  0x0,  0x0,  0x0,  0x0,  0x3ffffe00000000,  0xffffff0000000000,  0x7,  0x20000000000000,  0x0,  0x0,  0x0,  0x0,  0x2aaa000000000000,  0x4800000000000000,  0x2a00c80808080a00,  0x3,  0x0,  0x0,  0x0,  0xc4000000000,  0x0,  0x0,  0x0,  0x60000000000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x10000000,  0x0,  0x0,  0x6000000,  0x0,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xfffffc657fe53fff,  0xffff3fffffffffff,  0xffffffffffffffff,  0x3ffffff,  0x5f7ffc00a0000000,  0x7fdb,  0x0,  0x0,  0x0,  0x0,  0x400000000000000,  0x0,  0x8000000000,  0x0,  0x0,  0x0,  0x4000000000000000,  0x800000,  0x0,  0x0,  0x0,  0x0,  0x2401000000000000,  0x0,  0x0,  0x0,  0x800000000000,  0x0,  0x1000000000000,  0x0,  0x0,  0x0,  0x0,  0x1fc0000000,  0xf800000000000000,  0x1,  0x3fffffff,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0]);
//2048 bytes
enum nfdQCTrieEntries = TrieEntry!(bool, 8, 5, 8)([ 0x0,  0x20,  0x70], [ 0x100,  0x140,  0x2400], [ 0x504030202020100,  0x207020202020206,  0x802020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x3000200010000,  0x5000600050004,  0x9000800070005,  0xc0005000b000a,  0x500050005000d,  0x5000500050005,  0xe000500050005,  0x10000f00050005,  0x14001300120011,  0x5000500050005,  0x5001500050005,  0x5000500050005,  0x5000500050016,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x17001700170017,  0x17001700170017,  0x17001700170017,  0x17001700170017,  0x17001700170017,  0x17001700170017,  0x17001700170017,  0x17001700170017,  0x17001700170017,  0x17001700170017,  0x18001700170017,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x1a001900170005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x1d0005001c001b,  0x50005001f001e,  0x5000500200005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500210005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5002200170017,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x5000500050005,  0x0,  0x0,  0x0,  0xbe7effbf3e7effbf,  0x7ef1ff3ffffcffff,  0x7fffff3ffff3f1f8,  0x1800300000000,  0xff31ffcfdfffe000,  0xfffc0cfffffff,  0x0,  0x0,  0x0,  0x0,  0x401000000000001b,  0x1fc000001d7e0,  0x187c00,  0x20000000200708b,  0xc00000708b0000,  0x0,  0x33ffcfcfccf0006,  0x0,  0x0,  0x0,  0x0,  0x7c00000000,  0x0,  0x0,  0x80005,  0x12020000000000,  0xff000000,  0x0,  0xb0001800,  0x48000000000000,  0x4e000000,  0x0,  0x0,  0x0,  0x30001900,  0x100000,  0x1c00,  0x0,  0x100,  0x0,  0xd81,  0x0,  0x1c00,  0x0,  0x74000000,  0x0,  0x168020010842008,  0x200108420080002,  0x0,  0x4000000000,  0x0,  0x0,  0x0,  0x2800000000045540,  0xb,  0x0,  0x0,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffff0bffffff,  0x3ffffffffffffff,  0xffffffff3f3fffff,  0x3fffffffaaff3f3f,  0x5fdfffffffffffff,  0x3fdcffffefcfffde,  0x3,  0x0,  0x0,  0x0,  0xc4000000000,  0x0,  0x40000c000000,  0xe000,  0x5000001210,  0x333e00500000292,  0xf00000000333,  0x3c0f00000000,  0x60000000000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x10000000,  0x0,  0x36db02a555555000,  0x5555500040100000,  0x4790000036db02a5,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xfffffffff,  0x0,  0xfffffc657fe53fff,  0xffff3fffffffffff,  0xffffffffffffffff,  0x3ffffff,  0x5f7ffc00a0000000,  0x7fdb,  0x0,  0x0,  0x0,  0x0,  0x80014000000,  0x0,  0xc00000000000,  0x0,  0x0,  0x0,  0x0,  0x1800,  0x0,  0x0,  0x0,  0x0,  0x5800000000000000,  0x0,  0x0,  0x0,  0xc00000000000000,  0x0,  0x100000000000000,  0x0,  0x0,  0x0,  0x0,  0x1fc0000000,  0xf800000000000000,  0x1,  0x3fffffff,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0]);
//2848 bytes
enum nfkcQCTrieEntries = TrieEntry!(bool, 8, 5, 8)([ 0x0,  0x20,  0x70], [ 0x100,  0x140,  0x3d00], [ 0x402030202020100,  0x706020202020205,  0x802020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x3000200010000,  0x4000600050004,  0x9000800070004,  0xd000c000b000a,  0x40004000f000e,  0x4000400040004,  0x10000400040004,  0x13001200110004,  0x17001600150014,  0x4000400040018,  0x4001900040004,  0x1d001c001b001a,  0x210020001f001e,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x23002200040004,  0x24000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x26002500210004,  0x29002800270021,  0x4000400040004,  0x2a000400040004,  0x4000400040004,  0x4000400040004,  0x2d0004002c002b,  0x40004002f002e,  0x4000400300004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400310004,  0x35003400330032,  0x4000400040004,  0x4000400040004,  0x4000400040036,  0x4000400040004,  0x4000400040004,  0x4003700040004,  0x4003900380004,  0x4000400040004,  0x3a000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4003b00210021,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x4000400040004,  0x0,  0x0,  0x773c850100000000,  0x0,  0x800c000000000000,  0x8000000000000201,  0x0,  0xe000000001ff0,  0x0,  0x0,  0x1ff000000000000,  0x1f3f000000,  0x10361f8081a9fdf,  0x441000000000003f,  0xb0,  0x2370000007f0000,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x80,  0x0,  0x0,  0x1e0000000380000,  0x0,  0x0,  0x1000000000000000,  0xff000000,  0x4000000000000000,  0xb0800000,  0x48000000000000,  0x4e000000,  0x0,  0x0,  0x4000000000000000,  0x30c00000,  0x4000000000000000,  0x800000,  0x0,  0x400000,  0x0,  0x600004,  0x4000000000000000,  0x800000,  0x0,  0x80008400,  0x8000000000000,  0x0,  0x8000000000000,  0x30000000,  0x1000,  0x3e8020010842008,  0x200108420080002,  0x0,  0x400000000000,  0x0,  0x0,  0x1000000000000000,  0x0,  0x3ffffe00000000,  0xffffff0000000000,  0x7,  0x20000000000000,  0x0,  0x0,  0x0,  0xf7ff700000000000,  0x10007ffffffbfff,  0xfffffffff8000000,  0x0,  0x0,  0x0,  0xc000000,  0x0,  0x0,  0x2aaa000000000000,  0xe800000000000000,  0x6a00e808e808ea03,  0x50d88070008207ff,  0xfff3000080800380,  0x1001fff7fff,  0x0,  0xfbfbbd573e6ffeef,  0xffffffffffff03e1,  0x200,  0x0,  0x1b00000000000,  0x0,  0x0,  0x0,  0x60000000000,  0x0,  0x0,  0x0,  0x0,  0xffffffff00000000,  0xffffffffffffffff,  0x7ffffffffff,  0x1000,  0x70000000000000,  0x0,  0x10000000,  0x0,  0x3000000000000000,  0x0,  0x0,  0x0,  0x800000000000,  0x0,  0x0,  0x0,  0x0,  0x80000000,  0x8000000000000,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0x3fffff,  0x740000000000001,  0x0,  0x9e000000,  0x8000000000000000,  0xfffe000000000000,  0xffffffffffffffff,  0xfffc7fff,  0x0,  0xffffffff7fffffff,  0x7fffffffffff00ff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0x0,  0x0,  0x30000000,  0x0,  0x0,  0x1000000000000,  0x0,  0x31c000000000000,  0x0,  0x200f0000000,  0x0,  0x0,  0xfffffc657fe53fff,  0xffff3fffffffffff,  0xffffffffffffffff,  0x3ffffff,  0x5f7fffffa0f8007f,  0xffffffffffffffdb,  0x3ffffffffffff,  0xfffffffffff80000,  0x3fffffffffffffff,  0xffffffffffff0000,  0xfffffffffffcffff,  0x1fff0000000000ff,  0xffff000003ff0000,  0xffd70f7ffff7ff9f,  0xffffffffffffffff,  0x1fffffffffffffff,  0xfffffffffffffffe,  0xffffffffffffffff,  0x7fffffffffffffff,  0x7f7f1cfcfcfc,  0x0,  0x0,  0x7fdffffffffffbe,  0x0,  0x0,  0x0,  0x400000000000000,  0x0,  0x8000000000,  0x0,  0x0,  0x0,  0x4000000000000000,  0x800000,  0x0,  0x0,  0x0,  0x0,  0x2401000000000000,  0x0,  0x0,  0x0,  0x800000000000,  0x0,  0x1000000000000,  0x0,  0x0,  0x0,  0x0,  0x1fc0000000,  0xf800000000000000,  0x1,  0xffffffffffffffff,  0xffffffffffdfffff,  0xebffde64dfffffff,  0xffffffffffffffef,  0x7bffffffdfdfe7bf,  0xfffffffffffdfc5f,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffff3fffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffcfff,  0xffff000000000000,  0x3fffffffffff,  0x0,  0x0,  0xaf7fe96ffffffef,  0x5ef7f796aa96ea84,  0xffffbee0ffffbff,  0x0,  0xffff7fffffff07ff,  0x1c000000ffff,  0x10000,  0x0,  0xfffffffffff0007,  0x301ff,  0x0,  0x0,  0x0,  0x0,  0x0,  0x3ff000000000000,  0x3fffffff,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0]);
//2944 bytes
enum nfkdQCTrieEntries = TrieEntry!(bool, 8, 5, 8)([ 0x0,  0x20,  0x78], [ 0x100,  0x160,  0x3e00], [ 0x504030202020100,  0x807020202020206,  0x902020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x202020202020202,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x3000200010000,  0x7000600050004,  0xa000900080007,  0xe000d000c000b,  0x700070007000f,  0x7000700070007,  0x10000700070007,  0x13001200110007,  0x17001600150014,  0x7000700070018,  0x7001900070007,  0x1d001c001b001a,  0x210020001f001e,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x23002200070007,  0x24000700070007,  0x21002100210021,  0x21002100210021,  0x21002100210021,  0x21002100210021,  0x21002100210021,  0x21002100210021,  0x21002100210021,  0x21002100210021,  0x21002100210021,  0x21002100210021,  0x25002100210021,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x27002600210007,  0x2a002900280021,  0x7000700070007,  0x2b000700070007,  0x7000700070007,  0x7000700070007,  0x2e0007002d002c,  0x700070030002f,  0x7000700310007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700320007,  0x36003500340033,  0x7000700070007,  0x7000700070007,  0x7000700070037,  0x7000700070007,  0x7000700070007,  0x7003800070007,  0x7003a00390007,  0x7000700070007,  0x3b000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7003c00210021,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x7000700070007,  0x0,  0x0,  0x773c850100000000,  0xbe7effbf3e7effbf,  0xfefdff3ffffcffff,  0xffffff3ffff3f3f9,  0x1800300000000,  0xff3fffcfdffffff0,  0xfffc0cfffffff,  0x0,  0x1ff000000000000,  0x1f3f000000,  0x0,  0x441000000000001b,  0x1fc000001d7f0,  0x2370000007f7c00,  0x20000000200708b,  0xc00000708b0000,  0x0,  0x33ffcfcfccf0006,  0x0,  0x0,  0x80,  0x0,  0x7c00000000,  0x1e0000000000000,  0x0,  0x80005,  0x0,  0x0,  0x0,  0x0,  0x12020000000000,  0xff000000,  0x0,  0xb0001800,  0x48000000000000,  0x4e000000,  0x0,  0x0,  0x0,  0x30001900,  0x100000,  0x1c00,  0x0,  0x100,  0x0,  0xd81,  0x0,  0x1c00,  0x0,  0x74000000,  0x8000000000000,  0x0,  0x8000000000000,  0x30000000,  0x1000,  0x3e8020010842008,  0x200108420080002,  0x0,  0x4000000000,  0x0,  0x0,  0x1000000000000000,  0x2800000000045540,  0xb,  0x0,  0x0,  0xf7ff700000000000,  0x10007ffffffbfff,  0xfffffffff8000000,  0x0,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffff0fffffff,  0x3ffffffffffffff,  0xffffffff3f3fffff,  0x3fffffffaaff3f3f,  0xffdfffffffffffff,  0x7fdcffffefcfffdf,  0x50d88070008207ff,  0xfff3000080800380,  0x1001fff7fff,  0x0,  0xfbfbbd573e6ffeef,  0xffffffffffff03e1,  0x40000c000200,  0xe000,  0x1b05000001210,  0x333e00500000292,  0xf00000000333,  0x3c0f00000000,  0x60000000000,  0x0,  0x0,  0x0,  0x0,  0xffffffff00000000,  0xffffffffffffffff,  0x7ffffffffff,  0x1000,  0x70000000000000,  0x0,  0x10000000,  0x0,  0x3000000000000000,  0x0,  0x0,  0x0,  0x800000000000,  0x0,  0x0,  0x0,  0x0,  0x80000000,  0x8000000000000,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0x3fffff,  0x740000000000001,  0x36db02a555555000,  0x55555000d8100000,  0xc790000036db02a5,  0xfffe000000000000,  0xffffffffffffffff,  0xfffc7fff,  0x0,  0xffffffff7fffffff,  0x7fffffffffff00ff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0x0,  0x0,  0x30000000,  0x0,  0x0,  0x1000000000000,  0x0,  0x31c000000000000,  0x0,  0x200f0000000,  0x0,  0x0,  0xffffffffffffffff,  0xffffffffffffffff,  0xfffffffff,  0x0,  0xfffffc657fe53fff,  0xffff3fffffffffff,  0xffffffffffffffff,  0x3ffffff,  0x5f7fffffa0f8007f,  0xffffffffffffffdb,  0x3ffffffffffff,  0xfffffffffff80000,  0x3fffffffffffffff,  0xffffffffffff0000,  0xfffffffffffcffff,  0x1fff0000000000ff,  0xffff000003ff0000,  0xffd70f7ffff7ff9f,  0xffffffffffffffff,  0x1fffffffffffffff,  0xfffffffffffffffe,  0xffffffffffffffff,  0x7fffffffffffffff,  0x7f7f1cfcfcfc,  0x0,  0x0,  0x7fdffffffffffbe,  0x0,  0x0,  0x0,  0x80014000000,  0x0,  0xc00000000000,  0x0,  0x0,  0x0,  0x0,  0x1800,  0x0,  0x0,  0x0,  0x0,  0x5800000000000000,  0x0,  0x0,  0x0,  0xc00000000000000,  0x0,  0x100000000000000,  0x0,  0x0,  0x0,  0x0,  0x1fc0000000,  0xf800000000000000,  0x1,  0xffffffffffffffff,  0xffffffffffdfffff,  0xebffde64dfffffff,  0xffffffffffffffef,  0x7bffffffdfdfe7bf,  0xfffffffffffdfc5f,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffff3fffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffffff,  0xffffffffffffcfff,  0xffff000000000000,  0x3fffffffffff,  0x0,  0x0,  0xaf7fe96ffffffef,  0x5ef7f796aa96ea84,  0xffffbee0ffffbff,  0x0,  0xffff7fffffff07ff,  0x1c000000ffff,  0x10000,  0x0,  0xfffffffffff0007,  0x301ff,  0x0,  0x0,  0x0,  0x0,  0x0,  0x3ff000000000000,  0x3fffffff,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0,  0x0]);

}

