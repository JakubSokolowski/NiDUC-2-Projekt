function Hash = DataHash(Data, Opt)
% DATAHASH - Checksum for Matlab array of any type
% 
% Hash = DataHash(Data, Opt)
%
% INPUT:
%   Data: Array of these built-in types:
%   Opt:  Struct to specify the hashing algorithm and the output format.
%         
% OUTPUT:
%   Hash: String, DOUBLE or UINT8 vector. The length depends on the hashing
%         method.
%

% Main function: ===============================================================
% Default options: -------------------------------------------------------------
Method    = 'MD5';
OutFormat = 'hex';
isFile    = false;
isBin     = false;

% Check number and type of inputs: ---------------------------------------------
nArg = nargin;
if nArg == 2
   if isa(Opt, 'struct') == 0   % Bad type of 2nd input:
      Error_L('BadInput2', '2nd input [Opt] must be a struct.');
   end
   
   % Specify hash algorithm:
   if isfield(Opt, 'Method')  && ~isempty(Opt.Method)   % Short-circuiting
      Method = upper(Opt.Method);
   end
   
   % Specify output format:
   if isfield(Opt, 'Format') && ~isempty(Opt.Format)    % Short-circuiting
      OutFormat = Opt.Format;
   end
   
   % Check if the Input type is specified - default: 'array':
   if isfield(Opt, 'Input') && ~isempty(Opt.Input)      % Short-circuiting
      if strcmpi(Opt.Input, 'File')
         if ischar(Data) == 0
            Error_L('CannotOpen', '1st input FileName must be a string');
         end
         isFile = true;
         
      elseif strncmpi(Opt.Input, 'bin', 3)  % Accept 'binary' also
         if (isnumeric(Data) || ischar(Data) || islogical(Data)) == 0 || ...
               issparse(Data)
            Error_L('BadDataType', ...
               '1st input must be numeric, CHAR or LOGICAL for binary input.');
         end
         isBin = true;
         
      elseif strncmpi(Opt.Input, 'asc', 3)  % 8-bit ASCII characters
         if ~ischar(Data)
            Error_L('BadDataType', ...
               '1st input must be a CHAR for the input type ASCII.');
         end
         isBin = true;
         Data  = uint8(Data);
      end
   end
   
elseif nArg == 0  % Reply version of this function:
   R = Version_L;
   
   if nargout == 0
      disp(R);
   else
      Hash = R;
   end
   
   return;
   
elseif nArg ~= 1  % Bad number of arguments:
   Error_L('BadNInput', '1 or 2 inputs required.');
end

% Create the engine: -----------------------------------------------------------
try
   Engine = java.security.MessageDigest.getInstance(Method);
catch
   Error_L('BadInput2', 'Invalid algorithm: [%s].', Method);
end

% Create the hash value: -------------------------------------------------------
if isFile
   % Open the file:
   FID = fopen(Data, 'r');
   if FID < 0
      % Check existence of file:
      Found = FileExist_L(Data);
      if Found
         Error_L('CantOpenFile', 'Cannot open file: %s.', Data);
      else
         Error_L('FileNotFound', 'File not found: %s.', Data);
      end
   end
   
   % Read file in chunks to save memory and Java heap space:
   Chunk = 1e6;      % Fastest for 1e6 on Win7/64, HDD
   Count = Chunk;    % Dummy value to satisfy WHILE condition
   while Count == Chunk
      [Data, Count] = fread(FID, Chunk, '*uint8');
      if Count ~= 0  % Avoid error for empty file
         Engine.update(Data);
      end
   end
   fclose(FID);
   
   % Calculate the hash:
   Hash = typecast(Engine.digest, 'uint8');
   
elseif isBin             % Contents of an elementary array, type tested already:
   if isempty(Data)      % Nothing to do, Engine.update fails for empty input!
      Hash = typecast(Engine.digest, 'uint8');
   else                  % Matlab's TYPECAST is less elegant:
      if isnumeric(Data)
         if isreal(Data)
            Engine.update(typecast(Data(:), 'uint8'));
         else
            Engine.update(typecast(real(Data(:)), 'uint8'));
            Engine.update(typecast(imag(Data(:)), 'uint8'));
         end
      elseif islogical(Data)               % TYPECAST cannot handle LOGICAL
         Engine.update(typecast(uint8(Data(:)), 'uint8'));
      elseif ischar(Data)                  % TYPECAST cannot handle CHAR
         Engine.update(typecast(uint16(Data(:)), 'uint8'));
         % Bugfix: Line removed
      end
      Hash = typecast(Engine.digest, 'uint8');
   end
else                 % Array with type:
   Engine = CoreHash(Data, Engine);
   Hash   = typecast(Engine.digest, 'uint8');
end

