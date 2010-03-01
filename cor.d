/**Pearson, Spearman and Kendall correlations, covariance.
 *
 * Author:  David Simcha*/
 /*
 * License:
 * Boost Software License - Version 1.0 - August 17th, 2003
 *
 * Permission is hereby granted, free of charge, to any person or organization
 * obtaining a copy of the software and accompanying documentation covered by
 * this license (the "Software") to use, reproduce, display, distribute,
 * execute, and transmit the Software, and to prepare derivative works of the
 * Software, and to permit third-parties to whom the Software is furnished to
 * do so, all subject to the following:
 *
 * The copyright notices in the Software and this entire statement, including
 * the above license grant, this restriction and the following disclaimer,
 * must be included in all copies of the Software, in whole or in part, and
 * all derivative works of the Software, unless such copies or derivative
 * works are solely in the form of machine-executable object code generated by
 * a source language processor.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
 * SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
 * FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

module dstats.cor;

import std.range, std.typecons, std.contracts, std.math, std.traits;

import dstats.sort, dstats.base, dstats.alloc, dstats.regress : invert;

version(unittest) {
    import std.stdio, std.random, std.algorithm : map, swap;

    Random gen;

    void main() {
        gen.seed(unpredictableSeed);
    }
}

/**Convenience function for calculating Pearson correlation.
 * When the term correlation is used unqualified, it is
 * usually referring to this quantity.  This is a parametric correlation
 * metric and should not be used with extremely ill-behaved data.
 * This function works with any pair of input ranges.  If they are of different
 * lengths, it uses the first min(input1.length, input2.length) elements.
 *
 * Note:  The PearsonCor struct returned by this function is alias this'd to the
 * correlation coefficient.  Therefore, the result from this function can
 * be treated simply as a floating point number.
 */
PearsonCor pearsonCor(T, U)(T input1, U input2)
if(doubleInput!(T) && doubleInput!(U)) {
    PearsonCor corCalc;

    static if(isArray!T && isArray!U) {
        // Common case optimization of loop, since DMD can't inline range
        // ops for arrays and it's by far the most common case.
        enforce(input1.length == input2.length,
            "Ranges must be same length for Pearson correlation.");
        foreach(i; 0..input1.length) {
            corCalc.put(input1[i], input2[i]);
        }
    } else {
        while(!input1.empty && !input2.empty) {
            corCalc.put(input1.front, input2.front);
            input1.popFront;
            input2.popFront;
        }

        enforce(input1.empty && input2.empty,
            "Ranges must be same length for Pearson correlation.");
    }

    return corCalc;
}

unittest {
    assert(approxEqual(pearsonCor([1,2,3,4,5][], [1,2,3,4,5][]).cor, 1));
    assert(approxEqual(pearsonCor([1,2,3,4,5][], [10.0, 8.0, 6.0, 4.0, 2.0][]).cor, -1));
    assert(approxEqual(pearsonCor([2, 4, 1, 6, 19][], [4, 5, 1, 3, 2][]).cor, -.2382314));

        // Make sure everything works with lowest common denominator range type.
    struct Count {
        uint num;
        uint upTo;
        uint front() {
            return num;
        }
        void popFront() {
            num++;
        }
        bool empty() {
            return num >= upTo;
        }
    }

    Count a, b;
    a.upTo = 100;
    b.upTo = 100;
    assert(approxEqual(pearsonCor(a, b).cor, 1));

    PearsonCor cor1 = pearsonCor([1,2,4][], [2,3,5][]);
    PearsonCor cor2 = pearsonCor([4,2,9][], [2,8,7][]);
    PearsonCor combined = pearsonCor([1,2,4,4,2,9][], [2,3,5,2,8,7][]);
    cor1.put(cor2);

    foreach(ti, elem; cor1.tupleof) {
        assert(approxEqual(elem, combined.tupleof[ti]));
    }

    writefln("Passed pearsonCor unittest.");
}

/**Allows computation of mean, stdev, variance, covariance, Pearson correlation online.
 * Getters for stdev, var, cov, cor cost floating point division ops.  Getters
 * for means cost a single branch to check for N == 0.  This struct uses O(1)
 * space.
 *
 * PearsonCor.cor is alias this'd, so if this struct is used as a float, it will
 * be converted to a simple correlation coefficient automatically.
 */
