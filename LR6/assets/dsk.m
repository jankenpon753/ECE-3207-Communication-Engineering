% Parameters
fs = 10000;          % Sampling frequency
// t = 0:1/fs:0.1;      % Time vector for 100 ms
t = 0:1/fs:1;      % Time vector for 1 second
f_carrier = 1000;    % Carrier frequency
bit_rate = 10;       % Bit rate
bits = [1 0 1 1 0 1 0 0 1 0]; % Input digital signal

% Generate input digital signal (square wave)
samples_per_bit = fs / bit_rate;
input_signal = repelem(bits, samples_per_bit);

% Ensure input_signal matches the length of t
input_signal = input_signal(1:length(t));

% ASK Modulation
ask_signal = input_signal .* sin(2 * pi * f_carrier * t);

% FSK Modulation
f1 = 500;  % Frequency for bit 0
f2 = 1500; % Frequency for bit 1
fsk_signal = (input_signal == 0) .* sin(2 * pi * f1 * t) + (input_signal == 1) .* sin(2 * pi * f2 * t);

% PSK Modulation
psk_signal = sin(2 * pi * f_carrier * t + pi * input_signal);

% ASK Demodulation
ask_demodulated = ask_signal .* sin(2 * pi * f_carrier * t);
[b, a] = butter(6, f_carrier/(fs/2));
ask_demodulated = filter(b, a, ask_demodulated);
ask_demodulated = ask_demodulated > 0.5;

% Plotting
figure;

% Plot input digital signal
subplot(5,1,1);
plot(t, input_signal);
title('Input Digital Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot ASK signal
subplot(5,1,2);
plot(t, ask_signal);
title('ASK Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot FSK signal
subplot(5,1,3);
plot(t, fsk_signal);
title('FSK Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot PSK signal
subplot(5,1,4);
plot(t, psk_signal);
title('PSK Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot ASK demodulated signal
subplot(5,1,5);
plot(t, ask_demodulated);
title('ASK Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');