% Convert hash specific output format: -----------------------------------------
switch OutFormat
   case 'hex'
      Hash = sprintf('%.2x', double(Hash));
   case 'HEX'
      Hash = sprintf('%.2X', double(Hash));
   case 'double'
      Hash = double(reshape(Hash, 1, []));
   case 'uint8'
      Hash = reshape(Hash, 1, []);
   case 'base64'
      Hash = fBase64_enc(double(Hash));
   otherwise
      Error_L('BadOutFormat', ...
         '[Opt.Format] must be: HEX, hex, uint8, double, base64.');
end

% ******************************************************************************
function Engine = CoreHash(Data, Engine)

Engine.update([uint8(class(Data)), ...
              typecast(uint64([ndims(Data), size(Data)]), 'uint8')]);
           
if issparse(Data)                    % Sparse arrays to struct:
   [S.Index1, S.Index2, S.Value] = find(Data);
   Engine                        = CoreHash(S, Engine);
elseif isstruct(Data)                % Hash for all array elements and fields:
   F = sort(fieldnames(Data));       % Ignore order of fields
   for iField = 1:length(F)          % Loop over fields
      aField = F{iField};
      Engine.update(uint8(aField));
      for iS = 1:numel(Data)         % Loop over elements of struct array
         Engine = CoreHash(Data(iS).(aField), Engine);
      end
   end
elseif iscell(Data)                  % Get hash for all cell elements:
   for iS = 1:numel(Data)
      Engine = CoreHash(Data{iS}, Engine);
   end
elseif isempty(Data)                 % Nothing to do
elseif isnumeric(Data)
   if isreal(Data)
      Engine.update(typecast(Data(:), 'uint8'));
   else
      Engine.update(typecast(real(Data(:)), 'uint8'));
      Engine.update(typecast(imag(Data(:)), 'uint8'));
   end
elseif islogical(Data)               % TYPECAST cannot handle LOGICAL
   Engine.update(typecast(uint8(Data(:)), 'uint8'));
elseif ischar(Data)                  % TYPECAST cannot handle CHAR
   Engine.update(typecast(uint16(Data(:)), 'uint8'));
elseif isa(Data, 'function_handle')
   Engine = CoreHash(ConvertFuncHandle(Data), Engine);
elseif (isobject(Data) || isjava(Data)) && ismethod(Data, 'hashCode')
   Engine = CoreHash(char(Data.hashCode), Engine);
else  % Most likely a user-defined object:
   try
      BasicData = ConvertObject(Data);
   catch ME
      error(['JSimon:', mfilename, ':BadDataType'], ...
         '%s: Cannot create elementary array for type: %s\n  %s', ...
         mfilename, class(Data), ME.message);
   end
   
   try
      Engine = CoreHash(BasicData, Engine);
   catch ME
      if strcmpi(ME.identifier, 'MATLAB:recursionLimit')
         ME = MException(['JSimon:', mfilename, ':RecursiveType'], ...
            '%s: Cannot create hash for recursive data type: %s', ...
            mfilename, class(Data));
      end
      throw(ME);
   end
end

% ******************************************************************************
function FuncKey = ConvertFuncHandle(FuncH)

FuncKey = functions(FuncH);

% Include modification file time and file size. Suggested by Aslak Grinsted:
if ~isempty(FuncKey.file)
    d = dir(FuncKey.file);
    if ~isempty(d)
        FuncKey.filebytes = d.bytes;
        FuncKey.filedate  = d.datenum;
    end
end

% ******************************************************************************
function Out = fBase64_enc(In)

Pool = [65:90, 97:122, 48:57, 43, 47];  % [0:9, a:z, A:Z, +, /]
v8   = [128; 64; 32; 16; 8; 4; 2; 1];
v6   = [32, 16, 8, 4, 2, 1];

In  = reshape(In, 1, []);
X   = rem(floor(In(ones(8, 1), :) ./ v8(:, ones(length(In), 1))), 2);
Y   = reshape([X(:); zeros(6 - rem(numel(X), 6), 1)], 6, []);
Out = char(Pool(1 + v6 * Y));

% ******************************************************************************
function Ex = FileExist_L(FileName)
% A more reliable version of EXIST(FileName, 'file'):
dirFile = dir(FileName);
if length(dirFile) == 1
   Ex = ~(dirFile.isdir);
else
   Ex = false;
end

% ******************************************************************************
function R = Version_L()

R.HashVersion = 4;
R.Date        = [2016, 2, 28];

R.HashMethod  = {};
try
   Provider = java.security.Security.getProviders;
   for iProvider = 1:numel(Provider)
      S     = char(Provider(iProvider).getServices);
      Index = strfind(S, 'MessageDigest.');
      for iDigest = 1:length(Index)
         Digest       = strtok(S(Index(iDigest):end));
         Digest       = strrep(Digest, 'MessageDigest.', '');
         R.HashMethod = cat(2, R.HashMethod, {Digest});
      end
   end
catch ME
   fprintf(2, '%s\n', ME.message);
   R.HashMethod = 'error';
end

% ******************************************************************************
function Error_L(ID, varargin)

error(['JSimon:', mfilename, ':', ID], ['*** %s: ', varargin{1}], ...
   mfilename, varargin{2:nargin - 1});