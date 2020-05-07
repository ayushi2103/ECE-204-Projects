#include <cmath>
#include "vec.h"
// Authored by Madhur Kumar Sharma

// Using 12 first order IVP's chaining 12 low pass filters
const std::size_t N{12};   // must be <= 12

// Function declarations
vec<N> f( double t, vec<N> y );
double phase( double f );

// Function definitions
vec<N> f( double t, vec<N> y ) {
    const double R{1.0};
    const double C{1.0/(2.0*M_PI*R*fc)};

    // 12 first order, reversed while returning
    return vec<N>{y[1]/R/C - y[0]/R/C,
        y[2]/R/C - y[1]/R/C,
        y[3]/R/C - y[2]/R/C,
        y[4]/R/C - y[3]/R/C,
        y[5]/R/C - y[4]/R/C,
        y[6]/R/C - y[5]/R/C,
        y[7]/R/C - y[6]/R/C,
        y[8]/R/C - y[7]/R/C,
        y[9]/R/C - y[8]/R/C,
        y[10]/R/C - y[9]/R/C,
        y[11]/R/C - y[10]/R/C,
        v(t)/R/C - y[11]/R/C };
}


double phase( double f ) {
    const double R{1.0};
    const double C{1.0/(2.0*M_PI*R*fc)};

    // Phase shift of the response is 12 times the standard 1 order
    return -12.0*std::atan( 2*M_PI*f*R*C );
}
