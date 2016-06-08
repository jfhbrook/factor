USING: locals math math.combinatorics math.matrices
prettyprint sequences typed ;
in: benchmark.matrix-exponential-scalar

:: e^m ( m iterations -- e^m )
    {
        { 0.0 0.0 0.0 0.0 }
        { 0.0 0.0 0.0 0.0 }
        { 0.0 0.0 0.0 0.0 }
        { 0.0 0.0 0.0 0.0 }
    }
    iterations iota [| i |
        m i m^n i factorial >float m/n m+
    ] each ;

:: matrix-exponential-scalar-benchmark ( -- )
    f :> result!
    4 identity-matrix :> i4
    10000 [
        i4 20 e^m result!
    ] times
    result . ;

MAIN: matrix-exponential-scalar-benchmark