function [moves,loglik] = test_model_single(in_path, params_path, out_path)

% Load the group
data = load_data_mat(in_path);

% Load the parameters
params = csvread(params_path);

% evaluate model on testing data
c = 25;
Nevals = 200;

[loglik, moves] = eval_model(data,params,c,Nevals);

% reorder dimensions to be compatible to python neural networks:
moves = reshape(permute(flip(reshape(moves, 9, 4, []), 2), [3, 2, 1]), [], 36);

% Save outputs to csv
moves_path = sprintf('%s_moves.csv', out_path);
lltest_path = sprintf('%s_lltest.csv', out_path);

csvwrite(moves_path,moves);
csvwrite(lltest_path,loglik);

end
