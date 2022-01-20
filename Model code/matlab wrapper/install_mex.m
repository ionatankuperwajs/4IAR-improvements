cd ../CPP
mex -R2018a -v -output estimate_loglik_mex CXXFLAGS="$CXXFLAGS -Wall -pthread -Wextra -std=c++11 -O3 -fexpensive-optimizations" estimate_loglik_mex.cpp heuristic.cpp bfs.cpp features.cpp data_struct.cpp;
mex -R2018a -v -output get_move_hist CXXFLAGS="$CXXFLAGS -Wall -pthread -Wextra -std=c++11 -O3 -fexpensive-optimizations" get_move_hist.cpp heuristic.cpp bfs.cpp features.cpp data_struct.cpp;
cd ../'matlab wrapper'/
movefile ../CPP/estimate_loglik_mex.mex* .
movefile ../CPP/get_move_hist.mex* .