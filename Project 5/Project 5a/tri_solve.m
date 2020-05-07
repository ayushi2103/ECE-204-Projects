function [x] = tri_solve( sub, dia, sup, b )
%checking the arguments of matrix
if (min( size( sub ) ) ~= 1) || (min( size( dia ) ) ~= 1) || (min( size( sup ) ) ~= 1) || (min( size( b ) ) ~= 1)
    error( 'all arguments must be vectors' );
end
%Checking if the vector dimensions are correct
if (length( dia ) ~= length( b )) || ( length( sub ) ~= length( dia ) - 1 ) || ( length( sup ) ~= length( dia ) - 1 )
    error( 'non-matching dimensions' );    
end 
%checking if the matrix is dominant
if abs( dia( 1 ) ) <= abs( sub( 1 )) || abs( dia( 1 )) <= abs( sup( 1 )) || ...
abs( dia( length( dia ))) <= abs( sub( length( sub ))) || abs( dia( length( dia ))) <= abs( sup( length( sup )))
    error( 'the matrix is not diagonally dominant' );
end
for k = 2:length(dia)-1
	if abs( dia ( k )) <= ( abs( sup( k - 1 )) + abs( sub( k ))) || abs( dia( k )) <= ( abs( sub( k - 1 )) + abs( sup( k )))
		error( 'the matrix is not diagonally dominant' );
	end
end
%gaussian elimination
for k = 2:length(dia)
	dia( k ) = dia( k ) - sub( k - 1 ) / dia( k - 1 ) * sup( k - 1 );
	b( k ) = b( k ) - sub( k - 1 ) / dia( k - 1 ) * b( k - 1 );
end
%backward substitution
x( length( dia )) = b( length( b )) / dia( length( dia ));
for k = length( dia )-1:-1:1
	x(k) = (b(k) - sup(k) * x(k+1)) / dia(k);
end
x = x';
end
