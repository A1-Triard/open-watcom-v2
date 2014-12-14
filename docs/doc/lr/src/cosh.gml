.func cosh
.synop begin
#include <math.h>
double cosh( double x );
.ixfunc2 '&Math' &func
.ixfunc2 '&Trig' &func
.ixfunc2 '&Hyper' &func
.synop end
.desc begin
The
.id &func.
function computes the hyperbolic cosine of
.arg x
.ct .li .
A range error occurs if the magnitude of
.arg x
is too large.
.desc end
.return begin
The
.id &func.
function returns the hyperbolic cosine value.
.im errnorng
.return end
.see begin
.seelist sinh tanh matherr
.see end
.exmp begin
#include <stdio.h>
#include <math.h>

void main()
  {
    printf( "%f\n", cosh(.5) );
  }
.exmp output
1.127626
.exmp end
.class ANSI
.system
