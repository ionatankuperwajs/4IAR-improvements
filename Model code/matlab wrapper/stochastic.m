% Function to fit model with 5-fold cross-validation on a single user from 
% peak dataset. Splits must be pre-generated using
% auto_split.m/generate_splits.m.
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
loglik_train = [loglik_train mean(loglik_train)];

params

% Save outputs to csv
param_path = sprintf('%s_params.csv', out_path);
lltrain_path = sprintf('%s_lltrain.csv', out_path);

csvwrite(param_path,params);
csvwrite(lltrain_path,loglik_train);

end