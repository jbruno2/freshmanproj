!************************************************
!© 2018 Mahvand Khamesian. All Rights Reserved.
!************************************************
implicit none
integer, parameter :: lr=2048
real*8, parameter :: beta=0.0792, x0=1.d-9, phi=2.487d-6
real*8, parameter :: koffm=50.d3, konm=1.d9, koffre=75.d3, konre=2.d9
real*8, parameter :: ksp=200.d-6, xsp=252, kes=140.d-6, xes=0, lambda=130.d-9
real*8, parameter :: gamma=0.14, Ng=35, xc=12, d=7
!
real*8, parameter :: kB = 1.38065d-23 , Temp = 293.d0, lambda_a=3.d-6
real*8, parameter :: tsamp=1.d-4, tu=10.d0
real*8 c(20),  dkr, A, A1, KD, alf,V, po, smax,cmax
real*8 y0(5), y(5), yn(5), dt, aux, del, Kf, tmax, dn1, dn2, dns, rnoise_b, rnoise_a
real*8 un1, un2, un3, pi2, logn, df, q, kgs, kgs0, dkgs, Vamp, Vref, taus, taus2, t
integer i, j, nu, nt, is, nts, i0
character*128 name
real, allocatable, dimension (:) :: yr,vr,psdx,psdv,sen,coh,sena,rw,res,frq

common /const/ c
common /param/ A, A1, Vref, taus,taus2

open (11, file='dkgs_tser.in')
read (11,*) A
read (11,*) A1
read (11,*) Vref
read (11,*) Vamp
read (11,*) taus
read (11,*) kgs0
read (11,*) dkgs
read (11,*) cmax
read (11,*) smax
read (11,*) rnoise_b
read (11,*) rnoise_a
read (11,*) dt
read (11,*) tmax
read (11,*) name
close (11)


dn1=rnoise_b*sqrt(2*kb*Temp/lambda*dt)/x0     
dn2=rnoise_a*sqrt(3*kb*Temp/lambda_a*dt)*gamma/x0
taus2=taus**2
dns=2*Vamp*sqrt(dt*taus)/taus2
pi2=8*atan(1.d0)


! constants
KD=koffm/konm
c(1)=17.3
c(2)=1.7304d3
c(3)=8.5
c(4)=-KD/phi
c(5)=-2*konre*phi
c(6)=koffre
c(7)=kgs0
c(8)=dkgs
c(9)=Ng*gamma/lambda
c(10)=gamma
c(11)=xc
c(12)=d
c(13)=ksp/lambda
c(14)=xsp
c(15)=Kf/lambda
c(16)=cmax/x0
c(17)=smax
c(18)=kes
c(19)=xes
!

nu=tu/dt+1
nt=tmax/dt+1
is=tsamp/dt
nts=tmax/tsamp+1


y0(1)=0.d0
y0(2)=1.d0
y0(3)=0.5
y0(4)=0.d0
y0(5)=0.d0
yn=0.d0
do i=1,nu  
  call random_number(un1)
  call random_number(un2)
  call random_number(un3)
  logn=sqrt(-2*log(un1))
  yn(1)=dn1*logn*cos(pi2*un2)
  yn(2)=dn2*logn*sin(pi2*un2)
  yn(5)=dns*sqrt(-2*log(un3))*cos(pi2*un1)
  call rkmn(y0,y,yn,dt)
  y0=y
enddo

open (11, file=name)
do i=1,nt
  call random_number(un1)
  call random_number(un2)
  call random_number(un3)
  logn=sqrt(-2*log(un1))
  yn(1)=dn1*logn*cos(pi2*un2)
  yn(2)=dn2*logn*sin(pi2*un2)
  yn(5)=dns*sqrt(-2*log(un3))*cos(pi2*un1)
  call rkmn(y0,y,yn,dt)
  if(mod(i,is).eq.0) then
   V=Vref+y0(4)
   alf=beta*V/(1.d0-exp(beta*V))
   kgs=c(7)*(1.d0-c(8)*y0(3))
   po=1.d0/(1.d0+exp(c(1)-c(2)*kgs*(c(10)*y0(1)-y0(2)+c(3))))
   write (11,1) (i-1)*dt, y0(1)  ! time, bundle position
  endif
  y0=y
enddo  
1 format(4(g12.5,1x))
end

subroutine derivs_hp(y,f)
implicit none
real*8, parameter :: beta=0.0792
real*8, dimension (5) :: y,f
real*8 c(20),A,A1,V,Vref,taus,taus2
real*8 alf,aux, kgs, po, pm, aux1
common /const/ c
common /param/ A, A1, Vref, taus,taus2

V=Vref+y(4)
alf=beta*V/(1.d0-exp(beta*V))
kgs=c(7)*(1.d0-c(8)*y(3))
po=1.d0/(1.d0+exp(c(1)-c(2)*kgs*(c(10)*y(1)-y(2)+c(3))))
aux1=A*alf*po
pm=1.d0/(1+c(4)/aux1)
aux=kgs*(c(10)*y(1)-y(2)+c(11)-po*c(12))
f(1)=-c(9)*aux-c(13)*(y(1)-c(14))
f(2)=-(1.d0-pm)*c(16)+pm*c(17)*(aux-c(18)*(y(2)+c(19)))
f(3)=c(5)*aux1*A1*(1.d0-y(3))-c(6)*y(3)
f(4)=y(5)
f(5)=-2/taus*y(5)-y(4)/taus2
return 
end



SUBROUTINE RKMN(Y0,Y,yn,H)
implicit none
integer, parameter:: nm=5
real*8, dimension (nm) :: y0,y,yn,rk1,rk2,rk3,rk4,y1,f
real*8 h 
call derivs_hp(y0,f)
rk1=h*f+yn
y1=y0+rk1/2

call derivs_hp(y1,f)
rk2=h*f+yn
y1=y0+rk2/2

call derivs_hp(y1,f)
rk3=h*f+yn
y1=y0+rk3

call derivs_hp(y1,f)
rk4=h*f+yn
y=y0+(rk1+2*(rk2+rk3)+rk4)/6.d0
return
end


