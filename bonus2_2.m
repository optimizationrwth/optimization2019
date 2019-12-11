clear
clc
close all
 u1=7;
 l1=0.;
 u2=10;
 l2=1.5;
 u3=8;
 l3=1.5;
 
x = optimvar('x',5);
objec = x(1) + x(2) + x(3)*x(3) ;
prob = optimproblem('Objective',objec);
prob.Constraints.cons1  = x(4)+x(3) == 8;
prob.Constraints.cons2  = x(5) == 15;
prob.Constraints.cons3  = x(4)>=l2*x(1)+l1*x(2)-l1*l2;
prob.Constraints.cons4  = x(4)<=u2*x(1)+u1*x(2)-u1*u2;
prob.Constraints.cons5  = x(4)<=u2*x(1)+l1*x(2)-l1*u2;
prob.Constraints.cons6  = x(4)<=u1*x(2)+l2*x(1)-u1*l2;
prob.Constraints.cons7  = x(5)>=l3*x(2)+l2*x(3)-l2*l3;
prob.Constraints.cons8  = x(5)<=u3*x(2)+u2*x(3)-u2*u3;
prob.Constraints.cons9  = x(5)<=l3*x(2)+u2*x(3)-u2*l3;
prob.Constraints.cons10 = x(5)<=u3*x(2)+l2*x(3)-u3*l2;
%Convert prob to a problem structure.

problem = prob2struct(prob)
% Solve the problem using quadprog.

[x,fval] = quadprog(problem)