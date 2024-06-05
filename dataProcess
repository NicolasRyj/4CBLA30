% MATLAB script to read data from a text file, plot time vs. pressure, and fit a model

% Specify the file name
filename = 'data.txt';

% Read the data from the file
data = readtable(filename);

% Extract time and pressure columns
time = data{:, 'Time_s_'};
pressure = data{:, 'Pressure_Pa_'};

% Create a plot of time vs. pressure
figure;
plot(time, pressure, 'o');
hold on;

% Fit a polynomial model (e.g., 2nd degree polynomial)
p = polyfit(time, pressure, 4);

% Generate fitted pressure values using the polynomial model
pressure_fit = polyval(p, time);

% Plot the fitted curve
plot(time, pressure_fit, '-r');

% Add labels, title, and legend
xlabel('Time (s)');
ylabel('Pressure (Pa)');
title('Time vs. Pressure with Fitted Curve');
legend('Measured Data', 'Fitted Curve');
grid on;

% Save the plot as an image file (optional)
saveas(gcf, 'time_vs_pressure_fit.png');

% Display the plot
disp('Plot created and saved as time_vs_pressure_fit.png');
