function theta = pad_input(theta)
%PAD_INPUT Add other fixed parameters for four-in-a-row model.

g=sprintf('%f ', theta);
fprintf('Theta = %s\n', g)

thresh = theta(1);      % pruning threshold
delta = theta(3);       % feature drop rate
w_center = theta(6);    % center weight
w_opening = [theta(7); theta(8); theta(9); theta(10)];
w = [theta(11); theta(12); theta(13); 10000];
w_pseudo3 = theta(14);
w_defensive = theta(15);
lambda = theta(4);      % lapse rate
c_act = theta(5);
gamma = theta(2);       % stopping probability
theta=[10000;  thresh; gamma; lambda; 1; 1; w_center; w_opening; repmat(w,4,1); 0; w_pseudo3; c_act*repmat(w,4,1); 0; c_act*w_pseudo3; repmat(delta,18,1)];

% Addition: add the defensive weight to the three-in-a-row weights
theta(14) = theta(14)+w_defensive;
theta(18) = theta(18)+w_defensive;
theta(22) = theta(22)+w_defensive;
theta(26) = theta(26)+w_defensive;

end