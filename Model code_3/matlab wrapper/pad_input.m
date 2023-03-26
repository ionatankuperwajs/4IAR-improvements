function theta = pad_input(theta)
%PAD_INPUT Add other fixed parameters for four-in-a-row model.

g=sprintf('%f ', theta);
fprintf('Theta = %s\n', g)

thresh = theta(1);      % pruning threshold
delta = theta(3);       % feature drop rate
w_center = theta(5);    % center weight
w_opening = [theta(6); theta(7); theta(8); theta(9)];  % corner opening weights
w = [theta(10); theta(11); theta(12); 10000];           % feature weights, 4-in-a-row fixed
w_pseudo3 = theta(13);      % 3-in-a-row feature weight with no space for 4, at the ends of the board
w_defensive = theta(14);    % weight for defending against immediate losses
lambda = theta(4);      % lapse rate
% c_act = theta(5);     % active-passive scaling
c_act = 1;              % fixed active-passive scaling
gamma = theta(2);       % stopping probability
theta=[10000;  thresh; gamma; lambda; 1; 1; w_center; w_opening; repmat(w,4,1); 0; w_pseudo3; c_act*repmat(w,4,1); 0; c_act*w_pseudo3; repmat(delta,18,1)];

% Addition: add the defensive weight to the three-in-a-row weights
theta(14) = theta(14)+w_defensive;
theta(18) = theta(18)+w_defensive;
theta(22) = theta(22)+w_defensive;
theta(26) = theta(26)+w_defensive;

end