clear
clc
close all
 
    C_Feul=1.5*10^(-6);
    C_C=.008;
    C_EP=.05;
    C_PP=.02;
    C_demant_penalty=0.001;
 
p1 = optimvar('p1','LowerBound',2500,'UpperBound',6250);
p2 = optimvar('p2','LowerBound',3000,'UpperBound',9000);
I1 = optimvar('I1','LowerBound',0,'UpperBound',87000);
I2 = optimvar('I2','LowerBound',0,'UpperBound',110000);
c = optimvar('c','LowerBound',0,'UpperBound',28000);
Le2 = optimvar('Le2','LowerBound',0,'UpperBound',64000);
MPS = optimvar('MPS','LowerBound',123000,'UpperBound',inf);
LPS = optimvar('LPS','LowerBound',45000,'UpperBound',inf);
EP = optimvar('EP','LowerBound',0,'UpperBound',12000);
Feul = optimvar('Feul','LowerBound',0,'UpperBound',inf);
PP = optimvar('PP','LowerBound',0,'UpperBound',inf);
HPS = optimvar('HPS','LowerBound',0,'UpperBound',inf);
Bf1 = optimvar('Bf1','LowerBound',0,'UpperBound',inf);
Bf2 = optimvar('Bf2','LowerBound',0,'UpperBound',inf);
Le1 = optimvar('Le1','LowerBound',0,'UpperBound',inf);
He1 = optimvar('He1','LowerBound',0,'UpperBound',inf);
He2 = optimvar('He2','LowerBound',0,'UpperBound',inf);




prob = optimproblem('Objective',C_Feul*Feul+C_C*c+C_PP*PP+C_EP*EP+C_demant_penalty*(12000-EP),'ObjectiveSense','min');

 
 
 
prob.Constraints.c1=-HPS+I1+I2+Bf1==0;

prob.Constraints.c2=Le1-I1+He1+c==0;

prob.Constraints.c3=He2-I2+Le2==0;

prob.Constraints.c4=Bf2+MPS-He1-He2-Bf1==0;

prob.Constraints.c5=-LPS+Le1+Le2+Bf2==0;

prob.Constraints.c6=-3163*I1+2949*He1+2911*Le1+449*c+3600*p1==0;

prob.Constraints.c7=-3163*I2+2949*He2+2911*Le2+3600*p2==0;

prob.Constraints.c8=-Feul*0.75+(HPS)*3163==0;

prob.Constraints.c9= -PP+p1+p2==0;

prob.Constraints.c10= I1 -He1 <= 60000;

prob.Constraints.c11= p1 +p2 + EP  >= 24500;
%Convert the problem object to a problem structure.
problem = prob2struct(prob);

%Solve the resulting problem structure.
[sol,fval,exitflag,output] = linprog(problem);
%vpa(sol)

% % showing the result in a table
                                        
                                        p1=sol(16);
                                        p2=sol(17);
                                        EP=sol(3);
                                        c=sol(15);
                                        I1=sol(8);
                                        I2=sol(9);
                                        LPS=sol(10);
                                        MPS=sol(13);
                                        He1=sol(6);
                                        Le1=sol(11);                                        
                                        He2=sol(7);
                                        Le2=sol(12);                                        
                                        Bf1=sol(1);
                                        Bf2=sol(2);                                        
                                        HPS=sol(5);
                                        Feul=sol(4);                                        
                                        PP=sol(14);
    JJ=C_Feul*Feul+C_C*c+C_PP*PP+C_EP*EP+C_demant_penalty*(12000-EP);
Solution=[JJ,p1,p2,EP,c,I1,I2,LPS,MPS,He1,Le1,He2,Le2,Bf1,Bf2,HPS,Feul];
  rowNames = {};
colNames = {'J','P1','P2','EP','C','I1','I2','LPS','MPS','He1','Le1','He2','Le2','Bf1','Bf2','HPS','Feul'};
sTable = array2table(Solution,'RowNames',rowNames,'VariableNames',colNames)
  

