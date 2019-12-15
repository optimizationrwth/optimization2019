clear
clc
close all
 u1=5;
 l1=.00000001;
 u2=4;
 l2=.00000001;
 u3=10;
 l3=.00000001;
 


x = optimvar('x',6);
objec = x(1) + x(2) + x(3)*x(3)+x(6)*x(6) ;
prob = optimproblem('Objective',objec);
prob.Constraints.cons1  = x(4)+x(5) == 2;
prob.Constraints.cons2  = x(4)+x(6) == 3;
prob.Constraints.cons3  = x(4)>=l2*x(1)+l1*x(2)-l1*l2;
prob.Constraints.cons4  = x(4)>=u2*x(1)+u1*x(2)-u1*u2;
prob.Constraints.cons5  = x(4)<=u2*x(1)+l1*x(2)-l1*u2;
prob.Constraints.cons6  = x(4)<=u1*x(2)+l2*x(1)-u1*l2;
prob.Constraints.cons7  = x(5)>=l3*x(2)+l2*x(3)-l2*l3;
prob.Constraints.cons8  = x(5)>=u3*x(2)+u2*x(3)-u2*u3;
prob.Constraints.cons9  = x(5)<=l3*x(2)+u2*x(3)-u2*l3;
prob.Constraints.cons10 = x(5)<=u3*x(2)+l2*x(3)-u3*l2;
prob.Constraints.cons11 = x(1)+x(5) == 5;
prob.Constraints.cons12 = x(1) >= 0;
prob.Constraints.cons13 = x(2) >= 0;
prob.Constraints.cons14 = x(3) >= 0;
prob.Constraints.cons15 = x(4) >= 0;
prob.Constraints.cons16 = x(1) <= 10;
prob.Constraints.cons17 = x(2) <= 4;
prob.Constraints.cons18 = x(3) <= 10;
prob.Constraints.cons19 = x(4) <= 10;



%Convert prob to a problem structure.

problem = prob2struct(prob)
% Solve the problem using quadprog.

[x,fval] = quadprog(problem)