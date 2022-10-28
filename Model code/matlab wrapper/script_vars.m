function vars = script_vars(data)

if ~exist('data','var') || isempty(data)
    data = load_data_mat('../../train/network_0.csv');
end

Ns = [10,20,40,80];
c = [1,2,4,8];

vars = zeros(length(Ns), length(c));


for i_N = 1:length(Ns)
    for i_c = 1:length(c)
        fprintf('started N=%d, c=%d\n', Ns(i_N), c(i_c));
        vars(i_N,i_c) = get_var(Ns(i_N), c(i_c), data);
    end
end
end


function v = get_var(N, c, data)
theta = [2,0.02,0.2,0.05,1.2,0.8,1,0.4,3.5,10]; 
n_rep = 100;

L = zeros(n_rep,N);

for i = 1:100
    L(i,:) = estimate_loglik_ibs_stochastic(data,theta,c,N);
end

% mean(L(:))
v = var(mean(L,2));
end