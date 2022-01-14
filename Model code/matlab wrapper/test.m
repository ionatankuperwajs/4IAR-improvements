% Function to fit model with 5-fold cross-validation on a single user from
% peak dataset. Splits must be pre-generated using
% auto_split.m/generate_splits.m.
function [moves,loglik] = test(direc, params_path, out_path)

% Load all the groups
files = dir(direc);
group = cell(length(files)-2, 1);
for i=3:length(files)
	group{i-2}=load_data_mat(fullfile(direc,files(i).name));
end

data = cat(1, group{:});

% Load the parameters
params = csvread(paramspath)

% Fit model to testing data
c = 1;
Nevals = 100;
[loglik, moves] = eval_model(data,params,c,Nevals);

% Save outputs to csv
moves_path = sprintf('%s_moves.csv', out_path);
lltest_path = sprintf('%s_lltest.csv', out_path);

csvwrite(moves_path,moves);
csvwrite(lltest_path,loglik);

end
