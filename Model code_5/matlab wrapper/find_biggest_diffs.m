function [a1,a2,b1,b2] = find_biggest_diffs(data, theta1, theta2, k, p, Nmax, start_vals)
% find_biggest_diffs finds the trials with the biggest differences between
% models with parameters theta1 and theta2
% To allow all comparisons, this function takes already padded thetas as
% input
% Finds the k boards where theta 1 is the most worse than theta2
% making sure that all other boards have a chance less than p to enter this
% list based on a normal approximation.
% Also aborts if Nmax = 10000 repetitions are reached.
% This function returns the hits and misses for each trial. All statistics
% can be found from those values. The loglikelihood difference is
% psi(a1) - psi(a1+b1) - psi(a2) + psi(a2+b2);

if ~exist('k', 'var') || isempty(k)
    k = 3;
end
if ~exist('p', 'var') || isempty(p)
    p = 0.001;
end
if ~exist('Nmax', 'var') || isempty(Nmax)
    Nmax = 10000;
end

z = abs(norminv(p/2));

data_cell = num2cell(data);
times = int32(ones(size(data,1),1));
ns = 1:100000;
tab = psi(ns) - psi(1);

if ~exist('start_vals', 'var') || isempty(start_vals)
    % first evaluation:
    fprintf('starting first run\n')
    loglik1 = estimate_loglik_mex(data_cell',theta1,times)';
    loglik2 = estimate_loglik_mex(data_cell',theta2,times)';
    n1 = round(interp1(tab, ns, loglik1));
    n2 = round(interp1(tab, ns, loglik2));
    a1 = ones(size(data,1),1);
    a2 = ones(size(data,1),1);
    b1 = n1 - 1;
    b2 = n2 - 1;
    
    % run reps for the ones that were immediately right until they got a miss
    while any(b1<1)
        rerun = b1<1;
        fprintf('repeating %d runs for the first model\n', sum(rerun));
        ll = estimate_loglik_mex(data_cell(rerun,:)',theta1,times)';
        n = round(interp1(tab, ns, ll));
        a1(rerun) = a1(rerun) + 1;
        b1(rerun) = b1(rerun) + n - 1;
    end
    while any(b2<1)
        rerun = b2<1;
        fprintf('repeating %d runs for the second model\n', sum(rerun));
        ll = estimate_loglik_mex(data_cell(rerun,:)',theta2,times)';
        n = round(interp1(tab, ns, ll));
        a2(rerun) = a2(rerun) + 1;
        b2(rerun) = b2(rerun) + n - 1;
    end
else
    a1 = start_vals(:, 1);
    a2 = start_vals(:, 2);
    b1 = start_vals(:, 3);
    b2 = start_vals(:, 4);
end

fprintf('starting main computation\n')
m1 = psi(a1) - psi(a1+b1);
m2 = psi(a2) - psi(a2+b2);
var1 = psi(1, a1) - psi(1, a1+b1);
var2 = psi(1, a2) - psi(1, a2+b2);

diff = abs(m1-m2);
var = var1 + var2;
[sorted, idx] = sort(diff, 'descend');
thresh = sorted(k);
rerun = abs(diff-thresh)./sqrt(var + max(var(idx(1:k)))) < z;

n_run = 0;
while (n_run < Nmax) && (sum(rerun) > 1)
    fprintf('Run %d: %d of %d under consideration\n', n_run, sum(rerun), length(rerun))
    ll = estimate_loglik_mex(data_cell(rerun,:)',theta1,times)';
    n = round(interp1(tab, ns, ll));
    a1(rerun) = a1(rerun) + 1;
    b1(rerun) = b1(rerun) + n - 1;
    ll = estimate_loglik_mex(data_cell(rerun,:)',theta2,times)';
    n = round(interp1(tab, ns, ll));
    a2(rerun) = a2(rerun) + 1;
    b2(rerun) = b2(rerun) + n - 1;
    
    m1(rerun) = psi(a1(rerun)) - psi(a1(rerun)+b1(rerun));
    m2(rerun) = psi(a2(rerun)) - psi(a2(rerun)+b2(rerun));
    var1(rerun) = psi(1, a1(rerun)) - psi(1, a1(rerun)+b1(rerun));
    var2(rerun) = psi(1, a2(rerun)) - psi(1, a2(rerun)+b2(rerun));
    
    diff(rerun) = abs(m1(rerun)-m2(rerun));
    var(rerun) = var1(rerun) + var2(rerun);
    [sorted, idx] = sort(diff, 'descend');
    thresh = sorted(k);
    rerun = abs(diff-thresh)./sqrt(var + max(var(idx(1:k)))) < z;
    n_run = n_run + 1;
end

end
