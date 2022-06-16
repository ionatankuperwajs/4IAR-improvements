function loglik=estimate_loglik_ibs_stochastic(data,theta,times,Ntrials)
%GENERATE_RESP_FOURINAROW Generate responses for four-in-a-row model.

times = int32(times .* ones(Ntrials,1));
idx = randi(size(data,1),Ntrials,1);
data_cell = num2cell(data(idx, :));

loglik=estimate_loglik_mex(data_cell',pad_input(theta),times)';

%compilation command for mex file
%mex -R2018a -v -output estimate_loglik_mex CXXFLAGS="$CXXFLAGS -Wall -pthread -Wextra -std=c++11 -O3 -fexpensive-optimizations" estimate_loglik_mex.cpp heuristic.cpp bfs.cpp features.cpp data_struct.cpp;

end

%--------------------------------------------------------------------------
function theta = pad_input(theta)
%PAD_INPUT Add other fixed parameters for four-in-a-row model.

g=sprintf('%f ', theta);
fprintf('Theta = %s\n', g)

thresh = theta(1);
delta = theta(3);
w_center = theta(6);
w_opening = theta(7);
cauchy = theta(8);
center_x = theta(9);
center_y = theta(10);
w = [theta(11); theta(12); theta(13); theta(14)];
lambda = theta(4);
c_act = theta(5);
gamma = theta(2);
theta=[10000;  thresh; gamma; lambda; 1; 1; w_center; w_opening; cauchy; center_x; center_y; repmat(w,4,1); 0; c_act*repmat(w,4,1); 0; repmat(delta,17,1)];

end