struct PearsonCor {
private:
    double _k = 0, _mean1 = 0, _mean2 = 0, _var1 = 0, _var2 = 0, _cov = 0;
public:
    alias cor this;

    ///
    void put(double elem1, double elem2) nothrow {
        immutable kMinus1 = _k;
        immutable kNeg1 = 1 / ++_k;
        immutable delta1 = elem1 - _mean1;
        immutable delta2 = elem2 - _mean2;
        immutable delta1N = delta1 * kNeg1;
        immutable delta2N = delta2 * kNeg1;

        _mean1 += delta1N;
        _mean2 += delta2N;
        _var1  += kMinus1 * delta1N * delta1;
        _var2  += kMinus1 * delta2N * delta2;
        _cov   += kMinus1 * delta1N * delta2;
    }

    /// Combine two PearsonCor's.
    void put(const ref typeof(this) rhs) nothrow {
        immutable totalN = _k + rhs._k;
        immutable delta1 = rhs.mean1 - mean1;
        immutable delta2 = rhs.mean2 - mean2;

        _mean1 = _mean1 * (_k / totalN) + rhs._mean1 * (rhs._k / totalN);
        _mean2 = _mean2 * (_k / totalN) + rhs._mean2 * (rhs._k / totalN);

        _var1 = _var1 + rhs._var1 + (_k / totalN * rhs._k * delta1 * delta1 );
        _var2 = _var2 + rhs._var2 + (_k / totalN * rhs._k * delta2 * delta2 );
        _cov  =  _cov + rhs._cov  + (_k / totalN * rhs._k * delta1 * delta2 );
        _k = totalN;
    }

    ///
    double var1() const pure nothrow {
        return (_k < 2) ? double.nan : _var1 / (_k - 1);
    }

    ///
    double var2() const pure nothrow {
        return (_k < 2) ? double.nan : _var2 / (_k - 1);
    }

    ///
    double stdev1() const pure nothrow {
        return sqrt(var1);
    }

    ///
    double stdev2() const pure nothrow {
        return sqrt(var2);
    }

    ///
    double cor() const pure nothrow {
        return cov / stdev1 / stdev2;
    }

    ///
    double cov() const pure nothrow {
        return (_k < 2) ? double.nan : _cov / (_k - 1);
    }

    ///
    double mean1() const pure nothrow {
        return (_k == 0) ? double.nan : _mean1;
    }

    ///
    double mean2() const pure nothrow {
        return (_k == 0) ? double.nan : _mean2;
    }

    ///
    double N() const pure nothrow {
        return _k;
    }
}

///
double covariance(T, U)(T input1, U input2)
if(doubleInput!(T) && doubleInput!(U)) {
    PearsonCor covCalc;
    while(!input1.empty && !input2.empty) {
        covCalc.put(input1.front, input2.front);
        input1.popFront;
        input2.popFront;
    }

    enforce(input1.empty && input2.empty,
        "Ranges must be same length for covariance.");
    return covCalc.cov;
}

unittest {
    assert(approxEqual(covariance([1,4,2,6,3].dup, [3,1,2,6,2].dup), 2.05));
    writeln("Passed covariance test.");
}

/**Spearman's rank correlation.  Non-parametric.  This is essentially the
 * Pearson correlation of the ranks of the data, with ties dealt with by
 * averaging.*/
double spearmanCor(R, S)(R input1, S input2)
if(isInputRange!(R) && isInputRange!(S) &&
is(typeof(input1.front < input1.front) == bool) &&
is(typeof(input2.front < input2.front) == bool)) {

    static if(dstats.base.hasLength!S && dstats.base.hasLength!R) {
        if(input1.length < 2) {
            return double.nan;
        }
    }

    mixin(newFrame);

    static double[] spearmanCorRank(T)(T someRange) {
        static if(dstats.base.hasLength!(T) && isRandomAccessRange!(T)) {
            double[] ret = newStack!(double)(someRange.length);
            rank(someRange, ret);
        } else {
            auto iDup = tempdup(someRange);
            double[] ret = newStack!(double)(iDup.length);
            rankSort(iDup, ret);
        }
        return ret;
    }

    auto ranks1 = spearmanCorRank(input1);
    auto ranks2 = spearmanCorRank(input2);
    enforce(ranks1.length == ranks2.length,
        "Ranges must be same length for Spearman correlation.");

    return pearsonCor(ranks1, ranks2).cor;
}

