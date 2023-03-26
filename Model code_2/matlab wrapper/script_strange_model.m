%% script for looking at big differences between strange model parameters

t_strange = [1.363,0.001215,0.35687,0.012228,0.43389,0.58037,0.048795,0.022445,0.10032,0.036601,1.1827,0.6398,3.8941,0,25.043];
t_normal = [2.6167,0.0014047,0.40547,0.042317,1.0326,0.56764,0.22385,3.13E-05,0.022767,0.49352,0.69621,0.47656,2.8876,0.35592,44.322];

theta_s = pad_input(t_strange);
theta_n = pad_input(t_normal);

%% load data
data = load_data_mat('../../test/network_54.csv');
dat = data(1:500,:);

%% find big deviations
if exist('ab_mat','var')
    ab_mat = find_biggest_diffs(dat, theta_s, theta_n, 10, 0.01, 100, ab_mat, 1);
else
    ab_mat = find_biggest_diffs(dat, theta_s, theta_n, 10, 0.01, 100, [], 1);
end

save('ab.mat', 'ab_mat');

%% show results
load('ab.mat')
show_biggest_diffs(dat, 20, ab_mat);