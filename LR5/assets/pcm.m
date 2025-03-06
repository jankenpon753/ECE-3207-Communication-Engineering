% Parameters
fs = 10000;          % Sampling frequency
t = 0:1/fs:0.01;     % Time vector for 10 ms
f = 1000;            % Frequency of input signal
A = 1;               % Amplitude of input signal
n_bits = 8;          % Number of bits for quantization

% Generate input signal
input_signal = A * sin(2 * pi * f * t);

% Quantization
L = 2^n_bits;        % Number of quantization levels
q_step = (2 * A) / L; % Quantization step size
quantized_signal = round(input_signal / q_step) * q_step;

% PCM Encoding
pcm_encoded = de2bi((quantized_signal / q_step) + (L/2), n_bits, 'left-msb');

% PCM Decoding
decoded_signal = (bi2de(pcm_encoded, 'left-msb') - (L/2)) * q_step;

% Plotting
figure;

% Plot input signal
subplot(3,1,1);
plot(t, input_signal);
title('Input Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot PCM modulated signal
subplot(3,1,2);
stairs(t, quantized_signal);
title('PCM Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot demodulated signal
subplot(3,1,3);
plot(t, decoded_signal);
title('Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
