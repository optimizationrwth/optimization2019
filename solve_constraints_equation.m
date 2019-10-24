clear
clc
 syms p1 p2 I1 I2 c EP He1 He2 Le1 Le2 LPS MPS HPS Feul Bf1 Bf2

f1=-HPS+I1+I2+Bf1;

f2=Le1-I1+He1+c;

f3=He2-I2+Le2;

f4=Bf2+MPS-He1-He2-Bf1;

f5=-LPS++Le1+Le2+Bf2;

f6=-3163*I1+2949*He1+2911*Le1+449*c+3600*p1;

f7=-3163*I2+2949*He2+2911*Le2+3600*p2;

f8=-Feul*.75+(HPS)*3163;

S=solve(f1==0,f2==0,f3==0,f4==0,f5==0,f6==0,f7==0,He1, He2, Le1,Bf1,Bf2, Le2, HPS);

LE1=S.Le1
LE2=S.Le2
HE1=S.He1
HE2=S.He2
BF1=S.Bf1
BF2=S.Bf2
hps=S.HPS

