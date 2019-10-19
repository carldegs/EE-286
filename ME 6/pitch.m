[x_stereo, fs_audio] = audioread('ragtime.wav');

% change to mono
x_mono = (x_stereo(:,1) + x_stereo(:,2)) / 2;

% normalize
mean_x_mono = mean(x_mono);
x_norm = (x_mono - mean_x_mono) ./ max(abs(x_mono - mean_x_mono));

% split into 30ms frames
fs = fs_audio;
frame_time = 0.03;
frame_len = fs * frame_time;

hop_size = 0.02;
hop_len = fs * hop_size;

num_frames = fix((length(x) - frame_len + hop_len) / hop_len);
% number of frames = 208

for n = 1:2
    frame_start = ((n - 1) * hop_len) + 1;
    frame_end = frame_start + frame_len - 1;
    
    if frame_end > length(x)
        frame_end = length(x);
    end
    
    % curr frame
    x_curr = x_norm(frame_start:frame_end);
    X = xcorr(x_curr);
    
    %fprintf('%d - %d %d\n', n, frame_start, frame_end);
end



%%
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