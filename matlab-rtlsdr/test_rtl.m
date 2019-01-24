% This is an example program to test RTL Capture and Postprocessing in
% MATLAB
% Objective:
% ----------
%   1. Capture a file from RTLSDR and save to a file
%   3. Read the whole file as complex value in MATLAB
%   4. Plot the Spectrum

clear all
clc
close all

% Capture the 8-bit IQ file from RTLSDR
deviceIndex=1;
rtlsample(deviceIndex, 2.0e6, 104.8e6, 32.0, 2.0, 'rf');

% Process
fin = fopen('rf', 'rb');
data = transpose(fread(fin, [2 2000001], 'uint8'));
data = data.* (2.0/255.0) - 1.0;
fclose(fin);

dataC = data(:,1) + j.* data(:,2);

dataF = abs(fft(dataC)).^2;
dataPower= fftshift(10.0.*log10(dataF));

FIndex = (-2000000/2:2000000/2).*1.0e-6;

plot(FIndex, dataPower), ...
    xlabel('Frequency (MHz)'), ...
    ylabel('Power (dB)'), ...
    title('RTLSDR Captured Frequency Spectrum'), ...
    grid on