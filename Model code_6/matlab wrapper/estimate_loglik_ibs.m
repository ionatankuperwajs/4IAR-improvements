function loglik=estimate_loglik_ibs(data,theta,times)
%GENERATE_RESP_FOURINAROW Generate responses for four-in-a-row model.

if nargin < 3 || isempty(times); times = int32(ones(size(data,1),1)); end

loglik=estimate_loglik_mex(data',pad_input(theta),times)';
%compilation command for mex file
%mex -R2018a -v -output estimate_loglik_mex CXXFLAGS="$CXXFLAGS -Wall -pthread -Wextra -std=c++11 -O3 -fexpensive-optimizations" estimate_loglik_mex.cpp heuristic.cpp bfs.cpp features.cpp data_struct.cpp;

end
