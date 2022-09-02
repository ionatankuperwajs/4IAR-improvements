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

thresh = theta(1);      % pruning threshold
delta = theta(3);       % 
w_center = theta(6);    % center weight
w_opening = theta(7);   % opening weight
w = [theta(8); theta(9); theta(10); 10000];
w_defensive = theta(11);
lambda = theta(4);
c_act = theta(5);
gamma = theta(2);
theta=[10000;  thresh; gamma; lambda; 1; 1; w_center; w_opening; repmat(w,4,1); 0; c_act*repmat(w,4,1); 0; repmat(delta,17,1)];

% Addition: add the defensive weight to the three-in-a-row weights
theta(11) = theta(11)+w_defensive;
theta(15) = theta(15)+w_defensive;
theta(19) = theta(19)+w_defensive;
theta(23) = theta(23)+w_defensive;

end