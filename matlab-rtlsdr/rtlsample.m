function status = rtlsample(devIndex, sampleRateHz, freqHz, gaindB, timeSec, filename)
% status = rtlsample(devIndex, sampleRateHz, freqHz, gaindB, timeSec, filename)
% Samples a 8-Bit (UINT8) IQ file containing the RAW IQ data corresponding
% to the Tuned RF Frequency and saves the captured data to a file whose
% name is specified as the argument.
%
% INPUT
% -----
%   devIndex = 0-based Index of the RTL-SDR connected to the Computer
%   (Specify 0 to AutoDetect and use the first RTLSDR detected)
%   sampleRateHz = Specify a Valid Sample Rate that the RTLSDR device can
%   use. This must be in Samples/Seconds (Eg. 2.0e6 for 2 MSPS)
%   freqHz = Specify the Frequency (in Hz) to tune the RTLSDR to (Eg.
%   104e6 for tuning to 104 MHz)
%   gaindB = Specify a Valid Gain value to specify the Gain of the Frontend
%   RF stage (Eg. 32.0 for 32.0 dB RF Gain)
%   timeSec = Specify the capture time in seconds
%   filename = Specify the name of the file (as string) where the RF IQ
%   data received are saved
%
% OUTPUT
% ------
%   status = Returns 0 if the capture can be successfully done
%

% now execute the command
numSamples = round(sampleRateHz*timeSec);

argline=sprintf('rtl_sdr -d %d -s %d -f %d -g %0.1f -n %d \"%s\"', ...
    devIndex, sampleRateHz, freqHz, gaindB, ...
    numSamples, ...
    filename);

status = rtlexeccommand(argline);

end
