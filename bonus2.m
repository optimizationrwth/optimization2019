clear
clc
close all
 

x = optimvar('x',5);
objec = x(1) + x(2) + x(3)*x(3) ;
prob = optimproblem('Objective',objec);
prob.Constraints.cons1  = x(4)+x(3) == 8;
prob.Constraints.cons2  = x(5) == 15;
prob.Constraints.cons3  = x(4)>=0;
prob.Constraints.cons4  = x(4)<=10*x(1)+10*x(2)-100;
prob.Constraints.cons5  = x(4)<=10*x(1)
prob.Constraints.cons6  = x(4)<=10*x(2)
prob.Constraints.cons7  = x(5)>=0;
prob.Constraints.cons8  = x(5)<=10*x(2)+10*x(3)-100;
prob.Constraints.cons9  = x(5)<=10*x(2)
prob.Constraints.cons10 = x(5)<=10*x(3)
%Convert prob to a problem structure.

problem = prob2struct(prob)
% Solve the problem using quadprog.

[x,fval] = quadprog(problem)
