program fmt
!demonstartas use of the format statement
implicit none
real :: a,b
a = sqrt(5.0)
b = -sqrt(a)
write(*,10) a, b
10 format(2E14.5)
end program fmt


! Formats:

! Exponential Specification
! nEm.d:
! d is the numer of decimal places
! m is the total width of the field including the sign(if any)
! n is the number of exponential numbers to output per line.

! Integer Specification
! nim:
! m is the number of character spaces reserved for printing.
! n is the number of integers to output per line.

! Floating point Specification
! nfm.d
! m is the number of character spaces reserved for printing.
! n is the number of real numbers to output per line.
! d is the number of spaces reserved for the fractional part of the number.

! Character Specification
! nAm:
! n is the number of strings to print
! m is the maximum number of characters to output
