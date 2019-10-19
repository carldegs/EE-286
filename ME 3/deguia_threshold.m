%% START PLAYING TONES AT DIFFERENT FREQUENCIES
pause(); % press any key to start
for freq = [40,60,100,200,400,500,600,1000,2000,3500,4000,5000,6000,8000,9000,10000,11000,12000,15000]
    fprintf('\nf = %dHz\n',freq);
    freqLoop(freq, 0.1);
    pause();
end


%% PLOT SOUND INTENSITY REDUCTION
freqs = [40,60,100,200,400,500,600,1000,2000,3500,4000,5000,6000,8000,9000,10000,11000,12000,15000];
results = [15,21,30,30,33,33,33,39,39,36,36,36,36,36,33,33,27,27,18];
results = -results;

figure(1)
ylim([-40 10]);
loglog(freqs, results, 'Marker', 'o');
grid on;
xlabel('Frequencies (Hz)');
ylabel('Sound Intensity Reduction (dB)');
title('Sound Intensity Reduction by frequency');

x = linspace(min(freqs),max(freqs),100);
y = interp1(freqs,results,x,'spline','extrap');
figure(2);
ylim([-40 10]);
loglog(freqs,results,'Marker', 'o', 'LineStyle','none');
hold on;
loglog(x,y,'-r');
grid on;
hold off;
xlabel('Frequencies (Hz)');
ylabel('Sound Intensity Reduction (dB)');

title('Sound Intensity Reduction by frequency (Interpolated)');

%% START PLAYING TONES AT DIFFERENT FREQUENCIES FOR 0.5s
pause(); % press any key to start
for freq = [40,60,100,200,400,500,600,1000,2000,3500,4000,5000,6000,8000,9000,10000,11000,12000,15000]
    fprintf('\nf = %dHz\n',freq);
    freqLoop(freq, 0.5);
    pause();
end

%% PLOT SOUND INTENSITY REDUCTION
freqs = [40,60,100,200,400,500,600,1000,2000,3500,4000,5000,6000,8000,9000,10000,11000,12000,15000];
results = [18,21,24,27,30,33,33,33,36,30,33,33,33,36,33,33,27,27,18];
results = -results;

figure(3)
ylim([-40 10]);
loglog(freqs, results, 'Marker', 'o');
grid on;
xlabel('Frequencies (Hz)');
ylabel('Sound Intensity Reduction (dB)');
title('Sound Intensity Reduction by frequency (0.5s)');

x = linspace(min(freqs),max(freqs),100);
y = interp1(freqs,results,x,'spline','extrap');
figure(4);
ylim([-40 10]);
loglog(freqs,results,'Marker', 'o', 'LineStyle','none');
hold on;
loglog(x,y,'Color', 'red');
grid on;
hold off;
xlabel('Frequencies (Hz)');
ylabel('Sound Intensity Reduction (dB)');

title('Sound Intensity Reduction by frequency (Interpolated, 0.5s)');

%% TONE TIME DIFFERENCE
freqs = [40,60,100,200,400,500,600,1000,2000,3500,4000,5000,6000,8000,9000,10000,11000,12000,15000];
results1 = -1 * [15,21,30,30,33,33,33,39,39,36,36,36,36,36,33,33,27,27,18];
results5 = -1 * [18,21,24,27,30,33,33,33,36,30,33,33,33,36,33,33,27,27,18];

figure(5)
ylim([-40 10]);
loglog(freqs, results1, 'Marker', 'o', 'Color', 'blue');
hold on;
loglog(freqs, results5, 'Marker', 'x', 'Color', 'red');
grid on;
legend('0.1sec', '0.5sec');
xlabel('Frequencies (Hz)');
ylabel('Sound Intensity Reduction (dB)');
title('Sound Intensity Reduction by frequency comparison');

