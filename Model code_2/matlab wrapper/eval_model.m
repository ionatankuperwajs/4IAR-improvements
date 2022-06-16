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

%--------------------------------------------------------------------------
function theta = pad_input(theta)
%PAD_INPUT Add other fixed parameters for four-in-a-row model.

g=sprintf('%f ', theta);
fprintf('Theta = %s\n', g)

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
theta=[10000;  thresh; gamma; lambda; 1; 1; w_center; cauchy; center_x; center_y; repmat(w,4,1); 0; c_act*repmat(w,4,1); 0; repmat(delta,17,1)];
end
