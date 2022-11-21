function loglik=estimate_loglik_ibs_stochastic(data,theta,times,Ntrials)
%GENERATE_RESP_FOURINAROW Generate responses for four-in-a-row model.

times = int32(times .* ones(Ntrials,1));
idx = randi(size(data,1),Ntrials,1);
data_cell = num2cell(data(idx, :));

loglik=estimate_loglik_mex(data_cell',pad_input(theta),times)';

%compilation command for mex file
%mex -R2018a -v -output estimate_loglik_mex CXXFLAGS="$CXXFLAGS -Wall -pthread -Wextra -std=c++11 -O3 -fexpensive-optimizations" estimate_loglik_mex.cpp heuristic.cpp bfs.cpp features.cpp data_struct.cpp;

end