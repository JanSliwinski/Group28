% Define the range of Reynolds numbers and relative roughness values
Re = logspace(3, 8, 100);  % from 1,000 to 100,000,000
epsilon = [0.00001, 0.0001, 0.001, 0.01];  % example roughness values

% Prepare to plot
loglog(Re, zeros(size(Re)));  % initialize log-log plot
hold on;

% Calculate friction factor for each roughness value using the Colebrook equation
for e = epsilon
    f = zeros(size(Re));
    for i = 1:length(Re)
        func = @(f) 1/sqrt(f) + 2.0*log10(e/3.7 + 2.51/(Re(i)*sqrt(f)));
        f(i) = fzero(func, [0.008, 0.1]);  % initial guess and bounds for f
    end
    loglog(Re, f, 'DisplayName', sprintf('ε/D = %f', e));  % plot each line
end

% Customize the plot
grid on;
title('Moody Diagram');
xlabel('Reynolds number, Re');
ylabel('Friction factor, f');
legend('show');
hold off;
