delays = [5, 50, 100, 200];
name = 'echo';

[x, fs_audio] = audioread('audio.m4a');

% Change sampling rate to 8kHz
fs = 8000;
x = resample(x, 1, fs_audio/fs);

% Use only one channel
x = x(:,1);

for d = 1 : length(delays)
    t_delay = delays(d) / 1000;
    gain = 0.8;

    x_echo = x;
    for n = 1:length(x)
        n_delay = (n - (t_delay * fs)) + 1;

        if n_delay >= 1
            x_echo(n) = x(n) + (gain * x(n_delay));
        end
    end

    audiowrite(['echo-', num2str(delays(d)), '.wav'], x_echo, fs);
end

for d = 1 : length(delays)
    t_delay = delays(d) / 1000;
    gain = 0.8;

    x_reverb = x;
    for n = 1:length(x)
        n_delay = (n - (t_delay * fs)) + 1;

        if n_delay >= 1
            x_reverb(n) = x(n) + (gain * x_reverb(n_delay));
        end
    end
    
    audiowrite(['reverb-', num2str(delays(d)), '.wav'], x_reverb, fs);
end