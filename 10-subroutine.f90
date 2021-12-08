Program vols
implicit none
real :: rad1, rad2, vol1, vol2
character :: response
do
   print *, 'Please enter the two radii'
   read *, rad1, rad2
   call volume(rad1, vol1) !when the program reaches here, it jumps to the line "subroutine volume(rad,vol). The values, rad1 and vol1 are passed to the subroutines. The subroutine calculates a value for the volume and when the line "end subroutine volume" is reached, the value of the volume is returned to the main program.
   call volume(rad2, vol2)
   write(*,10) 'The difference in volume is, ',abs(vol1-vol2)
10    format(a,2f10.3)
   print *, 'Any more? -hit Y for yes, otherwise hit any key'
   read *, response
   if (response/= 'Y' .and. response /='Y') stop
end do
End program vols

!--------------------------------------------------
subroutine volume(rad,vol)
implicit none
real :: rad, vol, pi
!calculates the volume of a sphere
pi = 4.0*atan(1.0)
vol=4./3.*pi*rad*rad*rad
!It's a little quicker in processing to do r*r*r* than r**3
end subroutine volume

