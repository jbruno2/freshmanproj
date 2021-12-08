Program f_to_K
implicit none
real :: farenheight, Kelvin
print *, 'Please enter a temperature in Farenheight'
read *, farenheight
print *, 'The temperature in Kelvin is.. '
Kelvin = ((0.55555555)*(farenheight-32)) + 273.15

print *, Kelvin

End program f_to_k