unittest {
    //Test against a few known values.
    assert(approxEqual(spearmanCor([1,2,3,4,5,6].dup, [3,1,2,5,4,6].dup), 0.77143));
    assert(approxEqual(spearmanCor([3,1,2,5,4,6].dup, [1,2,3,4,5,6].dup ), 0.77143));
    assert(approxEqual(spearmanCor([3,6,7,35,75].dup, [1,63,53,67,3].dup), 0.3));
    assert(approxEqual(spearmanCor([1,63,53,67,3].dup, [3,6,7,35,75].dup), 0.3));
    assert(approxEqual(spearmanCor([1.5,6.3,7.8,4.2,1.5].dup, [1,63,53,67,3].dup), .56429));
    assert(approxEqual(spearmanCor([1,63,53,67,3].dup, [1.5,6.3,7.8,4.2,1.5].dup), .56429));
    assert(approxEqual(spearmanCor([1.5,6.3,7.8,7.8,1.5].dup, [1,63,53,67,3].dup), .79057));
    assert(approxEqual(spearmanCor([1,63,53,67,3].dup, [1.5,6.3,7.8,7.8,1.5].dup), .79057));
    assert(approxEqual(spearmanCor([1.5,6.3,7.8,6.3,1.5].dup, [1,63,53,67,3].dup), .63246));
    assert(approxEqual(spearmanCor([1,63,53,67,3].dup, [1.5,6.3,7.8,6.3,1.5].dup), .63246));
    assert(approxEqual(spearmanCor([3,4,1,5,2,1,6,4].dup, [1,3,2,6,4,2,6,7].dup), .6829268));
    assert(approxEqual(spearmanCor([1,3,2,6,4,2,6,7].dup, [3,4,1,5,2,1,6,4].dup), .6829268));
    uint[] one = new uint[1000], two = new uint[1000];
    foreach(i; 0..100) {  //Further sanity checks for things like commutativity.
        size_t lowerBound = uniform(0, one.length);
        size_t upperBound = uniform(0, one.length);
        if(lowerBound > upperBound) swap(lowerBound, upperBound);
        foreach(ref o; one) {
            o = uniform(1, 10);  //Generate lots of ties.
        }
        foreach(ref o; two) {
             o = uniform(1, 10);  //Generate lots of ties.
        }
        double sOne =
             spearmanCor(one[lowerBound..upperBound], two[lowerBound..upperBound]);
        double sTwo =
             spearmanCor(two[lowerBound..upperBound], one[lowerBound..upperBound]);
        foreach(ref o; one)
            o*=-1;
        double sThree =
             -spearmanCor(one[lowerBound..upperBound], two[lowerBound..upperBound]);
        double sFour =
             -spearmanCor(two[lowerBound..upperBound], one[lowerBound..upperBound]);
        foreach(ref o; two) o*=-1;
        one[lowerBound..upperBound].reverse;
        two[lowerBound..upperBound].reverse;
        double sFive =
             spearmanCor(one[lowerBound..upperBound], two[lowerBound..upperBound]);
        assert(approxEqual(sOne, sTwo) || (isnan(sOne) && isnan(sTwo)));
        assert(approxEqual(sTwo, sThree) || (isnan(sThree) && isnan(sTwo)));
        assert(approxEqual(sThree, sFour) || (isnan(sThree) && isnan(sFour)));
        assert(approxEqual(sFour, sFive) || (isnan(sFour) && isnan(sFive)));
    }

    // Test input ranges.
    struct Count {
        uint num;
        uint upTo;
        uint front() {
            return num;
        }
        void popFront() {
            num++;
        }
        bool empty() {
            return num >= upTo;
        }
    }

    Count a, b;
    a.upTo = 100;
    b.upTo = 100;
    assert(approxEqual(spearmanCor(a, b), 1));

    writeln("Passed spearmanCor unittest.");
}

version(unittest) {
    // Make sure when we call kendallCor, the large N version always executes.
    private enum kendallSmallN = 1;
} else {
    private enum kendallSmallN = 15;
}

/**Kendall's Tau B, O(N log N) version.  This can be defined in terms of the
 * bubble sort distance, or the number of swaps that would be needed in a
 * bubble sort to sort input2 into the same order as input1.  It is
 * a robust, non-parametric correlation metric.
 *
 * Since a copy of the inputs is made anyhow because they need to be sorted,
 * this function can work with any input range.  However, the ranges must
 * have the same length.*/
