[x, fs_audio] = audioread('audio.m4a');

% Change sampling rate to 8kHz
fs = 8000;
x = resample(x, 1, fs_audio/fs);

% Use only one channel
x = x(:,1);

% segment into 30ms frames
frame_time = 0.03;
frame_len = fs * frame_time;
num_frames = ceil(length(x) / frame_len);
p = 4;   % filter order
lpc_coeff = zeros(p, num_frames);
error = zeros(length(x), 1);

for n = 1:num_frames
    frame_start = ((n - 1) * frame_len) + 1;
    frame_end = n * frame_len;
    
    if frame_end > length(x)
        frame_end = length(x);
    end
 
    % get current frame b(n)
    b = x(frame_start:frame_end);
    
    % get autocorrelation of signal b(n), r(n)
    r = xcorr(b);
    % get only values of r from 0 < n < p
    r_zero_point = ceil(length(r)/2);
    r = r(r_zero_point:(r_zero_point + p));
    
    % solve for the LPC coefficients
    R = toeplitz(r(1:p));
    B_R = -r(2:p+1);
    a = R\B_R;
    
    % get residual error
    error_frame = filter(a,1,b);
    
    lpc_coeff(:,n) = a;
    error(frame_start:frame_end) = error_frame;
end

audiowrite('resampled-audio.wav', x, fs);
audiowrite('residual-error.wav', error, fs);

t = 0 : 1/fs : length(x)/fs;
t = t(1:length(x));

figure();
hold on;
plot(t,x);
plot(t,error);
title(['Signal and Residual Error with filter order p = ', num2str(p), 'frame size = ', num2str(frame_time*100), 'ms']);
legend('Original Audio Signal', 'Residual Error');
hold off;

% synthesize
synth_sig = zeros(length(x), 1);

for n = 1:num_frames
    frame_start = ((n - 1) * frame_len) + 1;
    frame_end = n * frame_len;
    
    if frame_end > length(x)
        frame_end = length(x);
    end
    
    a = lpc_coeff(:,n);
    e = error(frame_start:frame_end);
    
    if sum(isnan(a)) == 0
        b = filter(1, a, e);
    else
        b = zeros(frame_len, 1);
    end
    
    b(b > 1) = 1;
    b(b < -1) = -1;
    
    synth_sig(frame_start:frame_end) = b;
end

figure();
hold on;
plot(t,x);
plot(t,synth_sig);
title(['Original and Synthesized Signal with filter order p = ', num2str(p), ' frame size = ', num2str(frame_time * 1000), 'ms']);
legend('Original', 'Synthesized');
hold off;

% audiowrite('synth-audio.wav', synth_sig, fs);
soundsc(synth_sig, fs);

% quantize signal
