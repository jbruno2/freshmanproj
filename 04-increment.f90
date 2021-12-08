Program increment
implicit none
integer :: i
real :: x
x=1.0      ! initializing x: store the value 1.0 in the memory location called x.
do i=1,10
   x = x + 1.0    ! add 1.0 to the value currently stored in memory location x and then store the result in memory location x.
   print *, i, x
end do
End program increment
