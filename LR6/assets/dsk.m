% Parameters
fs = 10000;          % Sampling frequency
t = 0:1/fs:1;        % Time vector for 1 second
f_carrier = 100;     % Further lowered Carrier frequency
bit_rate = 10;       % Bit rate
bits = [1 0 1 1 0 1 0 0 1 0]; % Input digital signal

% Generate input digital signal (square wave)
samples_per_bit = round(fs / bit_rate); % Ensure samples_per_bit is an integer
t = 0:1/fs:(length(bits) * samples_per_bit - 1) / fs; % Adjust t to match input_signal length
input_signal = repelem(bits, samples_per_bit);

% ASK Modulation
carrier_signal = sin(2 * pi * f_carrier * t); % Generate carrier signal
ask_signal = input_signal .* carrier_signal; % Modulate carrier with input signal

% FSK Modulation
f1 = 50;   % Further lowered frequency for bit 0
f2 = 150;  % Further lowered frequency for bit 1
fsk_signal = (input_signal == 0) .* sin(2 * pi * f1 * t) + (input_signal == 1) .* sin(2 * pi * f2 * t);

% PSK Modulation
psk_signal = sin(2 * pi * f_carrier * t + pi * input_signal);

% ASK Demodulation
ask_demodulated = ask_signal .* carrier_signal; % Multiply with carrier signal
[b, a] = butter(6, f_carrier/(fs/2));          % Low-pass filter design
ask_demodulated = filter(b, a, ask_demodulated); % Apply low-pass filter
ask_demodulated = ask_demodulated > 0.25;       % Thresholding for binary signal

% Plotting
figure;

% Plot input digital signal
subplot(5,1,1);
plot(t, input_signal, 'LineWidth', 1.5); % Thicker line
title('Input Digital Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot ASK signal
subplot(5,1,2);
plot(t, ask_signal, 'LineWidth', 1.5); % Thicker line
title('ASK Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot FSK signal
subplot(5,1,3);
plot(t, fsk_signal, 'LineWidth', 1.5); % Thicker line
title('FSK Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot PSK signal
subplot(5,1,4);
plot(t, psk_signal, 'LineWidth', 1.5); % Thicker line
title('PSK Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot ASK demodulated signal
subplot(5,1,5);
plot(t, ask_demodulated, 'LineWidth', 1.5); % Thicker line
title('ASK Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');