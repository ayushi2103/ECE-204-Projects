function [x3] = maximize( f, x0, x1, x2, eps_step, eps_abs, max_iter )
if (max_iter == 0)
    error( 'method did not converge' );
end
if ( abs(f(x0)) > abs(f(x1)) && abs(f(x1)) > abs(f(x2)) )
    temp = x0;
    x0 = x2;
    x2 = temp;
elseif ( abs(f(x0)) > abs(f(x2)) && abs(f(x2)) > abs(f(x1)) )
    temp = x0;
    x0 = x1;
    x1 = x2;
    x2 = temp;
elseif ( abs(f(x1)) > abs(f(x0)) && abs(f(x0)) > abs(f(x2)) )
    temp = x0;
    x0 = x2;
    x2 = x1;
    x1 = temp;
elseif ( abs(f(x1)) > abs(f(x2)) && abs(f(x2)) > abs(f(x0)) )
    temp = x1;
    x1 = x2;
    x2 = temp;
elseif( abs(f(x2)) > abs(f(x0)) && abs(f(x0)) > abs(f(x1)) )
    temp = x0;
    x0 = x1;
    x1 = temp;
    
end
i = 0;
for i = 1:max_iter
    p = polyfit( [x0, x1, x2], [f(x0), f(x1), f(x2)], 2 );
    x3 = - p(2)/(2*p(1));
 
    if ( f(x3) < f(x2) )
        error( 'invalid arguments' );
    elseif abs(x3 - x2) < eps_step &&  ( f(x3) - f(x2) ) < eps_abs
        return;
    else
   
        x0 = x1;
        x1 = x2;
        x2 = x3;
end
    
end