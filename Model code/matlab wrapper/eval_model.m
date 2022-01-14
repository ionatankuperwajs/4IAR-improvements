function [loglik, move_hists] = eval_model(data,theta,times,Nreps)
%GENERATE_RESP_FOURINAROW Generate responses for four-in-a-row model.

times = int32(times .* ones(size(data,1),1));
data_cell = num2cell(data);

pad_theta = pad_input(theta);
loglik=estimate_loglik_mex(data_cell',pad_theta,times)';
move_hists=get_move_hist(data_cell',pad_theta,Nreps);

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
w = [theta(7); theta(8); theta(9); theta(10)];
lambda = theta(4);
c_act = theta(5);
gamma = theta(2);
theta=[10000;  thresh; gamma; lambda; 1; 1; w_center; repmat(w,4,1); 0; c_act*repmat(w,4,1); 0; repmat(delta,17,1)];

end