Program sum                       !name of program
implicit none                     !Fortran will check that you have properly declared all your variables. Alwayas use implicit none at the start of every program.
! All variable used in a program must have an associated data type, such as real, integer, .. which is usually identified at the start of the program. This is referred to as declaring or specifying a variable.
real :: answer,x,y                !declarations
! reals examples: 10.3, -8.45, 0.00002, etc
Print *, 'Enter two numbers'      !output
read*, x                          !input
read*, y                          !input
Answer = x+y                      !arithmetic
print*, 'The total is ', answer   !output
End program sum                   !end of program
