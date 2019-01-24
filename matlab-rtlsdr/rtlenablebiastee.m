function status = rtlenablebiastee(devIndex, bEnable)
% status = rtlenablebiastee(devIndex, bEnable)
% This function Enables or Disable Bias Tee of RTL-SDR, which supports
% Bias-Tee facility.
%
% INPUT
% -----
%   devIndex = Specify RTL-SDR Device Index (0 to Auto-Detect)
%   bEnable = If this value is 1, then RTL-SDR Bias Tee will be enabled and
%   RTLSDR Antenna Port will output a voltage. However, if this value is 0,
%   then the Bias Tee is switched off.
%
% OUTPUT
% ------
%   status = The return value is the status of the command after execution.
%   A 0 value means that the function is successfully executed and
%   completed.
%



cmd = sprintf('rtl_biast -d %d -b %d', devIndex, bEnable);
status = rtlexeccommand(cmd);

end