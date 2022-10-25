install_mex

% Load the data and params
in_path = '/Users/ionatankuperwajs/Desktop/network_0.csv';
data = load_data_mat(in_path);

params_path = '/Users/ionatankuperwajs/Desktop/out_params.csv';
params = csvread(params_path);

% Set other variables
theta = params;
times = 25;
Nevals = 2000;

% Evaluate the model
times = int32(times);
data_cell = num2cell(data);

thresh = theta(1);
delta = theta(3);
w_center = theta(6);
w = [theta(7); theta(8); theta(9); theta(10)];
lambda = theta(4);
c_act = theta(5);
gamma = theta(2);
pad_theta=[10000;  thresh; gamma; lambda; 1; 1; w_center; repmat(w,4,1); 0; c_act*repmat(w,4,1); 0; repmat(delta,17,1)];

i = 2;
% loglik = estimate_loglik_mex(data_cell(i,:)',pad_theta,times)';
move_hists2 = get_move_hist(data_cell(i,:)',pad_theta,Nevals);