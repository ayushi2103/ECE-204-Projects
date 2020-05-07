function [v] = iter_solve( A, b, N_max, eps_step )
    format long;
    Adiag = diag(diag(A));
    Aoff = A - Adiag;
    v0 = Adiag \ b;
    vk = v0;
    n = 0;
    while ( n < N_max )
        n = n + 1;
        v = v0 - (Adiag \ Aoff)*vk;
        if norm(v - vk) < eps_step
            return;
        end
        vk = v;
    end
    error( 'the method did not converge' );
        
end

