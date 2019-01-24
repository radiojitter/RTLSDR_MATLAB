function status=convert_rtlfile(srcfile, dstfile)
% status=convert_rtlfile(srcfile, dstfile)
% This function convert an RTL-SDR captured file to a CSV IQ
% file. CSV I,Q file is in double 2 column format.
% 
% INPUT
% -----
%   srcfile = Name of the Source RTLSDR captured file (8-bit IQ Binary File)
%   dstfile = Name of the Destination CSV file (2-column Double I,Q)
%   
% OUTPUT
% ------
%   status = Returns the number of samples converted. If it is 0, then no
%   conversion is done or Conversion failed.
%

% open source 8-bit IQ file
fin = fopen(srcfile, 'rb');

% get size of file
fseek(fin, 0, 'eof');
nsamples = ftell(fin);
fseek(fin, 0, 'bof');

% read all samples to memory
samples = double(fread(fin,[nsamples 1], 'uint8'));
samples = samples.* (2.0/255.0);
samples = samples - 1.0;

% close the source file
fclose(fin);

% if no sample then abort
if nsamples<1
    status=0;
    return;
end

% create output file and write to it
fout = fopen(dstfile, 'w');
fprintf(fout,'I,Q\n');

nsamples1 = floor(nsamples/2.0);
for index=1:nsamples1
    index1= index-1;
    index_re = index1*2+0+1;
    index_im = index1*2+1+1;
    
    fprintf(fout,'%g,%g\n', ...
        samples(index_re), samples(index_im));
end
fclose(fout);

status = nsamples;
end
