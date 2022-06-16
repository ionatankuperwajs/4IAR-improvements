% Function to fit model without 5-fold cross-validation on a single pseudo-user from 
% the peak dataset
function [params,loglik_train] = stochastic(direc, out_path)

% Load all the groups
files = dir(direc);
group = cell(length(files)-2, 1);
for i=3:length(files)
	group{i-2}=load_data_mat(fullfile(direc,files(i).name));
end	

data = cat(1, group{:});

% Fit model to training data
[params,loglik_train] = fit_model_stochastic(data);

params

% Save outputs to csv
param_path = sprintf('%s_params.csv', out_path);
lltrain_path = sprintf('%s_lltrain.csv', out_path);

csvwrite(param_path,params);
csvwrite(lltrain_path,loglik_train);

end