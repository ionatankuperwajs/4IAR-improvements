function [a, b] = compare_to_dnn(data, theta, k, p, Nmax, start_vals)
% function compare_to_dnn(data, theta)
% takes the results file from the dnn as input and searches for
% moves with the largest log-likleihood difference to the model

if ~exist('k', 'var') || isempty(k)
    k = 3;
end
if ~exist('p', 'var') || isempty(p)
    p = 0.0001;
end
if ~exist('Nmax', 'var') || isempty(Nmax)
    Nmax = 10000;
end

z = abs(norminv(p/2));

% First generate the data
data_cell = cell(size(data,1), 4);
for i = 1:size(data, 1)
    [intb, intw] = ints_from_board(reshape(reshape(data(i,1:36), 4,9)', 1, 36));
    data_cell{i,1} = uint64(intb);
    data_cell{i,2} = uint64(intw);
    data_cell{i,3} = uint64(0);
    [k,l] = ind2sub([4,9],data(i,end)+1);
    data_cell{i,4} = uint64(2) ^ ((k-1) * 9 + (l-1));
end

norm = sum(exp(data(:, 37:72)), 2);
idx = sub2ind(size(data), (1:size(data,1))', 37 + data(:, end));
loglik_dnn = data(idx) - log(norm);


times = int32(ones(size(data,1),1));
ns = 1:100000;
tab = psi(ns) - psi(1);

if ~exist('start_vals', 'var') || isempty(start_vals)
    % first evaluation:
    fprintf('starting first run\n')
    loglik = estimate_loglik_mex(data_cell',theta,times)';
    n = round(interp1(tab, ns, loglik));
    a = ones(size(data,1),1);
    b = n - 1;
else
    a = start_vals(1);
    b = start_vals(2);
end

% run reps for the ones that were immediately right until they got a miss
while any(b<1)
    rerun = b<1;
    fprintf('repeating %d runs for the first model\n', sum(rerun));
    ll = estimate_loglik_mex(data_cell(rerun,:)',theta,times(rerun))';
    n = round(interp1(tab, ns, ll));
    a(rerun) = a(rerun) + 1;
    b(rerun) = b(rerun) + n - 1;
end

fprintf('starting main computation\n')
m = psi(a) - psi(a + b);
var = psi(1, a) - psi(1, a + b);

diff = abs(m - loglik_dnn);
[sorted, idx] = sort(diff, 'descend');
thresh = sorted(k);
rerun = abs(diff-thresh)./sqrt(var + var(idx(k))) < z;

n_run = 0;
while (n_run < Nmax) && (sum(rerun) > 1)
    fprintf('Run %d: %d of %d under consideration\n', n_run, sum(rerun), length(rerun))
    ll = estimate_loglik_mex(data_cell(rerun,:)', theta, times(rerun))';
    n = round(interp1(tab, ns, ll));
    a(rerun) = a(rerun) + 1;
    b(rerun) = b(rerun) + n - 1;
    
    m(rerun) = psi(a(rerun)) - psi(a(rerun)+b(rerun));
    var(rerun) = psi(1, a(rerun)) - psi(1, a(rerun)+b(rerun));
    
    diff(rerun) = abs(m(rerun) - loglik_dnn(rerun));
    [sorted, idx] = sort(diff, 'descend');
    thresh = sorted(k);
    rerun = abs(diff-thresh)./sqrt(var + var(idx(k))) < z;
    n_run = n_run + 1;
end


