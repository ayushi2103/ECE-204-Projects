classdef LeastSquaresData < handle
    
   properties
        Head;
        Data;
        Integral;
        Delta_t;
   end
    
    methods
         function obj = LeastSquaresData( dt, init )
            obj.Head = 1;
            obj.Data = init*ones( 5, 1 );
            obj.Integral = 0.0;
            obj.Delta_t = dt;
        end
        
        function [] = add( obj, val )
            obj.Head = mod1( obj.Head - 1, 5);
            obj.Data(obj.Head) = val;
            
            obj.Integral = obj.Integral ...
            + obj.Delta_t * ( 0.5 * obj.Data( obj.Head ) ...
            + 0.35 * obj.Data ( mod1( obj.Head + 1, 5 )) ...
            + 0.2 * obj.Data ( mod1( obj.Head + 2, 5 )) ...
            + 0.05 * obj.Data ( mod1( obj.Head + 3, 5 )) ...
            - 0.1 * obj.Data ( mod1( obj.Head + 4, 5 )));

        end
        
        function [y] = current( obj )
            y = ( 0.6 * obj.Data(obj.Head) ...
            + 0.4 * obj.Data ( mod1( obj.Head + 1, 5 )) ...
            + 0.2 * obj.Data ( mod1( obj.Head + 2, 5 )) ...
            - 0.2 * obj.Data ( mod1( obj.Head + 4, 5 )));
        end
        
        function [y] = next( obj )
            y = ( 0.8 * obj.Data ( obj.Head ) ...
            + 0.5 * obj.Data ( mod1( obj.Head + 1, 5 )) ...
            + 0.2 * obj.Data ( mod1( obj.Head + 2, 5 )) ...
            - 0.1 * obj.Data ( mod1( obj.Head + 3, 5 )) ...
            - 0.4 * obj.Data ( mod1( obj.Head + 4, 5 )));
        end
        
        function [y] = diff( obj )
            y = ( 0.2 * obj.Data ( obj.Head ) ...
            + 0.1 * obj.Data ( mod1( obj.Head + 1, 5 )) ...
            - 0.1 * obj.Data ( mod1( obj.Head + 3, 5 )) ...
            - 0.2 * obj.Data ( mod1( obj.Head + 4, 5 ))) / obj.Delta_t;
        end
        
        function [y] = diff2( obj )
            y = ( 2.0 * obj.Data ( obj.Head ) ...
            - 1.0 * obj.Data ( mod1( obj.Head + 1, 5 )) ...
            - 2.0 * obj.Data ( mod1( obj.Head + 2, 5 )) ...
            - 1.0 * obj.Data ( mod1( obj.Head + 3, 5 )) ...
            + 2.0 * obj.Data ( mod1( obj.Head + 4, 5 ))) ...
            / (7 * (obj.Delta_t)^2);
        end
        
        function [y] = int( obj )
            y = obj.Integral;
        end
    end
end
function r = mod1( m, n )
    r = mod( m + n - 1, n ) + 1;
end

