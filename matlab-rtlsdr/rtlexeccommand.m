function status=rtlexeccommand(cmd)
% status = rtlexeccommand(cmd)
% Executes an RTL-SDR command and returns the Status. This function will
% setup the path and execute the specified command.
%
% INPUT
% -----
%       cmd = Command Line to pass to this function for execution
%
% RETURNS
% -------
%       status = Returns the status code returned by the application
%


% on windows add ./win32 path
if ispc
    old_path = path;
    old_syspath = getenv('PATH');
    
    path1 = pwd;                        % this directory
    path2 = sprintf('%s\\win32', pwd);  % directory where the utilites are
    
    % first add to MATLAB path
    if isempty(strfind(old_path, path1))
        new_path = sprintf('%s;%s', path1, old_path);
        addpath(new_path);
        old_path = path;        % get the updated path
    end
    
    if isempty(strfind(old_path, path2))
        new_path = sprintf('%s;%s', path2, old_path);
        addpath(new_path);
       % old_path = path;
    end
    
    % second add to SYSTEM PATH
    if isempty(strfind(old_syspath, path1))
        new_syspath = sprintf('%s;%s', path1, old_syspath);
        setenv('PATH', new_syspath);
        old_syspath = getenv('PATH');
    end
    
    if isempty(strfind(old_syspath, path2))
        new_syspath = sprintf('%s;%s', path2, old_syspath);
        setenv('PATH', new_syspath);
       % old_syspath = getenv('PATH');
    end
end


% execute the command
status = system(cmd);
end