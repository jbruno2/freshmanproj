Program av
! averages 10 numbers
implicit none
real :: x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,average
read*, x1,x2,x3,x4,x5,x6,x7,x8,x9,x10
average=(x1+x2+x3+x4+x5+x6+x7+x8+x9+x10)/10
print*, 'the average is ',average
print*, 'the numbers are:'
print*, x1
print*, x2
print*, x3
print*, x4
print*, x5
print*, x6
print*, x7
print*, x8
print*, x9
print*, x10
End program av
! this approach is messy, involves a lot of typing and is prone to error. Imagine if we had to deal with thousands of numbers!
! The way around this is to use arrays. An array is a list.
! See the next code: 08array-02
