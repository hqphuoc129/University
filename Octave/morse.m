function code=morse(varargin)
% MORSE converts text to playable morse code in wav format
%
% SYNTAX
% morse(text)
% morse(text,file_name);
% morse(text,file_name,noise_multiplier);
% morse(text, file_name,noise_multiplier,code_frequency);
% morse(text, file_name,noise_multiplier,code_frequency,sample_rate);
% morse(text, file_name,noise_multiplier,code_frequency,sample_rate, code_speed_wpm, zero_fill_to_N);
% morse(text, file_name,noise_multiplier,code_frequency,sample_rate, code_speed_wpm, zero_fill_to_N, play_sound);
%
% Description:
%
%   If the wave file name is specified, then the funtion will output a wav
%   file with that file name.  If only text is specified, then the function
%   will only play the morse code wav file without saving it to a wav file.
%   If a noise multiplier is specified, zero mean addative white Gaussian
%   noise is added with 'amplitude' noise_multiplier.
%
% Examples:
%
%   morse('Hello');
%   morse('How are you doing my friend?','morsecode.wav');
%   morse('How are you doing my friend?','morsecode.wav', 0.01);
%   morse('How are you doing my friend?','morsecode.wav', 0.01, 440, ,20, Fs);
%   x = morse('How are you doing my friend?','morsecode.wav', 0.01, 440, 20, Fs, 2^20,1); %(to play the file, and make the length 2^20)
%
%   Copyright 2005 Fahad Al Mahmood
%   Version: 1.1 $  $Date: 08-Jul-2010
%   Modifications: Rob Frohne, KL7NA
%Defualt values
Fs=48000;
noise_multiplier = 0;
f_code = 375;
code_speed = 20;
text = varargin{1}
if nargin>=2
file = varargin{2}
end
if nargin>=3
noise_multiplier = varargin{3};
end
if nargin>=4
f_code = varargin{4};
end
if nargin>=5
Fs = varargin{5};
end
if nargin>=6
code_speed = varargin{6};
end
if nargin>=7
length_N = varargin{7};
end
if nargin>=8
playsound = varargin{8};
end
t=0:1/Fs:1.2/code_speed; %One dit of time at w wpm is 1.2/w.
t=t';
Dit = sin(2*pi*f_code*t);
ssp = zeros(size(Dit));
#Dah fixed by Zach Swena 
t2=0:1/Fs:3*1.2/code_speed;  # one Dah of time is 3 times  dit time
t2=t2';
Dah = sin(2*pi*f_code*t2);
lsp = zeros(size(Dah));    # changed size argument to function of Dah 
#Dah = [Dit;Dit;Dit];
#lsp = zeros(size([Dit;Dit;Dit]));
% Defining Characters & Numbers
A = [Dit;ssp;Dah];
B = [Dah;ssp;Dit;ssp;Dit;ssp;Dit];
C = [Dah;ssp;Dit;ssp;Dah;ssp;Dit];
D = [Dah;ssp;Dit;ssp;Dit];
E = [Dit];
F = [Dit;ssp;Dit;ssp;Dah;ssp;Dit];
G = [Dah;ssp;Dah;ssp;Dit];
H = [Dit;ssp;Dit;ssp;Dit;ssp;Dit];
I = [Dit;ssp;Dit];
J = [Dit;ssp;Dah;ssp;Dah;ssp;Dah];
K = [Dah;ssp;Dit;ssp;Dah];
L = [Dit;ssp;Dah;ssp;Dit;ssp;Dit];
M = [Dah;ssp;Dah];
N = [Dah;ssp;Dit];
O = [Dah;ssp;Dah;ssp;Dah];
P = [Dit;ssp;Dah;ssp;Dah;ssp;Dit];
Q = [Dah;ssp;Dah;ssp;Dit;ssp;Dah];
R = [Dit;ssp;Dah;ssp;Dit];
S = [Dit;ssp;Dit;ssp;Dit];
T = [Dah];
U = [Dit;ssp;Dit;ssp;Dah];
V = [Dit;ssp;Dit;ssp;Dit;ssp;Dah];
W = [Dit;ssp;Dah;ssp;Dah];
X = [Dah;ssp;Dit;ssp;Dit;ssp;Dah];
Y = [Dah;ssp;Dit;ssp;Dah;ssp;Dah];
Z = [Dah;ssp;Dah;ssp;Dit;ssp;Dit];
period = [Dit;ssp;Dah;ssp;Dit;ssp;Dah;ssp;Dit;ssp;Dah];
comma = [Dah;ssp;Dah;ssp;Dit;ssp;Dit;ssp;Dah;ssp;Dah];
question = [Dit;ssp;Dit;ssp;Dah;ssp;Dah;ssp;Dit;ssp;Dit];
slash_ = [Dah;ssp;Dit;ssp;Dit;ssp;Dah;ssp;Dit];
n1 = [Dit;ssp;Dah;ssp;Dah;ssp;Dah;ssp;Dah];
n2 = [Dit;ssp;Dit;ssp;Dah;ssp;Dah;ssp;Dah];
n3 = [Dit;ssp;Dit;ssp;Dit;ssp;Dah;ssp;Dah];
n4 = [Dit;ssp;Dit;ssp;Dit;ssp;Dit;ssp;Dah];
n5 = [Dit;ssp;Dit;ssp;Dit;ssp;Dit;ssp;Dit];
n6 = [Dah;ssp;Dit;ssp;Dit;ssp;Dit;ssp;Dit];
n7 = [Dah;ssp;Dah;ssp;Dit;ssp;Dit;ssp;Dit];
n8 = [Dah;ssp;Dah;ssp;Dah;ssp;Dit;ssp;Dit];
n9 = [Dah;ssp;Dah;ssp;Dah;ssp;Dah;ssp;Dit];
n0 = [Dah;ssp;Dah;ssp;Dah;ssp;Dah;ssp;Dah];
text = upper(text);
vars ={'period','comma','question','slash_'};
morsecode=[];
for i=1:length(text)
if isvarname(text(i))
morsecode = [morsecode;eval(text(i))];
elseif ismember(text(i),'.,?/')
x = findstr(text(i),'.,?/');
morsecode = [morsecode;eval(vars{x})];
elseif ~isempty(str2num(text(i)))
morsecode = [morsecode;eval(['n' text(i)])];
elseif text(i)==' '
morsecode = [morsecode;ssp;ssp;ssp;ssp];
end
morsecode = [morsecode;lsp];
end
if exist('length_N','var')
append_length = length_N - length(morsecode);
if (append_length < 0)
printf("Length %d isn't large enough for your message; it must be > %d.\n",length_N,length(morsecode));
return;
else
morsecode = [morsecode; zeros(append_length,1)];
end
end
noisey_morsecode = morsecode + noise_multiplier*randn(size(morsecode));
SNR=20*log10(norm(morsecode)/norm(morsecode-noisey_morsecode));
printf('SNR =%f\n',SNR);
if exist('file','var')
wavwrite(noisey_morsecode,Fs,16,file);
if exist('playsound')
system(['aplay ',file]);
end
else
soundsc(noisey_morsecode,Fs);
% wavplay(morsecode);
end
code = noisey_morsecode;
endfunction