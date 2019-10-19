function freqLoop(f, length) % f - frequency of the tone
    fs = 44100;     % sampling frequency
    T = 0:1/fs:length;
    amp = 1;        % amplitude
    levelCount = 0;
    
    while levelCount < 20
        fprintf('Tone #%d: %ddB reduction\n',levelCount + 1, levelCount * 3);
        x = amp * sin(2*pi*f*T);
        sound(x, fs);
        amp = amp / 2;
        levelCount = levelCount + 1;
        pause(length + 0.25);
    end
end