double kendallCor(T, U)(T input1, U input2)
if(isInputRange!(T) && isInputRange!(U)) {
    static if(isArray!(T) && isArray!(U)) {
        enforce(input1.length == input2.length,
            "Ranges must be same length for Kendall correlation.");
        if(input1.length <= kendallSmallN) {
            return kendallCorSmallN(input1, input2);
        }
    }

    auto i1d = tempdup(input1);
    scope(exit) TempAlloc.free;
    auto i2d = tempdup(input2);
    scope(exit) TempAlloc.free;

    enforce(i1d.length == i2d.length,
        "Ranges must be same length for Kendall correlation.");

    if(i1d.length <= kendallSmallN) {
        return kendallCorSmallN(i1d, i2d);
    } else {
        return kendallCorDestructive(i1d, i2d);
    }
}

/**Kendall's Tau O(N log N), overwrites input arrays with undefined data but
 * uses only O(log N) stack space for sorting, not O(N) space to duplicate
 * input.  Only works on arrays.
 */
double kendallCorDestructive(T, U)(T[] input1, U[] input2) {
    enforce(input1.length == input2.length,
        "Ranges must be same length for Kendall correlation.");
    return kendallCorDestructiveLowLevel(input1, input2).field[0];
}

//bool compFun(T)(T lhs, T rhs) { return lhs < rhs; }
private enum compFun = "a < b";

// Guarantee that T.sizeof >= U.sizeof so we know we can recycle space.
auto kendallCorDestructiveLowLevel(T, U)(T[] input1, U[] input2)
if(T.sizeof < U.sizeof) {
    return kendallCorDestructiveLowLevel(input2, input1);
}
// Used internally in dstats.tests.kendallCorTest.
auto kendallCorDestructiveLowLevel(T, U)(T[] input1, U[] input2)
if(T.sizeof >= U.sizeof)
in {
    assert(input1.length == input2.length);
} body {
    static Tuple!(ulong, ulong) getMs(V)(const V[] data) {  //Assumes data is sorted.
        ulong Ms = 0, tieCount = 0, tieCorrect = 0;
        foreach(i; 1..data.length) {
            if(data[i] == data[i-1]) {
                tieCount++;
            } else if(tieCount) {
                Ms += (tieCount*(tieCount+1))/2;
                tieCount++;
                tieCorrect += tieCount * (tieCount - 1) * (2 * tieCount + 5);
                tieCount = 0;
            }
        }
        if(tieCount) {
            Ms += (tieCount*(tieCount+1)) / 2;
            tieCount++;
            tieCorrect += tieCount * (tieCount - 1) * (2 * tieCount + 5);
        }
        return tuple(Ms, tieCorrect);
    }

    ulong m1 = 0, tieCorrect = 0,
          nPair = (cast(ulong) input1.length *
                  ( cast(ulong) input1.length - 1UL)) / 2UL;

    qsort!(compFun)(input1, input2);
    long s = nPair;

    uint tieCount = 0;
    foreach(i; 1..input1.length) {
        if(input1[i] == input1[i-1]) {
            tieCount++;
        } else if(tieCount > 0) {
            qsort!(compFun)(input2[i - tieCount - 1..i]);
            m1 += tieCount * (tieCount + 1) / 2UL;
            s += getMs(input2[i - tieCount - 1..i]).field[0];
            tieCount++;
            tieCorrect += cast(ulong) tieCount * (tieCount - 1) * (2 * tieCount + 5);
            tieCount = 0;
        }
    }
    if(tieCount > 0) {
        qsort!(compFun)(input2[input1.length - tieCount - 1..input1.length]);
        m1 += tieCount * (tieCount + 1UL) / 2UL;
        s += getMs(input2[input1.length - tieCount - 1..input1.length]).field[0];
        tieCount++;
        tieCorrect += cast(ulong) tieCount * (tieCount - 1) * (2 * tieCount + 5);
    }

    // We've already guaranteed that T.sizeof >= U.sizeof and we own these
    // arrays and will never use input1 again, so this is safe.
    ulong swapCount = 0;
    U[] input1Temp = (cast(U*) input1.ptr)[0..input2.length];
    mergeSortTemp!(compFun)(input2, input1Temp, &swapCount);

    immutable tieStuff = getMs(input2);
    immutable m2 = tieStuff.field[0];
    tieCorrect += tieStuff.field[1];
    s -= (m1 + m2) + 2 * swapCount;
    immutable double denominator1 = nPair - m1;
    immutable double denominator2 = nPair - m2;
    double cor = s / sqrt(denominator1) / sqrt(denominator2);
    return tuple(cor, s, tieCorrect);
}

