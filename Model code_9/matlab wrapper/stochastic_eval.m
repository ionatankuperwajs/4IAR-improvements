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
all_params = [8.480297,0.001038,0.491553,0.002406,0.611146,0.184731,1.215678,1.498565,0.333648,1.220677,1.080162,5.036999,0.271515,79.469361;
              6.376367,0.001117,0.505070,0.001001,0.610128,0.009439,0.116399,0.000632,0.065787,0.839799,0.594484,3.934887,0.000143,86.577564;
              9.999661,0.001146,0.540872,0.001178,0.667404,0.322625,0.032972,0.963092,0.928565,1.209239,0.512824,5.622412,4.536051,18.661824;
              9.999933,0.001000,0.399689,0.001051,0.628867,0.551982,0.000090,0.262547,0.152604,0.877087,0.530145,3.801352,0.274500,4.715270;
              9.963299,0.001001,0.546462,0.001023,0.627796,0.232883,0.004835,0.653392,0.011394,1.479065,0.713617,4.597989,1.358240,36.032320];
num_evals = size(all_params,1);

for j=1:num_evals

    params = all_params(j,:);
    params
    
    c=1;
    Ntrials=100000;
    fun=@(x) mean(estimate_loglik_ibs_stochastic_sem(data,x,c,Ntrials));
    for i=1:10
	    loglik(i) = fun(params);
    end
    
    loglik_train = [loglik mean(loglik)];
    
    % Save outputs to csv
    param_path = sprintf('%s_params%d.csv', out_path, j);
    lltrain_path = sprintf('%s_lltrain%d.csv', out_path, j);
    
    csvwrite(param_path,params);
    csvwrite(lltrain_path,loglik_train);
end

end