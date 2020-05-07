function [U] = crank_nicolson( kappa, a, b, t0, u0, ua, ub, nx, delta_t, nt )
U = zeros( nx + 1, nt + 1 );
k = 1;
h = ( b - a )/ nx;
xk = a;
for k = 1:nx + 1
    U(k, 1) = u0(xk);
    xk = xk + h;
end
s = delta_t * kappa / ( h ^ 2 );
A = diag(( 2 * ( s + 1 )) * ones( nx-1, 1 ), 0 ) + diag( -s * ones( nx-2, 1 ), -1 ) + diag( -s * ones( nx-2, 1 ), 1 );
end
k = 1;
for k = 2:nt + 1
    