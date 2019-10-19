t = 0:1 / 8000:2;
x = chirp(t, 500, 1, 750, 'linear');

% Q1: Since chirp method is linear, 1kHz

% soundsc(x, 8000);

% Q2: The pitch becomes higher

X = fft(x);
F = linspace(0, 8000, length(x));
subplot(2,2,1);
plot(F,abs(X)./length(x)*2);

% Q3:
% a: The spectrum is symmetric at the point fs/2 = 8kHz/2 = 4kHz. 
% b: It is evident between 500Hz - 1kHz (frequency after 2 seconds) and
% it's mirrored frequencies, 7000kHZ (8kHz - 1kHz) - 7500kHz (8kHz - 500Hz)
% c: 

L = 160; %segment size in samples
step=L/2; %hop size of segments in samples, 50% overlap
NFFT=256; %number of FFT points computed per segment
Fs=8000; %sampling rate
N=length(x); K=fix((N-L+step)/step);
w=hanning(L); time=(1:L)';
N2=NFFT/2+1; S=zeros(K,N2);
for k=1:K
 xw=x(time)'.*w; %multiply each segment by Hanning window to reduce spectral leakage
 X=fft(xw,NFFT);
 X1=X(1:N2)';
 S(k,1:N2)=X1.*conj(X1);
 time=time+step;
end
S=fliplr(S)'; S=S/max(max(S));
%colormap(1-gray); %use this for grayscale
colormap(jet);
tk=(0:K-1)'*step/Fs; F=(0:NFFT/2)'*Fs/NFFT;
subplot(2,2,2);
imagesc(tk,flipud(F),20*log10(S),[-100 0]); axis xy
xlabel('time (sec)')
ylabel('frequency (Hz)')
title('160 samples')

% Q4:
% a: If the sampling rate is 8000 Hz or T = 1/8000 = 0.125 ms and we are
% taking 160 samples/segment then the number of ms per segment is
% 0.125 * 160 = 20ms.
% b: The chirp we created increases its frequency linearly. This is
% evident in the spectrogram, where the signal's energy is at 500Hz at t=0
% and increases linearly up to 1kHz after two seconds.
% c: 

% TODO: MAKE INTO A FUNCTION INSTEAD WITH L AS PARAM
L = 80; %segment size in samples
step=L/2; %hop size of segments in samples, 50% overlap
NFFT=256; %number of FFT points computed per segment
Fs=8000; %sampling rate
N=length(x); K=fix((N-L+step)/step);
w=hanning(L); time=(1:L)';
N2=NFFT/2+1; S=zeros(K,N2);
for k=1:K
 xw=x(time)'.*w; %multiply each segment by Hanning window to reduce spectral leakage
 X=fft(xw,NFFT);
 X1=X(1:N2)';
 S(k,1:N2)=X1.*conj(X1);
 time=time+step;
end
S=fliplr(S)'; S=S/max(max(S));
%colormap(1-gray); %use this for grayscale
colormap(jet);
tk=(0:K-1)'*step/Fs; F=(0:NFFT/2)'*Fs/NFFT;
subplot(2,2,3);
imagesc(tk,flipud(F),20*log10(S),[-100 0]); axis xy
title('80 samples')
xlabel('time (sec)')
ylabel('frequency (Hz)')

% TODO: MAKE INTO A FUNCTION INSTEAD WITH L AS PARAM
L = 320; %segment size in samples
step=L/2; %hop size of segments in samples, 50% overlap
NFFT=256; %number of FFT points computed per segment
Fs=8000; %sampling rate
N=length(x); K=fix((N-L+step)/step);
w=hanning(L); time=(1:L)';
N2=NFFT/2+1; S=zeros(K,N2);
for k=1:K
 xw=x(time)'.*w; %multiply each segment by Hanning window to reduce spectral leakage
 X=fft(xw,NFFT);
 X1=X(1:N2)';
 S(k,1:N2)=X1.*conj(X1);
 time=time+step;
end
S=fliplr(S)'; S=S/max(max(S));
%colormap(1-gray); %use this for grayscale
colormap(jet);
tk=(0:K-1)'*step/Fs; F=(0:NFFT/2)'*Fs/NFFT;
subplot(2,2,4);
imagesc(tk,flipud(F),20*log10(S),[-100 0]); axis xy
xlabel('time (sec)')
ylabel('frequency (Hz)')
title('320 samples')