% Parameters
% Amplitude of message signal in Volts
%Am = 0.4; % For Under Modulation
%Am = 0.54; % For 100% Modulation
Am = 0.9; % For Over Modulation
Fm = 1.761e3; % Frequency of message signal in Hz
Ac = 2.24; % Amplitude of carrier signal in Volts
Fc = 300.4e3; % Frequency of carrier signal in Hz
Fs = 1e6; % Sampling frequency in Hz
t = 0:1/Fs:1e-2; % Time vector for 1 ms
Ka = 1.87;

% Message signal
m_t = Am * cos(2 * pi * Fm * t);

% Carrier signal
c_t = Ac * cos(2 * pi * Fc * t);

% AM Modulated signal
s_t = Ac * (1 + Ka * m_t) .* cos(2 * pi * Fc * t);

% Demodulation
r_t = s_t .* cos(2 * pi * Fc * t);

% Low-pass filter design
[b, a] = butter(6, Fm/(Fs/2)); % 6th order Butterworth filter

% Filter the demodulated signal
m_rec = filter(b, a, r_t);

% Plotting the signals
figure;
subplot(4,1,1);
plot(t, m_t);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude (V)');

subplot(4,1,2);
plot(t, c_t);
title('Carrier Signal');
xlabel('Time (s)');
ylabel('Amplitude (V)');

subplot(4,1,3);
plot(t, s_t);
title('AM Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude (V)');

subplot(4,1,4);
plot(t, m_rec);
title('Demodulated Message Signal');
xlabel('Time (s)');
ylabel('Amplitude (V)');