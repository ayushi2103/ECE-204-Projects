function [fx] = concave_interp( x1, f1, df1, d2f1, x2, f2, df2, d2f2, x )
 if x1 == x2
 error( 'the end points must differ' );
 end
 %the matrix required to find the interpolating polynomial of degree five 
 A = [x1^5 x1^4 x1^3 x1^2 x1 1
      x2^5 x2^4 x2^3 x2^2 x2 1
      5*x1^4 4*x1^3 3*x1^2 2*x1 1 0
      5*x2^4 4*x2^3 3*x2^2 2*x2 1 0
      20*x1^3 12*x1^2 6*x1 2 0 0 
      20*x2^3 12*x2^2 6*x2 2 0 0];
  %finding the interpolating polynomial
  p = A \ [f1 f2 df1 df2 d2f1 d2f2]';
  %Evaluating the polynomial using polyval
  fx = polyval( p, x); 
end
