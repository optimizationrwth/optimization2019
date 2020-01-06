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
    Modified on - 11.12.2019 - Step 1 Complete
                  12.12.2019 - Step 2 Complete
                  16.12.2019 
                  17.12.2019 - Step 3 Complete
                  19.12.2019
                  27.12.2019 - Step 4 Complete
                  29.12.2019 - Step 5 Complete
                  30.12.2019 - Finish and Polish

    Variables :

    A           - Inequality Constrain
    Aeq         - Equality Constrain
    Aeq_O       - Equality Constrain Original
    aux         - Auxiliary Matrix
    aux_num     - Number of Auxiliary Variables
    b           - Inequality Constrain
    beq         - Equality Constrain
    c           - Problem Constrain
    c_O         - Problem Constrain Original
    ceq         - Equality Constrain
    f_lb        - Function Lower Bound
    f_ub        - Function Upper Bound
    fmin        - Function Minimum
    fun         - Function
    H           - Problem Hessian
    H_O         - Problem Hessian Original
    i           - Iteration Control Variable
    j           - Iteration Control Variable
    k           - Iteration Control Variable
    lb          - Lower Boundary
    lb_O        - Lower Boundary Original
    m           - Problem Constrain
    n           - Problem Constrain
    nonlincon   - Non-Linear Constrain
    Q           - Problem Constrain
    Q1          - Problem Constrain
    Q2          - Problem Constrain
    Q3          - Problem Constrain
    r           - Iteration Control Variable
    T1          - Upper Triangual Matrix
    T2          - Upper Triangual Matrix
    T3          - Upper Triangual Matrix
    TQ1         - Symmetry Cheack
    TQ2         - Symmetry Cheack
    TQ3         - Symmetry Cheack
    ub          - Upper Boundary
    ub_O        - Upper Boundary Original
    x           - Function Handle
    x0          - Function Initial Guess

    Dependencies :

    Group_42_B02.m
%}


