% This is an example program to test demodulate FM signal (Baseband)
% Objective:
% ----------
%   1. Capture a file from RTLSDR and save to a file
%   3. Read the whole file as complex value in MATLAB
%   4. Decode FM data
%   5. Save the data to WAVE file

clear all
clc
close all

% Capture the 8-bit IQ file from RTLSDR
deviceIndex=1;
fS = 250e3;
tM = 15;
rtlsample(deviceIndex, fS, 104.8e6, 32.0, tM+1, 'rf');

% Process
fin = fopen('rf', 'rb');
data = transpose(fread(fin, [2 round(fS*tM)], 'uint8'));
data = data.* (2.0/255.0) - 1.0;
fclose(fin);

dataC = data(:,1) + j.* data(:,2);

% Normalize the signal
dataC_amplitude = abs(dataC);
dataN = dataC./dataC_amplitude;

% find the angle
angleN = unwrap(angle(dataN));
d_angleN = diff([0; angleN]);       % FM demodulated data

% scale the amplitude
gain = 1/(2*pi);
u_angleN1 = gain.* d_angleN;


% low pass upto 8 KHz to keep data
aud = lowpass(u_angleN1, 8000, fS);

% downsample from 250 KSPS to 25 KSPS
aud1 = decimate(aud, 10);

% save the audio to wave file
audiowrite('fmdemodulated.wav', aud1, fS/10);
