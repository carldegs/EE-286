
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

