function status = rtlsamplecsv(devIndex, sampleRateHz, freqHz, gaindB, timeSec, filename)
% status = rtlsamplecsv(devIndex, sampleRateHz, freqHz, gaindB, timeSec, filename)
% Samples a 8-Bit (UINT8) IQ file containing the RAW IQ data corresponding
% to the Tuned RF Frequency and saves the captured data to a CSV file whose
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
%   filename = Specify the name of the CSV file (as string) where the RF IQ
%   data received are saved (in 2 column I,Q file)
%
% OUTPUT
% ------
%   status = Returns 0 if the capture failed
%

% Capture the RAW IQ data
filename_temp = sprintf('%s.temp.raw', filename);
rtlsample(devIndex, sampleRateHz, freqHz, gaindB, timeSec, filename_temp);

% Convert the file
status = convert_rtlfile(filename_temp, filename);

% Delete the RAW file
delete(filename_temp);
