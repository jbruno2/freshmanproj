Program readdata
! reads data from a file called mydata.txt
implicit none
integer :: x,y,z
open(10, file='mydata.txt')   !device 10: it doesn't have to be 10, it could e any positive number
read(10,*) x,y,z
print*, x,y, z
End program readdata
