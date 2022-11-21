function [loglik, moves] = eval_model(data,theta,times,Nevals)
%GENERATE_RESP_FOURINAROW Generate responses for four-in-a-row model.

%times = int32(times .* ones(size(data,1),1));
times = int32(times);
data_cell = num2cell(data);

pad_theta = pad_input(theta);
%loglik=estimate_loglik_mex(data_cell',pad_theta,times)';

loglik = zeros(size(data_cell,1),1);
moves = zeros(36, size(data_cell,1));
parfor i=1:size(data_cell,1)
  loglik(i) = estimate_loglik_mex(data_cell(i,:)',pad_theta,times)';
  move_hists = get_move_hist(data_cell(i,:)',pad_theta,Nevals);
  moves(:, i) = move_hists;
end


%compilation commands for mex files
% mex -R2018a -v -output estimate_loglik_mex CXXFLAGS="$CXXFLAGS -Wall -pthread -Wextra -std=c++11 -O3 -fexpensive-optimizations" estimate_loglik_mex.cpp heuristic.cpp bfs.cpp features.cpp data_struct.cpp;
% mex -R2018a -v -output get_move_hist CXXFLAGS="$CXXFLAGS -Wall -pthread -Wextra -std=c++11 -O3 -fexpensive-optimizations" get_move_hist.cpp heuristic.cpp bfs.cpp features.cpp

end
