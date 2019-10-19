fs = 44100;
t = (0:1 / fs:2);
x = randn(1, length(t))';
x = x ./ max(x);
soundsc(x, fs);

h = wavread('Small Drum Room.wav');
%h = wavread('St Nicolaes Church.wav');

pause;

y = conv(x, h);

L = 882;    % segment size in samples
step = L;   % hop size of segments
N = length(y);
K = fix((N - L + step)/step);
time=(1:L);
P = zeros(1,K);
for k = 1:K
 y_rms = rms(y(time)); %get rms value of the windowed signal
 P(k) = 20 * log10(y_rms); %get the power level
 time = time + step;
end

t=linspace(0,L/fs*K,K); %assign x-axis values
plot(t,P);
xlabel('Time (sec)');
ylabel('Power (dB)');

hold on %superimpose figures in the same window

%%%%%%%%%%%%%%%%%%
h = wavread('St Nicolaes Church.wav');

pause;

y = conv(x, h);

L = 882;    % segment size in samples
step = L;   % hop size of segments
N = length(y);
K = fix((N - L + step)/step);
time=(1:L);
P = zeros(1,K);
for k = 1:K
 y_rms = rms(y(time)); %get rms value of the windowed signal
 P(k) = 20 * log10(y_rms); %get the power level
 time = time + step;
end

t=linspace(0,L/fs*K,K); %assign x-axis values
plot(t,P);
xlabel('Time (sec)');
ylabel('Power (dB)');
legend('Small Drum Room', 'St. Nicolaes Church');
hold off;

%%%%%%%%%%%%%%%%%%
fs = 44100;
F = [250, 500, 1000, 2000, 4000, 8000];
tx = (0:1 / fs:2);

for s = 1 : length(F)
    x = cos(2*pi*F(s)*tx);
    h = wavread('Small Drum Room.wav');
    
    y = conv(x, h);
    L = 882;    % segment size in samples
    step = L;   % hop size of segments
    N = length(y);
    K = fix((N - L + step)/step);
    time=(1:L);
    P = zeros(1,K);
    for k = 1:K
        y_rms = rms(y(time)); %get rms value of the windowed signal
        P(k) = 20 * log10(y_rms); %get the power level
        time = time + step;
    end
    t=linspace(0,L/fs*K,K); %assign x-axis values
    figure();
    plot(t,P);
    xlabel('Time (sec)');
    ylabel('Power (dB)');
    title(F(s));
    %hold on %superimpose figures in the same window
end
hold off;
title('Small Drum Room at different sinusoidal frequencies');
legend('250Hz', '500Hz', '1kHz', '2kHz', '4kHz', '8kHz');


%%%%%%%%%%%%%%%%%%
fs = 44100;
wavDrum = wavread('Small Drum Room.wav');
wavChurch = wavread('St Nicolaes Church.wav');

%%%% SPEECH
x = wavread('tagalog speech.wav');
soundsc(x, fs);
pause(10);
y = conv(x, wavDrum);
soundsc(y, fs);
pause(10);
y = conv(x, wavChurch);
soundsc(y,fs);
pause(10);
% Small drum room is better for speech since the words are not very
% inteliigible

%%%% SINGING VOICE
x = wavread('Perfect.wav');
soundsc(x, fs);
pause(15);
y = conv(x, wavDrum);
soundsc(y, fs);
pause(15);
y = conv(x, wavChurch);
soundsc(y,fs);
pause(15);

% Since the church has a longer reverberation time, using this for the
% singing voice makes it sound like a choir is singing, making it more
% "rich", but with those echoes the words are less intelligible.

%%%% INSTRUMENTAL
x = wavread('cello.wav');
soundsc(x, fs);
pause(10);
y = conv(x, wavDrum);
soundsc(y, fs);
pause(10);
y = conv(x, wavChurch);
soundsc(y,fs);
pause(10);

% Using the church makes the instrumental music more rich and full,
% sounding like multiple cellos, and with no words to worry therefore no
% intelligibility issues, it is the right environment to choose.

