% install_mex
% 
% % Load the data and params
% in_path = '/Users/ionatankuperwajs/Desktop/network_0.csv';
% data = load_data_mat(in_path);
% 
% params_path = '/Users/ionatankuperwajs/Desktop/out_params.csv';
% params = csvread(params_path);

% Add the opening param and set other variables
cauchy = 1;
center_x = 1.0;
center_y = 1.0;
theta = [params(1:6) cauchy center_x center_y params(7:end)];
times = 25;
Nevals = 2000;

% Evaluate the model
times = int32(times);
data_cell = num2cell(data);

thresh = theta(1);
delta = theta(3);
w_center = theta(6);
cauchy = theta(7);
center_x = theta(8);
center_y = theta(9);
w = [theta(10); theta(11); theta(12); theta(13)];
lambda = theta(4);
c_act = theta(5);
gamma = theta(2);
pad_theta=[10000;  thresh; gamma; lambda; 1; 1; w_center; cauchy; center_x; center_y; repmat(w,4,1); 0; c_act*repmat(w,4,1); 0; repmat(delta,17,1)];

i = 2;
% loglik = estimate_loglik_mex(data_cell(i,:)',pad_theta,times)';
move_hists2 = get_move_hist(data_cell(i,:)',pad_theta,Nevals);