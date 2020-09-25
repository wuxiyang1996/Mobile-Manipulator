function [trans_mat, jacobian] = user_jacobian(l, q)
    q(2) = q(2) + pi/2;
    alpha = q(2) + q(3); 
    beta = q(2) + q(3) + q(4); 
    lc1 = l(2) * cos(q(2)) + l(3) * cos(alpha) + l(4) * cos(beta);
    lc2 = l(3) * cos(alpha) + l(4) * cos(beta);
    lc3 = l(4) * cos(beta);
    ls1 = l(2) * sin(q(2)) + l(3) * sin(alpha) + l(4) * sin(beta);
    ls2 = l(3) * sin(alpha) + l(4) * sin(beta);
    ls3 = l(4) * sin(beta);
    
    jacobian = [-sin(q(1))*lc1, -cos(q(1))*ls1, -cos(q(1))*ls2, -cos(q(1))*ls3;
        cos(q(1))*lc1, -sin(q(1))*ls1, -sin(q(1))*ls2, -sin(q(1))*ls3;
        0, lc1, lc2, lc3;
        0, sin(q(1)), sin(q(1)), sin(q(1));
        0, -cos(q(1)), -cos(q(1)), -cos(q(1));
        1, 0, 0, 0];
    
    trans_mat = [cos(q(1))* cos(beta), -cos(q(1))* sin(beta), sin(q(1)), cos(q(1))* lc1;
        sin(q(1))* cos(beta), -sin(q(1))* sin(beta),  -cos(q(1)),  sin(q(1))* lc1;
        sin(beta), cos(beta), 0, l(1) + ls1;
        0, 0, 0, 1]; 
end