/* Kendall's Tau correlation, O(N^2) version.  This is faster than the
 * more asymptotically efficient version for N <= about 15, and is also useful
 * for testing.  Yes, the sorts for the large N impl fall back on insertion
 * sorting for moderately small N, but due to additive constants and O(N) terms
 * this algorithm is still faster for very small N.  (Besides, I can't
 * delete it anyhow because I need it for testing.)
 */
private double kendallCorSmallN(T, U)(const T[] input1, const U[] input2)
in {
    assert(input1.length == input2.length);

    // This function should never be used for any inputs even close to this
    // large because it's a small-N optimization and a more efficient
    // implementation exists in this module for large N, but when N gets this
    // large it's not even correct due to overflow errors.
    assert(input1.length < 1 << 15);
} body {
    int m1 = 0, m2 = 0;
    int s = 0;

    foreach(i; 0..input2.length) {
        foreach (j; i + 1..input2.length) {
            if(input2[i] > input2[j]) {
                if (input1[i] > input1[j]) {
                    s++;
                } else if(input1[i] < input1[j]) {
                    s--;
                } else if(input1[i] == input1[j]) {
                    m1++;
                } else {
                    enforce(0, "Can't compute Kendall's Tau with NaNs.");
                }
            } else if(input2[i] < input2[j]) {
                if (input1[i] > input1[j]) {
                    s--;
                } else if(input1[i] < input1[j]) {
                    s++;
                } else if(input1[i] == input1[j]) {
                    m1++;
                } else {
                    enforce(0, "Can't compute Kendall's Tau with NaNs.");
                }
            } else if(input2[i] == input2[j]) {
                m2++;

                if(input1[i] < input1[j]) {
                } else if(input1[i] > input1[j]) {
                } else if(input1[i] == input1[j]) {
                    m1++;
                } else {
                    enforce(0, "Can't compute Kendall's Tau with NaNs.");
                }

            } else {
                enforce(0, "Can't compute Kendall's Tau with NaNs.");
            }
        }
    }

    immutable int nCombination = input2.length * (input2.length - 1) / 2;
    immutable double denominator1 = nCombination - m1;
    immutable double denominator2 = nCombination - m2;
    return s / sqrt(denominator1) / sqrt(denominator2);
}


unittest {
    //Test against known values.
    assert(approxEqual(kendallCor([1,2,3,4,5].dup, [3,1,7,4,3].dup), 0.1054093));
    assert(approxEqual(kendallCor([3,6,7,35,75].dup,[1,63,53,67,3].dup), 0.2));
    assert(approxEqual(kendallCor([1.5,6.3,7.8,4.2,1.5].dup, [1,63,53,67,3].dup), .3162287));

    static void doKendallTest(T)() {
        T[] one = new T[1000], two = new T[1000];
        // Test complex, fast implementation against straightforward,
        // slow implementation.
        foreach(i; 0..100) {
            size_t lowerBound = uniform(0, 1000);
            size_t upperBound = uniform(0, 1000);
            if(lowerBound > upperBound) swap(lowerBound, upperBound);
            foreach(ref o; one) {
                o = uniform(cast(T) -10, cast(T) 10);
            }
            foreach(ref o; two) {
                 o = uniform(cast(T) -10, cast(T) 10);
            }
            double kOne =
                 kendallCor(one[lowerBound..upperBound], two[lowerBound..upperBound]);
            double kTwo =
                 kendallCorSmallN(one[lowerBound..upperBound], two[lowerBound..upperBound]);
            assert(isIdentical(kOne, kTwo));
        }
    }

    doKendallTest!int();
    doKendallTest!float();
    doKendallTest!double();

    // Make sure everything works with lowest common denominator range type.
    struct Count {
        uint num;
        uint upTo;
        uint front() {
            return num;
        }
        void popFront() {
            num++;
        }
        bool empty() {
            return num >= upTo;
        }
    }

    Count a, b;
    a.upTo = 100;
    b.upTo = 100;
    assert(approxEqual(kendallCor(a, b), 1));
    writefln("Passed kendallCor unittest.");
}

