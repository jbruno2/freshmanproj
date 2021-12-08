Program av2
implicit none
real ,dimension(10) :: x  !we specify the size of array when we declare it: this code allocates 100 memory locations to the array x.
real :: average, sum
integer :: i
print *, 'enter 10 numbers'
sum=0.0
do i=1,10
   read *, x(i)
   sum=sum+x(i)
end do
average=sum/10
print *, 'the average is ', average
print *, 'the numbers are'
print *, x
End program av2
