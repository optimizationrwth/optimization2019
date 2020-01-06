%{
    Applied Numerical Optimization - Wintersemester 2019/2020
    Assignment  - 2
    Group       - 42


    Author(s) :
    
    Balaji Gunaseelan   - 394820
    Vaishnavi Pawar     - 395171
    Melisa Chaves       - 395518
    Youseff Azbawy      - 394836
    
    Created on  - 04.12.2019
    Modified on - 11.12.2019 - Problem 1 Definition
                  12.12.2019 - Problem 2 Definition
                  16.12.2019 - Debugging
                  30.12.2019 - Finish and Polish

    Variables :

    A1  - Problem 1 Inequality Constrain
    A2  - Problem 2 Inequality Constrain
    b1  - Problem 1 Inequality Constrain
    b2  - Problem 2 Inequality Constrain
    c1  - Problem 1 Constrain
    c2  - Problem 2 Constrain
    H1  - Problem 1 Hessian
    H2  - Problem 2 Hessian
    lb1 - Problem 1 Lower Boundary
    lb2 - Problem 2 Lower Boundary
    m1  - Problem 1 Constrain
    m2  - Problem 2 Constrain
    n1  - Problem 1 Constrain
    n2  - Problem 2 Constrain
    p1  - Problem 1 Output
    p2  - Problem 2 Output
    Q1  - Problem 1 Constrain
    Q11 - Problem 1 Constrain
    Q12 - Problem 1 Constrain
    Q2  - Problem 2 Constrain
    Q22 - Problem 2 Constrain
    Q23 - Problem 2 Constrain
    ub1 - Problem 1 Upper Boundary
    ub2 - Problem 2 Upper Boundary
    x1  - Problem 1 Lower Bound
    x2  - Problem 2 Upper Bound
    y1  - Problem 1 Lower Bound
    y2  - Problem 2 Upper Bound

    Dependencies :
    
    convex_bound.m
%}

% Problem 1

A1      = zeros(2,3);
A1(1,3) = 1;

H1      = zeros(3,3);
H1(3,3) = 1;

Q11      = zeros(3,3);
Q11(1,2) = 0.5;
Q11(2,1) = 0.5;

Q12      = zeros(3,3);
Q12(3,2) = 0.5;
Q12(2,3) = 0.5;

c1 = [1; 1; 0];
Q1 = [Q11; Q12];
b1 = [8; 15];
n1 = 3;
m1 = 2;

% bounds

ub1 = [10;10;10];
lb1 = [0;0;0];

% Function Call
[x1, y1] = convex_bound(n1, m1, c1, H1, Q1, A1, b1, lb1, ub1);

% Problem 2

A2      = zeros(3,4);
A2(2,4) = 1;
A2(3,1) = 1;

H2      = zeros(4,4);
H2(3,3) = 1;
H2(4,4) = 1;

Q12      = zeros(4,4);
Q12(1,2) = 0.5;
Q12(2,1) = 0.5;
Q12(2,3) = 0.5;
Q12(3,2) = 0.5;

Q22      = zeros(4,4);
Q22(1,2) = 0.5;
Q22(2,1) = 0.5;

Q23      = zeros(4,4);
Q23(2,3) = 0.5;
Q23(3,2) = 0.5;

c2 = [1; 1; 0; 0];
Q2 = [Q12; Q22; Q23];
b2 = [2; 3; 5];
n2 = 4;
m2 = 3;

% bounds

ub2 = [10; 4; 10; 10];
lb2 = [0; 0; 0; 0];

% Function Call
[x2, y2] = convex_bound(n2, m2, c2, H2, Q2, A2, b2, lb2, ub2);

%Clearing the command window (Display)
clc

% Problem 1 Solution display
p1 = sprintf('Problem 1 had a Upper Bound %.2f and Lower Bound %.2f\n\n',y1,x1);
disp (p1)

% Problem 2 Solution display
p2 = sprintf('Problem 2 had a Upper Bound %.2f and Lower Bound %.2f\n\n',y2,x2);
disp (p2)