% Function to run the evaluation for a set of parameters without fitting
function [params,loglik_train] = stochastic_eval(direc, out_path)

% Load all the groups
files = dir(direc);
group = cell(length(files)-2, 1);
parfor i=3:length(files)
	group{i-2}=load_data_mat(fullfile(direc,files(i).name));
end	

data = cat(1, group{:});

% Hard code the parameters and evaluate
params = [7.114438,0.001002,0.546904,0.003875,0.666520,0.057210,0.004845,0.515519,0.134182,1.412705,0.818484,5.102661,5.016396];
params

c=1;
Ntrials=100000;
fun=@(x) mean(estimate_loglik_ibs_stochastic_sem(data,x,c,Ntrials));
for i=1:10
	loglik(i) = fun(params);
end

loglik_train = [loglik mean(loglik)];

% Save outputs to csv
param_path = sprintf('%s_params.csv', out_path);
lltrain_path = sprintf('%s_lltrain.csv', out_path);

csvwrite(param_path,params);
csvwrite(lltrain_path,loglik_train);

end