function newtonpf(Ybus, Sbus, V0, ref, pv, pq, psteopt)



# options
tol     = psteopt.pf.tol
max_it  = psteopt.pf.max_it

# initialize
converged = 0;
i = 0;
V = V0;
Va = angle(V);
Vm = abs(V);

# set up indexing for updating V
npv = length(pv);
npq = length(pq);
j1 = 1;         j2 = npv;           #  j1:j2 - V angle of pv buses
j3 = j2 + 1;    j4 = j2 + npq;      # j3:j4 - V angle of pq buses
j5 = j4 + 1;    j6 = j4 + npq;      # j5:j6 - V mag of pq buses

# evaluate F(x0)
mis = V .* conj(Ybus * V) - Sbus(Vm);
F = [   real(mis([pv; pq]));
        imag(mis(pq))   ];

# check tolerance
normF = norm(F, inf);
if mpopt.verbose > 1
    fprintf('\n it    max P & Q mismatch (p.u.)');
    fprintf('\n----  ---------------------------');
    fprintf('\n%3d        %10.3e', i, normF);
end
if normF < tol
    converged = 1;
    if mpopt.verbose > 1
        fprintf('\nConverged!\n');
    end
end

# do Newton iterations
while (~converged && i < max_it)
   # update iteration counter
    i = i + 1;
    
    # evaluate Jacobian
    [dSbus_dVm, dSbus_dVa] = dSbus_dV(Ybus, V);
    [dummy, neg_dSd_dVm] = Sbus(Vm);
    dSbus_dVm = dSbus_dVm - neg_dSd_dVm;
    
    j11 = real(dSbus_dVa([pv; pq], [pv; pq]));
    j12 = real(dSbus_dVm([pv; pq], pq));
    j21 = imag(dSbus_dVa(pq, [pv; pq]));
    j22 = imag(dSbus_dVm(pq, pq));
    
    J = [   j11 j12;
            j21 j22;    ];

    # compute update step
    dx = -(J \ F);

    # update voltage
    if npv
        Va(pv) = Va(pv) + dx(j1:j2);
    end
    if npq
        Va(pq) = Va(pq) + dx(j3:j4);
        Vm(pq) = Vm(pq) + dx(j5:j6);
    end
    V = Vm .* exp(1j * Va);
    Vm = abs(V);            %% update Vm and Va again in case
    Va = angle(V);          %% we wrapped around with a negative Vm

    # evalute F(x)
    mis = V .* conj(Ybus * V) - Sbus(Vm);
    F = [   real(mis(pv));
            real(mis(pq));
            imag(mis(pq))   ];

    # check for convergence
    normF = norm(F, inf);
    if mpopt.verbose > 1
        fprintf('\n%3d        %10.3e', i, normF);
    end
    if normF < tol
        converged = 1;
        if mpopt.verbose
            fprintf('\nNewton''s method power flow converged in %d iterations.\n', i);
        end
    end
end

if mpopt.verbose
    if ~converged
        fprintf('\nNewton''s method power flow did not converge in %d iterations.\n', i);
    end
end
