function theta = pad_input(theta)
%PAD_INPUT Add other fixed parameters for four-in-a-row model.

g=sprintf('%f ', theta);
fprintf('Theta = %s\n', g)

thresh = theta(1);
delta = theta(3);
w_center = theta(5);
w_opening = [theta(6); theta(7); theta(8); theta(9)];
w = [theta(10); theta(11); theta(12); theta(13)];
lambda = theta(4);
% c_act = theta(5);     % active-passive scaling
c_act = 1;              % fixed active-passive scaling
gamma = theta(2);
theta=[10000;  thresh; gamma; lambda; 1; 1; w_center; w_opening; repmat(w,4,1); 0; c_act*repmat(w,4,1); 0; repmat(delta,17,1)];

end