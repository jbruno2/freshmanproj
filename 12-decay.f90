Program decay
implicit none
real :: percentage, fraction, age, lambda
print *, 'Please enter the percentage of carbon-14 remaining in a sample'
read *, percentage
print *, 'Your sample is this many years old:'
fraction = percentage / 100
lambda = 0.00012097
age = -((1/lambda)*log(fraction))

print *, age

End program decay