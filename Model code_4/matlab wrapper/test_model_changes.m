% install_mex

% Load the data and params
% in_path = '/Users/ionatankuperwajs/Desktop/network_0.csv';
% data = load_data_mat(in_path);

params_path = '/Users/ionatankuperwajs/Desktop/out_params.csv';
params = csvread(params_path);

% Add the opening param and set other variables
opening_weight = 5;
weight_defensive = 100;
theta = [params(1:6) opening_weight params(7:end) weight_defensive];
times = 25;
Nevals = 2000;

% Evaluate the model
times = int32(times);
data_cell = num2cell(data);

thresh = theta(1);
delta = theta(3);
w_center = theta(6);
w_opening = theta(7);
w = [theta(8); theta(9); theta(10); theta(11)];
lambda = theta(4);
c_act = theta(5);
gamma = theta(2);
pad_theta=[10000;  thresh; gamma; lambda; 1; 1; w_center; w_opening; repmat(w,4,1); 0; c_act*repmat(w,4,1); 0; repmat(delta,17,1)];

% Add the weight from the new feature to the three-in-a-row weights
pad_theta(11) = pad_theta(11)+theta(12);
pad_theta(15) = pad_theta(15)+theta(12);
pad_theta(19) = pad_theta(19)+theta(12);
pad_theta(23) = pad_theta(23)+theta(12);

% i = 1;
% loglik = estimate_loglik_mex(data_cell(i,:)',pad_theta,times)';
% move_hists2 = get_move_hist(data_cell(i,:)',pad_theta,Nevals);

% Define a board with an opponent 3-in-a-row (simple example, then variations on the presentation example)
% data_cell_test = {[uint64(1104)] [uint64(7)] [uint64(0)] [uint64(8)]};
data_cell_test = {[uint64(5379751952)] [uint64(36641440270)] [uint64(0)] [uint64(1)]};
% data_cell_test = {[uint64(5379751952)] [uint64(36641702400)] [uint64(0)] [uint64(1)]};
move_hists = get_move_hist(data_cell_test',pad_theta,Nevals);
