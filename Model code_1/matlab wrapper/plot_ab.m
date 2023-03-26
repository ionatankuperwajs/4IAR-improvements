function plot_ab(ab_mat, rerun)

a1 = ab_mat(:,1);
a2 = ab_mat(:,2);
b1 = ab_mat(:,3);
b2 = ab_mat(:,4);

m1 = psi(a1) - psi(a1+b1);
m2 = psi(a2) - psi(a2+b2);

plot(m1,m2,'k.', 'MarkerSize', 10);

range = [min(min(m1), min(m2)), max(max(m1), max(m2))];
hold on
plot(range, range, 'k--', 'LineWidth', 2)
hold off

if exist('rerun', 'var')
    hold on
    plot(m1(rerun), m2(rerun), 'r.', 'MarkerSize', 10);
    hold off
end

xlabel('LL with theta1')
ylabel('LL with theta2')
drawnow
