% Parameters
fs = 1000;          % Sampling frequency
t = 0:1/fs:1;       % Time vector
fc = 100;           % Carrier frequency
kf = 50;            % Frequency sensitivity
Am = 1;             % Amplitude of message signal
fm = 10;            % Frequency of message signal

% Message signal
m = Am * cos(2 * pi * fm * t);

% Carrier signal (square wave)
c = square(2 * pi * fc * t);

% FM Modulation
int_m = cumsum(m) / fs;  % Integral of message signal
s = cos(2 * pi * fc * t + 2 * pi * kf * int_m);

% FM Demodulation
y = diff([0 s]) * fs;    % Differentiate the FM signal
y = abs(hilbert(y));     % Envelope detection

% Modulation Index
beta = kf * Am / fm;
disp(['Modulation Index (beta): ', num2str(beta)]);

% Plotting
figure;

subplot(4,1,1);
plot(t, m);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4,1,2);
plot(t, c);
title('Carrier Signal (Square Wave)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4,1,3);
plot(t, s);
title('FM Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4,1,4);
plot(t, y(1:length(t)));
title('Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');