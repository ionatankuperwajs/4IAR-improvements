function theta = pad_input(theta)
%PAD_INPUT Add other fixed parameters for four-in-a-row model.

g=sprintf('%f ', theta);
fprintf('Theta = %s\n', g)

thresh = theta(1);      % pruning threshold
delta = theta(3);       % feature drop rate
w_center = theta(6);    % center weight
w_decay = theta(7);     % centrality decay
w_opening = [theta(8); theta(9); theta(10); theta(11)];  % corner opening weights
w = [theta(12); theta(13); theta(14); 10000];           % feature weights, 4-in-a-row fixed
w_pseudo3 = theta(15);      % 3-in-a-row feature weight with no space for 4, at the ends of the board
w_defensive = theta(16);    % weight for defending against immediate losses
lambda = theta(4);      % lapse rate
c_act = theta(5);       % active-passive scaling
gamma = theta(2);       % stopping probability
theta=[10000;  thresh; gamma; lambda; 1; 1; w_center; w_decay; w_opening; repmat(w,4,1); 0; w_pseudo3; c_act*repmat(w,4,1); 0; c_act*w_pseudo3; repmat(delta,18,1)];

% Addition: add the defensive weight to the three-in-a-row weights
theta(15) = theta(15)+w_defensive;
theta(19) = theta(19)+w_defensive;
theta(23) = theta(23)+w_defensive;
theta(27) = theta(27)+w_defensive;

end