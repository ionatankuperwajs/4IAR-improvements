function show_biggest_diffs(data, k, ab_mat, direction)
% This uses the output of find_biggest_diffs to show the boards that were
% most different.
% input:
% the dataset used data
% how many boards to show k
% and [a1, a2, b1, b2] the success and failure counts
% using optional switch direction, you can choose to show
% positive or negative differences only by setting to any positive or
% negative number. Default is 0 -> both are shown

if ~exist('direction', 'var') || isempty(direction)
    direction = 0
end

a1 = ab_mat(:,1);
a2 = ab_mat(:,2);
b1 = ab_mat(:,3);
b2 = ab_mat(:,4);

m1 = psi(a1) - psi(a1+b1);
m2 = psi(a2) - psi(a2+b2);
var1 = psi(1, a1) - psi(1, a1+b1);
var2 = psi(1, a2) - psi(1, a2+b2);

diff = m1-m2;
var = var1 + var2;
if direction > 0
    [sorted, idx] = sort(diff, 'descend');
elseif direction < 0
    [sorted, idx] = sort(diff, 'ascend');
else
    [sorted, idx] = sort(abs(diff), 'descend');
end

for i = 1:k
    fprintf('Move %i: LL1 = %f, LL2 = %f\n', idx(i), m1(idx(i)), m2(idx(i)));
    fprintf('diff = %f \x00B1 %f \n', diff(idx(i)), sqrt(var(idx(i))));
    show_board(data(idx(i), 1), data(idx(i), 2), data(idx(i), 4));
    fprintf('\n')
end


end
