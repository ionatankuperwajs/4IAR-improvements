function theta = pad_input(theta)
%PAD_INPUT Add other fixed parameters for four-in-a-row model.

g=sprintf('%f ', theta);
fprintf('Theta = %s\n', g)

thresh = theta(1);      % pruning threshold
delta = theta(3);       % 
w_center = theta(5);    % center weight
w_opening = theta(6);   % opening weight
w = [theta(7); theta(8); theta(9); 10000];
w_defensive = 100; %theta(10);
lambda = theta(4);
c_act = 1; % theta(5);
gamma = theta(2);
theta=[10000;  thresh; gamma; lambda; 1; 1; w_center; w_opening; repmat(w,4,1); 0; c_act*repmat(w,4,1); 0; repmat(delta,17,1)];

% Addition: add the defensive weight to the three-in-a-row weights
theta(11) = theta(11)+w_defensive;
theta(15) = theta(15)+w_defensive;
theta(19) = theta(19)+w_defensive;
theta(23) = theta(23)+w_defensive;

end