// Alias to old correlation function names, but don't document them.  These will
// eventually be deprecated.
alias PearsonCor Pcor;
alias pearsonCor pcor;
alias spearmanCor scor;
alias kendallCor kcor;
alias kendallCorDestructive kcorDestructive;

/**Computes the partial correlation between vec1, vec2 given
 * conditions.  conditions can be either a tuple of ranges, a range of ranges,
 * or (for a single condition) a single range.
 *
 * cor is the correlation metric to use.  It can be either pearsonCor,
 * spearmanCor, kendallCor, or any custom correlation metric you can come up
 * with.
 *
 * Examples:
 * ---
 * uint[] stock1Price = [8, 6, 7, 5, 3, 0, 9];
 * uint[] stock2Price = [3, 1, 4, 1, 5, 9, 2];
 * uint[] economicHealth = [2, 7, 1, 8, 2, 8, 1];
 * uint[] consumerFear = [1, 2, 3, 4, 5, 6, 7];
 *
 * // See whether the prices of stock 1 and stock 2 are correlated even
 * // after adjusting for the overall condition of the economy and consumer
 * // fear.
 * double partialCor =
 *   partial!pearsonCor(stock1Price, stock2Price, economicHealth, consumerFear);
 * ---
 */
double partial(alias cor, T, U, V...)(T vec1, U vec2, V conditionsIn)
if(isInputRange!T && isInputRange!U && allSatisfy!(isInputRange, V)) {
    mixin(newFrame);
    static if(V.length == 1 && isInputRange!(ElementType!(V[0]))) {
        // Range of ranges.
        static if(isArray!(V[0])) {
            alias conditionsIn[0] cond;
        } else {
            auto cond = tempdup(cond[0]);
        }
    } else {
        alias conditionsIn cond;
    }

    auto corMatrix = newStack!(double[])(cond.length + 2);
    foreach(i, ref elem; corMatrix) {
        elem = newStack!double((cond.length + 2) * 2);
        elem[] = 0;
        elem[i] = 1;
    }

    corMatrix[0][1] = corMatrix[1][0] = cast(double) cor(vec1, vec2);
    foreach(i, condition; cond) {
        immutable conditionIndex = i + 2;
        corMatrix[0][conditionIndex] = cast(double) cor(vec1, condition);
        corMatrix[conditionIndex][0] =  corMatrix[0][conditionIndex];
        corMatrix[1][conditionIndex] = cast(double) cor(vec2, condition);
        corMatrix[conditionIndex][1] = corMatrix[1][conditionIndex];
    }

    foreach(i, condition1; cond) {
        foreach(j, condition2; cond[i + 1..$]) {
            immutable index1 = i + 2;
            immutable index2 = index1 + j + 1;
            corMatrix[index1][index2] = cast(double) cor(condition1, condition2);
            corMatrix[index2][index1] = corMatrix[index1][index2];
        }
    }

    invert(corMatrix);
    return -corMatrix[0][1] / sqrt(corMatrix[0][0] * corMatrix[1][1]);
}

unittest {
    // values from Matlab.
    uint[] stock1Price = [8, 6, 7, 5, 3, 0, 9];
    uint[] stock2Price = [3, 1, 4, 1, 5, 9, 2];
    uint[] economicHealth = [2, 7, 1, 8, 2, 8, 1];
    uint[] consumerFear = [1, 2, 3, 4, 5, 6, 7];
    double partialCor =
    partial!pearsonCor(stock1Price, stock2Price, [economicHealth, consumerFear][]);
    assert(approxEqual(partialCor, -0.857818));

    double spearmanPartial =
    partial!spearmanCor(stock1Price, stock2Price, economicHealth, consumerFear);
    assert(approxEqual(spearmanPartial, -0.7252));
    writeln("Passed partial correlation unittest.");
}

// Verify that there are no TempAlloc memory leaks anywhere in the code covered
// by the unittest.  This should always be the last unittest of the module.
unittest {
    auto TAState = TempAlloc.getState;
    assert(TAState.used == 0);
    assert(TAState.nblocks < 2);
}
