#idx_gen
function idx_cost()
PW_LINEAR   = 1;
POLYNOMIAL  = 2;

## define the indices
MODEL       = 1;    ## cost model, 1 = piecewise linear, 2 = polynomial
STARTUP     = 2;    ## startup cost in US dollars
SHUTDOWN    = 3;    ## shutdown cost in US dollars
NCOST       = 4;    ## number breakpoints in piecewise linear cost function,
                    ## or number of coefficients in polynomial cost function
COST        = 5;    ## parameters defining total cost function begin in this col
                    ## (MODEL = 1) : p0, f0, p1, f1, ..., pn, fn
                    ##      where p0 < p1 < ... < pn and the cost f(p) is defined
                    ##      by the coordinates (p0,f0), (p1,f1), ..., (pn,fn) of
                    ##      the end/break-points of the piecewise linear cost
                    ## (MODEL = 2) : cn, ..., c1, c0
                    ##      n+1 coefficients of an n-th order polynomial cost fcn,
                    ##      starting with highest order, where cost is
                    ##      f(p) = cn*p^n + ... + c1*p + c0
return PW_LINEAR, POLYNOMIAL, MODEL, STARTUP, SHUTDOWN, NCOST, COST
end
