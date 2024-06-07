% Specify the file names for each test
filenames = {'data_test_1.txt', 'data_test_2.txt', 'data_test_3.txt'};

% Constants
R = 8.31; % Gas constant (J/mol*K)
V_m = 0.02008; % Molar volume (m^3/mol)
b = 3.772e-8; % Van der Waals constant (m^3/Pa)
a = 0.137258; % Van der Waals constant (Pa*m^6/mol^2)

% Initialize arrays to store data for each test
time_tests = cell(1, 3);
pressure_tests = cell(1, 3);
temperature_tests = cell(1, 3);

% Read data for each test
for test = 1:3
    % Read the data from the file assuming no headers
    data = readtable(filenames{test}, 'ReadVariableNames', false);

    % Assign meaningful variable names
    data.Properties.VariableNames = {'Time_s_', 'Pressure_Pa_', 'Temperature_C_'};

    % Extract columns
    time_tests{test} = data{:, 'Time_s_'};
    pressure_tests{test} = data{:, 'Pressure_Pa_'};
    temperature_tests{test} = data{:, 'Temperature_C_'};
end

% Plot time vs. pressure for each test
for test = 1:3
    figure;
    plot(time_tests{test}, pressure_tests{test}, 'o');
    hold on;
    % Fit a polynomial model (e.g., 4th degree polynomial) to pressure data
    p = polyfit(time_tests{test}, pressure_tests{test}, 4);
    % Generate fitted pressure values using the polynomial model
    pressure_fit = polyval(p, time_tests{test});
    % Plot the fitted curve
    plot(time_tests{test}, pressure_fit, '-r');
    xlabel('Time (s)');
    ylabel('Pressure (Pa)');
    title(['Test ', num2str(test), ': Time vs. Pressure with Fitted Curve']);
    legend('Measured Data', 'Fitted Curve');
    grid on;
    % Save the plot as an image file (optional)
    saveas(gcf, ['time_vs_pressure_test_', num2str(test), '.png']);
end

% Plot time vs. temperature for each test
for test = 1:3
    figure;
    plot(time_tests{test}, temperature_tests{test}, 'o', 'Color', 'b');
    hold on;
    plot(time_tests{test}, temperature_tests{test}, '-r');
    plot(time_tests{test}, temperature_tests{test}, '-r', 'LineWidth', 2); % Add red line
    xlabel('Time (s)');
    ylabel('Temperature (°C)');
    title(['Test ', num2str(test), ': Time vs. Temperature']);
    grid on;
    % Save the plot as an image file (optional)
    saveas(gcf, ['time_vs_temperature_test_', num2str(test), '.png']);
end

% Calculate the average pressure and temperature at each time instant
avg_pressure_all = mean(cat(3, pressure_tests{:}), 3);
avg_temperature_all = mean(cat(3, temperature_tests{:}), 3);

% Calculate standard deviation of pressure and temperature at each time instant
std_pressure_all = std(cat(3, pressure_tests{:}), 0, 3);
std_temperature_all = std(cat(3, temperature_tests{:}), 0, 3);

% Plot the average pressure with error bars and a fitted curve
figure;
errorbar(time_tests{1}, avg_pressure_all, std_pressure_all, 'o', 'MarkerEdgeColor', 'blue', 'MarkerFaceColor', 'blue');
xlabel('Time (s)');
ylabel('Average Pressure (Pa)');
title('Average Pressure Across Tests');
grid on;
hold on;

% Fit a polynomial model to average pressure data
p_avg_pressure = polyfit(time_tests{1}, avg_pressure_all, 4);
pressure_fit_avg = polyval(p_avg_pressure, time_tests{1});
plot(time_tests{1}, pressure_fit_avg, '-r');
legend('Average Pressure', 'Fitted Curve');

% Calculate theoretical pressure based on Van der Waals equation
P_theoretical = (R .* (avg_temperature_all + 273.15)) ./ (V_m - b) - (a ./ V_m.^2);
plot(time_tests{1}, P_theoretical, '-g'); % Add theoretical pressure line

hold off;

% Save the plot as an image file (optional)
saveas(gcf, 'average_pressure_across_tests.png');

% Plot the average temperature with error bars and red line
figure;
errorbar(time_tests{1}, avg_temperature_all, std_temperature_all, 'o', 'MarkerEdgeColor', 'blue', 'MarkerFaceColor', 'blue');
hold on;
plot(time_tests{1}, avg_temperature_all, '-r', 'LineWidth', 2); % Add red line
xlabel('Time (s)');
ylabel('Average Temperature (°C)');
title('Average Temperature Across Tests');
grid on;
legend('Average Temperature', 'Red Line');
hold off;

% Save the plot as an image file (optional)
saveas(gcf, 'average_temperature_across_tests.png');

% Display a message
disp('Plots created and saved');


