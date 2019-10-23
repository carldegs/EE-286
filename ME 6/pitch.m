% Pitch estimator
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