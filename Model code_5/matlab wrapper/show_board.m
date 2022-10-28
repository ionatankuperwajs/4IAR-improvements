function show_board(black, white, move)
% function show_board(black, white)
% black and white should be the integers defining the black and white
% pieces respectively (uint64)

if ~exist('move', 'var') || isempty(move)
    move = 0;
end

move_b = dec2bin(move, 4*9);
black_b = dec2bin(black, 4*9);
white_b = dec2bin(white, 4*9);

char = '                                    ';

for i = 1:36
    if black_b(i) == '1'
        char(i) = 'o';
    elseif white_b(i) == '1'
        char(i) = 'x';
    elseif move_b(i) == '1'
        char(i) = 'm';
    end
end

char_final = [
    '|---------|\n|', ...
    char(1:9),'|\n|',...
    char(10:18),'|\n|',...
    char(19:27),'|\n|',...
    char(28:36),...
    '|\n|---------|\n'];

fprintf(char_final)
