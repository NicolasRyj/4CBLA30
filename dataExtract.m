% MATLAB script to read data from Arduino and save it to a text file

% Define serial port and baud rate
serialPort = 'COM10';
baudRate = 9600;

% Create serial object
s = serial(serialPort, 'BaudRate', baudRate);

% Open serial port
fopen(s);

% Prepare to save data
fileID = fopen('data.txt', 'w');
fprintf(fileID, 'Time (s),Pressure (Pa),Temperature (C)\n');

% Read and save data
disp('Reading data.');

try
    while true
        data = fscanf(s);
        fprintf(fileID, '%s', data);
        disp(data);
    end
catch
    % Close the serial port and file if an error occurs
    fclose(s);
    fclose(fileID);
    disp('Data reading stopped.');
end

% Close the serial port and file
fclose(s);
fclose(fileID);
