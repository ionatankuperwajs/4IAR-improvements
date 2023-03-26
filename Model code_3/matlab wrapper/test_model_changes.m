% % install_mex

% Load the data and params
in_path = '/Users/ionatankuperwajs/Desktop/network_0.csv';
data = load_data_mat(in_path);

% Set parameters
times = 25;
Nevals = 2000;

theta = [3.1037,0.0080886,0.31561,0.05027,0.85213,0.62313,0.055551,0.062713,0.33942,0.,0.9332,0.68056,4.2969,100,10];

% Evaluate the model
times = int32(times);
data_cell = num2cell(data);

pad_theta = pad_input(theta);

i = 1;
% loglik = estimate_loglik_mex(data_cell(i,:)',pad_theta,times)';
move_hists = get_move_hist(data_cell(i,:)',pad_theta,Nevals);

% Define a board with an opponent 3-in-a-row (simple example, then variations on the presentation example)
% data_cell_test = {[uint64(1104)] [uint64(7)] [uint64(0)] [uint64(8)]};
data_cell_test = {[uint64(5379751952)] [uint64(36641440270)] [uint64(0)] [uint64(1)]};
% data_cell_test = {[uint64(5379751952)] [uint64(36641702400)] [uint64(0)] [uint64(1)]};
% data_cell_test = {[uint64(5396496400)] [uint64(36641440270)] [uint64(0)] [uint64(1)]};
move_hists = get_move_hist(data_cell_test',pad_theta,Nevals);

% Define a board with pseudo 3-in-a-rows (presentation example and its inverse)
data_cell_test = {[uint64(513)] [uint64(1028)] [uint64(0)] [uint64(1)]};
% data_cell_test = {[uint64(1028)] [uint64(513)] [uint64(0)] [uint64(1)]};
move_hists = get_move_hist(data_cell_test',pad_theta,Nevals);
