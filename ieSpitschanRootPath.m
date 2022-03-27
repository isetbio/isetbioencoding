function rootPath = ieSpitschanRootPath()
% Return the path to the root isetspitschan directory
%
% Syntax:
%   rootPath = ieSpitschanRootPath;
%
% Description:
%    This points at the top level of the isetbio tree on the Matlab path.
%
%    Examples are included within the code.
%
% Inputs:
%    None.
%
% Outputs:
%    rootPath - The root directory for isetspitschan
%
% Optional key/value pairs:
%    None.
%
% Notes:
%    * [Note: XXX - This function works by using the function mfilename to
%      find itself, and then walks back up the result to the top level of
%      isetbio. Thus, you can't move this function within the isetbio tree
%      without also adjusting the number of levels in the walk to match
%      where you move it to.]
% 
% See Also:
%    isetbioDataPath, isetRootPath

% Examples:
%{
    fullfile(isetSpitschanRootPath, 'data')
%}

%% Get path to this function and then walk back up to the isetbio root.
pathToMe = mfilename('fullpath');

%% Walk back up the chain
rootPath = fileparts(pathToMe);

end
