[x_stereo, fs_audio] = audioread('ragtime.wav');

%% change to mono
x_mono = (x_stereo(:,1) + x_stereo(:,2)) / 2;

%% normalize
mean_x_mono = mean(x_mono);
x_norm = (x_mono - mean_x_mono) ./ max(abs(x_mono - mean_x_mono));

%% split into 30ms frames
fs = fs_audio;
frame_time = 0.03;
frame_len = fs * frame_time;
hop_size = 0.02;
hop_len = fs * hop_size;
num_frames = length(x_norm)/(frame_len-hop_len);

%% Compute Pitch using xcorr
[t1, p1] = pitch(x_norm, fs_audio, hop_len, frame_len);
figure(1);plot(t1,p1, 'r', 'DisplayName', 'No clipping');
xlabel('seconds');
ylabel('Pitch(Hz)');
title('Pitch Tracking using Autocorrelation');

%% Compare pitch generated with xcorr with clipping
pfmt=["b.-" "g--"];
clippingLevel = [0.1 0.2];
figure(2);
plot(t1,p1, 'r', 'DisplayName', 'No clipping');
xlabel('seconds');
ylabel('Pitch(Hz)');
hold on;
for i=1:2
    xc = clip(x_norm, clippingLevel(i));
    [t2, p2] = pitch(xc, fs_audio, hop_len, frame_len);
    plot(t2,p2,pfmt(i),'DisplayName', sprintf("clipping level=%.1f",clippingLevel(i)));
end
legend;
title("Autocorrelation with center clipping");
hold off;

%% Vary frame length
figure(3);hold on;
[t2, p2] = pitch(x_norm, fs_audio, 0.02*fs_audio, 0.03*fs_audio);
plot(t2,p2,'r-','DisplayName', sprintf("Frame length=30ms, Hop size=20ms",clippingLevel(i)));
[t3, p3] = pitch(x_norm, fs_audio, 0.04*fs_audio, 0.06*fs_audio);
plot(t3,p3,'g--','DisplayName', sprintf("Frame length=60ms, Hop size=40ms",clippingLevel(i)));
legend;
xlabel('seconds');
ylabel('Pitch(Hz)');
title("Effect of frame size");
hold off;
%% Pitch estimator
function [t, pitchContour] = pitch(x, fs, hop_len, frame_len)
    num_frames = ceil(numel(x)/(frame_len-hop_len));
    pitchContour=zeros(1,num_frames);
    for n = 1:num_frames
        frame_start = 1+(n-1)*(frame_len-hop_len);
        frame_end = frame_start + frame_len;

        if frame_end > length(x)
            frame_end = length(x);
        end

        % curr frame
        x_curr = x(frame_start:frame_end);
        [X, lags] = xcorr(x_curr);
        % remove negative lags
        X(lags<0) = [];
        % F0=pick the highest peak
        [peaks,locs] = findpeaks(X, 'SortStr', 'desc');
        if numel(locs) > 0
            f0 = fs/locs(1);
        else
            f0 = 0;
        end
        fprintf('%d - %d %d: F0 = %.1f\n', n, frame_start, frame_end, f0);
        pitchContour(n) = f0;
        if (mod(n, 20) == 0) 
            %figure; plot(1:numel(X), X, '-', locs, peaks, 'o');
        end
    end
    t = linspace(0, numel(x)/fs, numel(pitchContour));

end