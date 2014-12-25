.func fegetexceptflag
.synop begin
#include <fenv.h>
int fegetexceptflag( fexcept_t *flagp, int excepts );
.ixfunc2 'Floating Point Environment' &funcb
.synop end
.*
.desc begin
The
.id &funcb.
function attempts to store a representation of the states of the
floating-point status flags indicated by the
.arg excepts
argument in the
object pointed to by the
.arg flagp
argument.
.np
Valid exceptions are
.kw FE_INVALID
.ct ,
.kw FE_DENORMAL
.ct ,
.kw FE_DIVBYZERO
.ct ,
.kw FE_OVERFLOW
.ct ,
.kw FE_UNDERFLOW
and
.kw FE_INEXACT
.ct .li .
.np
The value
.kw FE_ALL_EXCEPT
is the logical OR of these values.
.desc end
.*
.return begin
The
.id &funcb.
function returns zero if the representation was successfully
stored. Otherwise, it returns a nonzero value.
.return end
.*
.see begin
.seelist feclearexcept feraiseexcept fesetexceptflag fetestexcept
.see end
.*
.exmp begin
#include <fenv.h>
.exmp break
void main( void )
{
    fexcept_t flags;
    fegetexceptflag( &flags, FE_DIVBYZERO );
}
.exmp end
.class ISO C99
.system
