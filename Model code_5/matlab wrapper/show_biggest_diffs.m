function show_biggest_diffs(data, k, ab_mat)
% This uses the output of find_biggest_diffs to show the boards that were
% most different.
% input:
% the dataset used data
% how many boards to show k
% and [a1, a2, b1, b2] the success and failure counts 

a1 = ab_mat(:,1);
a2 = ab_mat(:,2);
b1 = ab_mat(:,3);
b2 = ab_mat(:,4);

ns = 1:100000;
tab = psi(ns) - psi(1);

m1 = psi(a1) - psi(a1+b1);
m2 = psi(a2) - psi(a2+b2);
% var1 = psi(1, a1) - psi(1, a1+b1);
% var2 = psi(1, a2) - psi(1, a2+b2);

diff = m1-m2;
% var = var1 + var2;
[sorted, idx] = sort(abs(diff), 'descend');

for i = 1:k
    fprintf('Move %i: diff = %d\n', idx(i), diff(idx(i)));
    show_board(data(idx(i), 1), data(idx(i), 2), data(idx(i), 4));
    fprintf('\n')
end


end
