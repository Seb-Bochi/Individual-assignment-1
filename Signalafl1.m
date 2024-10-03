%%
clear 
clc
a=1;
phik = 0;
f0 = 1000;
fs = 10000;
T_tot = 0.5;
t = 0:1/fs:T_tot;   % time vector

s = a * sin(2 * pi * f0 * t + phik);

path_2_wav = 'C:\Users\sebbo\OneDrive\Desktop\DTU\Signaler 2\hands_on_01_sounds\'; 
[Recording, fs_recording] = audioread([path_2_wav, 'voice2.wav']);
t_recording = (0:length(Recording)-1) / fs_recording;
 

%frequency 1000Hz genereted
[y, freq] = make_spectrum(s, fs, T_tot); 

%frequency voice
[y1, freq1] = make_spectrum(Recording, fs_recording, length(Recording)/fs_recording);  

% First window for time-domain plots


figure(1);  % Create the first figure window
hold on;
plot(t, s);
plot(t_recording, Recording);
xlabel('Time (seconds)');
ylabel('Amplitude (Au)');
grid on;
xlim([0.01 0.02]);
title('My Singing and 1000Hz Sinusoid');
hold off;

% Second window for frequency-domain plots
figure(2);  % Create the second figure window
hold on;
stem(freq, abs(y), 'filled');
stem(freq1, abs(y1), 'filled');
xlabel('Frequency (Hz)');
ylabel('Magnitude (Au)');
xlim([0 3000]);
grid on;
title('My Singing and 1000 Hz sinusoid in Frequency Spectrum');
hold off;

function [Y, freq] = make_spectrum(signal, fs,T_tot) 
   
    Y = fft(signal); % Compute the FFT of the signal
    Y = Y / length(signal); % Scale FFT by the number of samples
    delta_f = 1/T_tot;  %Set the frequency resolution to 2 Hz   
    % Calculate the number of FFT points based on T_tot and delta_f
    N = fs / delta_f;
    % Frequency vector (only positive frequencies)
    freq = (0:N/2-1)*delta_f;  % Only return positive frequencies
    % Only keep the first half of the FFT (positive frequencies)
    Y = Y(1:length(freq));
    % Convert to column vectors
    Y = Y(:);
    freq = freq(:);
end

