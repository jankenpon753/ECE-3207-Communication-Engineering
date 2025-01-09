% Define parameters
Fs = 1000; % Sampling frequency
t = 0:1/Fs:1; % Time vector

% Create message signal
Am = 1; % Amplitude of message signal
fm = 5; % Frequency of message signal
message_signal = Am * sin(2 * pi * fm * t);

% Create carrier signal
Ac = 1; % Amplitude of carrier signal
fc = 50; % Frequency of carrier signal
carrier_signal = Ac * sin(2 * pi * fc * t);

% Perform Amplitude Modulation (AM)
modulated_signal = (1 + message_signal) .* carrier_signal;

% Demodulate the signal
demodulated_signal = modulated_signal .* carrier_signal;
[b, a] = butter(5, fc/(Fs/2)); % Design a low-pass filter
filtered_signal = filter(b, a, demodulated_signal);

% Plot the signals
figure;
subplot(4,1,1);
plot(t, message_signal);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4,1,2);
plot(t, carrier_signal);
title('Carrier Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4,1,3);
plot(t, modulated_signal);
title('AM Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4,1,4);
plot(t, filtered_signal);
title('Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');