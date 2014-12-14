.func fesetround
.synop begin
#include <fenv.h>
int fesetround( int __round );
.ixfunc2 'Floating Point Environment' &func
.synop end
.*
.desc begin
The
.id &func.
function establishes the rounding direction represented by its
argument round. If the argument is not equal to the value of a rounding direction macro,
the rounding direction is not changed.
.desc end
.*
.return begin
The
.id &func.
function returns a zero value if and only if the requested rounding direction was
established.
.return end
.*
.see begin
.seelist fegetround
.see end
.*
.exmp begin
#include <fenv.h>
.exmp break
void main( void )
{
    fesetround( FE_UPWARD );
}
.exmp end
.class ISO C99
.system
