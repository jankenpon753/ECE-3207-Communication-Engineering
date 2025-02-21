% Parameters
fs = 10000;          % Sampling frequency
t = 0:1/fs:0.01;     % Time vector for 10 ms
frequencies = [250, 500, 1000, 2000];  % Frequencies of input signals
num_signals = length(frequencies);     % Number of input signals

% Generate input signals
input_signals = zeros(num_signals, length(t));
for i = 1:num_signals
    input_signals(i, :) = sin(2 * pi * frequencies(i) * t);
end

% TDM Multiplexing
multiplexed_signal = reshape(input_signals, 1, []);

% TDM Demultiplexing
demultiplexed_signals = reshape(multiplexed_signal, num_signals, []);

% Plotting
figure;

% Plot input signals
subplot(3,1,1);
hold on;
for i = 1:num_signals
    plot(t, input_signals(i, :));
end
title('Input Signals');
xlabel('Time (s)');
ylabel('Amplitude');
legend('250 Hz', '500 Hz', '1 kHz', '2 kHz');
hold off;

% Plot multiplexed signal
subplot(3,1,2);
plot(0:1/fs:(length(multiplexed_signal)-1)/fs, multiplexed_signal);
title('Multiplexed Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot demultiplexed signals
subplot(3,1,3);
hold on;
for i = 1:num_signals
    plot(t, demultiplexed_signals(i, :));
end
title('Demultiplexed Signals');
xlabel('Time (s)');
ylabel('Amplitude');
legend('250 Hz', '500 Hz', '1 kHz', '2 kHz');
hold off;
