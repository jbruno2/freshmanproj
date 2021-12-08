! this program prints out the numbers from 0 to 20 in steps of 1.
Program loop
implicit none
integer :: i        ! i is called a loop counter. Each time the statements are executed, the loop counter, i, is incremented by 1. When the value of i is 20, the loop terminates, and the program resumes after the end do.
!integers may only have discrete, whole values: e.g. -3124, -960, 10,365, etc.
do i=0,20
   print *, i  ! loop statement
end do
End program loop
