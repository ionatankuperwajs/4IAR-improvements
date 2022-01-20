#include "heuristic.h"
#include "board_list.h"
#include "mex.h"
#include "matrix.h"

#include <ctime>
#include <chrono>
using namespace std;

uint64_t GetLowestBitPos(uint64_t value)
{
   unsigned pos = 0;
   if(value == 0){
     return pos;
   }
   while (!(value & 1))
   {
      value >>= 1;
      ++pos;
   }
   return pos;
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]){
  heuristic h;
  random_device rd;
  mt19937_64 global_generator(rd());
  const mwSize *dims = mxGetDimensions(prhs[0]);
  const unsigned int N = dims[1];
  board b;
  bool player;
  uint64 m, m_bas, m_mine;
  double* paramptr=mxGetPr(prhs[1]);
  int Nrep = (int) mxGetScalar(prhs[2]);

  cout<<Nrep<<endl;

  h.get_params_from_array(paramptr);
  h.seed_generator(global_generator);

  plhs[0] = mxCreateNumericMatrix(36, N, mxUINT64_CLASS, mxREAL);
  uint64_t* output = (uint64_t*) mxGetData(plhs[0]);

  for(unsigned int i=0;i<N;i++){
    for(unsigned int j=0;j<36;j++){
      output[j + 36*i] = (uint64_t) 0;
    }
  }


  for(unsigned int i=0;i<N;i++){
    b.pieces[BLACK] = *mxGetUint64s(mxGetCell(prhs[0],i*4));
    b.pieces[WHITE] = *mxGetUint64s(mxGetCell(prhs[0],i*4+1));
    player = *mxGetLogicals(mxGetCell(prhs[0],i*4+2));
    for(int j=0; j<Nrep; j++){
      m = h.makemove_bfs(b, player).zet_id;
      // m_mine = GetLowestBitPos(m);
      m_bas = uint64totile(m);
      // cout<<m<<','<<m_mine<<','<<m_bas<<endl;
      output[36*i + m_bas] += 1;
    }
  }
}
