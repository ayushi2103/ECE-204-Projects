function [y] = poly_exp( x )
    format long;
    xc = [0, 0.25, 0.5, 0.75, 1];
    yc = exp(xc);
    if ( x < 0)
        y =  1/poly_exp(-x);
    elseif ( x >= 0 && x <= 1)
        p = polyfit(xc, yc, 4);
        y = polyval(p, x);
    else
        y = poly_exp(x/2)^2;
    end
end

