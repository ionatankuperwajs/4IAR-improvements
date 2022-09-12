% install_mex

% Load the data and params
in_path = '/Users/ionatankuperwajs/Desktop/network_0.csv';
data = load_data_mat(in_path);

params_path = '/Users/ionatankuperwajs/Desktop/out_params.csv';
params = csvread(params_path);

% Add the opening param and set other variables
opening_weight = [1, 1, 1, 1];
theta = [params(1:6) opening_weight params(7:end)];
times = 25;
Nevals = 2000;

% Evaluate the model
times = int32(times);
data_cell = num2cell(data);

pad_theta = pad_input(theta);

i = 1;
% loglik = estimate_loglik_mex(data_cell(i,:)',pad_theta,times)';
move_hists = get_move_hist(data_cell(i,:)',pad_theta,Nevals);