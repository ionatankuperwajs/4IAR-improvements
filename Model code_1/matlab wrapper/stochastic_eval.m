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
all_params = [5.240253,0.001015,0.477450,0.001904,0.578534,0.233708,0.017500,0.952605,0.472643,0.990522,0.654052,3.793738,8.953413;
              6.034425,0.001021,0.440017,0.003166,0.622133,0.005623,0.922853,1.006988,0.004981,0.938126,0.716403,4.008404,8.028291;
              6.994361,0.001002,0.569741,0.001392,0.505345,0.000004,0.029897,0.568314,0.408340,1.222013,0.679645,5.517925,9.417359;
              6.810057,0.001051,0.514628,0.006453,0.699316,0.000610,0.002712,0.960683,0.000116,1.174333,0.514589,4.699681,9.443285;
              3.913951,0.001444,0.358451,0.002384,0.505633,0.483213,0.000842,0.000497,0.012801,0.899102,0.611912,3.166215,9.648018;
              4.211040,0.001210,0.356149,0.001673,0.564249,0.105293,0.481886,0.910134,0.387983,0.935402,0.699426,3.453589,8.497011];
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