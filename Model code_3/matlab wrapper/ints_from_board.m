function [intb, intw] = ints_from_board(board)

basis = uint64(2) .^ uint64(0:35);

intb = sum(uint64(board==1) .* basis);
intw = sum(uint64(board==-1) .* basis);