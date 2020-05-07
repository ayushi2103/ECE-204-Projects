#include "vec.h"
#include "ivp.h"
#include "data.h"
#include <iostream>
#include <cassert>

// Function declarations
double has_converged( double max_error );
vec<15> f( double t, vec<15> w );
// You will pass 't' to ua(t) and ub(t); for everything else, you
// will use w
// Function definitions
double has_converged( double max_error ) {
 assert( max_error > 0 );
double h = (b - a) / 16.0;
 // Your implementation here (some hints included):
 // - you can call all globally defined functions in 'data.h'
 // and all globally defined constants

 vec<15> initial_state{};
 // Initialize your initial state vector.
 for (int i = 0; i < 15; i++ ){
     initial_state[i] = u0( a + ((i + 1) * h));
    }

vec<15> converge{};
double s = (ub(t0) - ua(t0)) / (b - a);
double nx = 16.0;
 for (int i = 0; i < 15; i++ ){
     converge[i] = ua(t0) + (s * (i + 1) * (b - a)) / nx;
    }

 ivp<vec<15>> u{ f, t0, initial_state,
 H_INIT, H_RANGE, EPS_ABS, vec<15>::norm };
 // u(3.2) returns a vec<15> with the temperatures at the
 // 15 intermediate points at time 3.2
 int flag = 0;
 for (double i = 0; i < 10; i = i + 1e-6){
     for (int j = 0; j < 15; j++){
         if ( std::abs (converge[j] - u(i)[j]) > max_error) {
            flag = 1;
            break;
        }
     }
        if (flag == 0){
            return i;
        }
        else {
            flag = 0;
        }
 }
    return 0.0;
}

 vec<15> f( double t, vec<15> w ){
     double h = (b - a) / 16.0;
    vec<15> F;
    for (int i = 1; i < 14; i++){
        F[i] = (kappa * (w[i - 1] - 2*w[i] + w[i+1])) / (h*h);
    }
    F[0] = (kappa * (ua(t) - 2 * w[0] + w[1])) / (h*h);
    F[14] = (kappa * (w[13] - 2 * w[14] + ub(t))) / (h*h);
    return F;
}