% Begining of the main Function
function [f_lb, f_ub] = convex_bound(n, m, c, H, Q, A, b, lb, ub)
    
    aux_num = 0;            % Number of auxiliary variables
    aux     = zeros(n,n);   % Auxiliary variable matrix
    Aeq     = A;            % Equality constrains
    beq     = b;            % Equality constrains
    
    %step 1 - Testing matrix Symmetry
    
    if m == 2
        
        % Matrix Decantation
        Q1  = Q(1:(n*1), 1:n);
        Q2  = Q((n+(n^0)):(n*2), 1:n);
        Q3  = zeros (n,n);
        
        % Test for Symmetry
        TQ1 = issymmetric (Q1);
        TQ2 = issymmetric (Q2);
        TQ3 = issymmetric (Q3);
        
    elseif m == 3
        
        % Matrix Decantation
        Q1  = Q(1:(n*1), 1:n);
        Q2  = Q((n+(n^0)):(n*2), 1:n);
        Q3  = Q((n+(n^0)+(n^1)):(n*3), 1:n);
        
        % Test for Symmetry
        TQ1 = issymmetric (Q1);
        TQ2 = issymmetric (Q2);
        TQ3 = issymmetric (Q3);
        
    end
    
    % Test for Symmetry - Escape statement at the end
    if (TQ1 == true) && (TQ2 == true) && (TQ3 == true)
        
    %Step 2 - Determining the number of auxiliary variables
        
        % Seperating the upper triangular matrix (with the diagonal)
        T1 = triu(Q1);
        T2 = triu(Q2);
        T3 = triu(Q3);
        
        % Detecting the presence of auxiliary variables - 1
        for i = 1:n
            for j = 1:n
                if T1(i,j) > 0
                    aux(i,j) = 1;   % Overwriting the auxiliary matrix elements
                end
            end
        end
        
        % Detecting the presence of auxiliary variables - 2
        for i = 1:n
            for j = 1:n
                if T2(i,j) > 0
                    aux(i,j) = 1;   % Overwriting the auxiliary matrix elements
                end
            end
        end
        
        % Detecting the presence of auxiliary variables - 3
        for i = 1:n
            for j = 1:n
                if T3(i,j) > 0
                    aux(i,j) = 1;   % Overwriting the auxiliary matrix elements
                end
            end
        end
            
    %step 3 - Generating the inequality constrains
    
        % Calculating the number of auxiliary variables without repetations
        for i = 1:n
            for j = 1:n
                if aux(i,j) > 0
                    aux_num = aux_num + 1;  % Auxiliary variable(s) counter
                end
            end
        end
        
        tot_var = n + aux_num;                  % Ammending the total variables
        A       = zeros((4*aux_num), tot_var);  % Deinition of initial inequality constrain matrix
        b       = zeros((4*aux_num), 1);        % Deinition of initial inequality constrain matrix
        r       = 1;                            % Iteration control variable
        k       = 1;                            % Iteration control variable
        
            % Definintion of McCormick Envelopes
            for i = 1:n
                for j = 1:n
                    if aux(i,j) > 0
                        
                        v = k + n;
                        
                        % Equation 5a from BonusExercise2.pdf
                        A(r,i) = lb(j,1);
                        A(r,j) = lb(i,1);
                        A(r,v) = -1;
                        
                        b(r,1) = lb(i,1) * lb(j,1);
                        
                        r      = r + 1;
                        
                        % Equation 5b from BonusExercise2.pdf
                        A(r,i) = ub(j,1);
                        A(r,j) = ub(i,1);
                        A(r,v) = -1;
                        
                        b(r,1) = ub(i,1) * ub(j,1);
                        
                        r      = r + 1;
                        
                        % Equation 5c from BonusExercise2.pdf
                        A(r,i) = -(lb(j,1));
                        A(r,j) = -(ub(i,1));
                        A(r,v) = 1;
                        
                        b(r,1) = -(ub(i,1) * lb(j,1));
                        
                        r      = r + 1;
                        
                        % Equation 5d from BonusExercise2.pdf
                        A(r,i) = -(ub(j,1));
                        A(r,j) = -(lb(i,1));
                        A(r,v) = 1;
                        
                        b(r,1) = -(lb(i,1) * ub(j,1));
                        
                        r      = r + 1;
                        
                    end
                end
                k = k+1;
            end
        %end
        
    %step 4 - Defining new constrains and finding the lower bound
        
        % Ammended H matrix
        H_O      = H;
        H        = padarray(H_O,  [aux_num aux_num], 0, 'post');    % Matrix padding
    
        % Ammended c matrix
        c_O      = c;
        c        = padarray(c_O,  [aux_num 0]      , 0, 'post');    % Matrix padding
    
        % Ammended lb matrix
        lb_O     = lb;
        lb       = padarray(lb_O, [aux_num 0]      , 0, 'post');    % Matrix padding
    
        % Ammended ub matrix
        ub_O     = ub;
        ub       = padarray(ub_O, [aux_num 0]      , 0, 'post');    % Matrix padding
    
        % Ammended Aeq matrix
        Aeq_O    = Aeq;
        Aeq      = padarray(Aeq_O,[0 aux_num]      , 0, 'post');    % Matrix padding
    
        % Upper Bound Definition
        if m == 2
        
            for i = 1:n
                for j = 1:n
                    if T1(i,j) > 0
                        Aeq(1,n + i) = 1;
                        ub (n + 1,1) = ub(i,1) * ub(j,1);
                    end
                end
            end
        
            for i = 1:n
                for j = 1:n
                    if T2(i,j) > 0
                        Aeq(2,n + i) = 1;
                        ub (n + 2,1) = ub(i,1) * ub(j,1);
                    end
                end
            end
    
        elseif m == 3
        
            for i = 1:n
                for j = 1:n
                    if T1(i,j) > 0
                        Aeq(1,n + i) = 1;
                        ub (n + 1,1) = ub(i,1) * ub(j,1);
                    end
                end
            end
        
            for i = 1:n
                for j = 1:n
                    if T2(i,j) > 0
                        Aeq(2,n + i) = 1;
                        ub (n + 2,1) = ub(i,1) * ub(j,1);
                    end
                end
            end
        
            for i = 1:n
                for j = 1:n
                    if T3(i,j) > 0
                        Aeq(3,n + i) = 1;
                    end
                end
            end
        
        end
        
        % MATLAB quadprog
        f_lb     = quadprog(H,c,A,b,Aeq,beq,lb,ub);
        
        % copmuting the Lower bound
        f_lb     = (f_lb' * H * f_lb) + (c' * f_lb);
    
    %step 5 - Applying fmincon to the local function for upper bound

        if m == 2
            
            % Function definition
            fun = @(x) (([x(1) x(2) x(3)] * H_O) * [x(1); x(2); x(3)]) + (c_O' * [x(1); x(2); x(3)]);
            % Non-Linear conditions
            nonlincon = @nlp1;
            
            %Initial Guess
            x0  = [0; 0; 0];
            
        elseif m == 3
            
            % Function definition
            fun = @(x) (([x(1) x(2) x(3) x(4)] * H_O) * [x(1); x(2); x(3); x(4)]) + (c_O' * [x(1); x(2); x(3); x(4)]);
            % Non-Linear conditions
            nonlincon = @nlp2;
            
            %Initial Guess
            x0  = [0; 0; 0;0];
            
        end
        
        %MATLAB fmincon
        fmin = fmincon(fun,x0,[],[],[],[],lb_O,ub_O,nonlincon);
        
        %Computing the Upper bound
        f_ub = fun (fmin);
    
    else
            % Escape Statement in case the matrix is not symmetric
            disp('The matrix Q is not symmetric')
    end
end
% End of main function


% Start of sub-function for non-linear constrain - 1
function [c,ceq] = nlp1(x)

    % Inequality constrains
    c   = [];

    % Equality constrains
    ceq    = zeros (2,1);
    ceq(1) = (x(1) * x(2)) + x(3) - 8;
    ceq(2) = (x(2) * x(3)) - 15;
    
end
% End of sub-function for non-linear constrain - 1


% Start of sub-function for non-linear constrain - 2
function [c,ceq] = nlp2(x)

    % Inequality constrains
    c   = [];

    % Equality constrains
    ceq   = zeros (3,1);
    ceq(1) = (x(1) * x(2)) + (x(2) * x(3)) - 2;
    ceq(2) = (x(1) * x(2)) + x(4) - 3;
    ceq(3) = (x(2) * x(3)) + x(1) - 5;
    
end
% End of sub-function for non-linear constrain - 2