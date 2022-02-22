%% Requires ISET3d-V4
%
% Old script, kept around just to illustrate using ISET3d-V4.
%
%  Sphere scene
%
% thisDir = '/Volumes/GoogleDrive/My Drive/Papers/Book Chapters/2021 Circadian Functions (Spitschan)';
% chdir(thisDir)
%
% 

%%
ieInit;
if ~piDockerExists, piDockerConfig; end

%% Read pbrt file 

sceneName = 'sphere';
thisR = piRecipeDefault('scene name',sceneName);

% Add some materials
thisR = piMaterialsInsert(thisR);

% Create an environmental light source (distant light) that is a 9K
% blackbody radiator.
distLight = piLightCreate('new dist light',...
    'type', 'distant',...
    'spd', 9000,... % blackbody
    'cameracoordinate', true);
thisR.set('light', distLight, 'add');

thisR.set('film resolution',[200 150]*2);
thisR.set('rays per pixel',64);
thisR.set('fov',45);
thisR.set('nbounces',5);
% thisR.set('film render type',{'radiance','depth'});

thisR.show('objects');

% Make the sphere a little smaller
assetName = 'Sphere_O';
thisR.set('asset',assetName,'scale',[0.5 0.5 0.5]);

% Render
piWRS(thisR,'name',sprintf('Distant light %s',sceneName));

%% Make the sphere glass

thisR.set('light',  'all', 'delete');

% mapName = 'room.exr';
% mapName = 'glacier_latlong.exr';
% mapName = 'environment_Reflection.exr';
% mapName = 'wtn-texture3-grass.exr';
mapName = 'cathedral_interior.exr';

thisR.set('skymap',mapName);
if ~exist(fullfile(thisR.get('output dir'),mapName),'file')
    exrFile = fullfile(piRootPath,'data','lights',mapName);
    copyfile(exrFile,thisR.get('output dir'))
end

%% Render the sphere

thisR.set('render type',{'radiance'});
scene = piWRS(thisR,'name',sprintf('Red in environment %s',sceneName));

if piCamBio, sceneSet(scene,'render flag','hdr');
else,        sceneSet(scene,'gamma',0.6);
end

%% Turn the sphere to glass

% glassName = 'glass';
% glass = piMaterialCreate(glassName, 'type', 'dielectric','eta','glass-BK7');
% thisR.set('material', 'add', glass);
% thisR.get('print materials');

thisR.set('asset', assetName, 'material name', 'glass');
thisR.get('object material')

piWRS(thisR, 'name', 'Change sphere to glass');

%{
if piCamBio, sceneSet(scene,'render flag','hdr');
else,        sceneSet(scene,'gamma',0.6);
end
%}

%% Turn it to mirror

thisR.set('asset', assetName, 'material name', 'mirror');
thisR.get('object material')

scene = piWRS(thisR, 'name', 'Change glass to mirror');

% {
% Highlights so we need to gamma correct or HDR
if piCamBio, sceneSet(scene,'render flag','hdr');
else,        sceneSet(scene,'gamma',0.3);
end
%}

%% Rotate the skymap

thisR.get('lights print');
thisR.set('light','skymap_L','rotate',[30 0 0 0]);

scene = piWRS(thisR, 'name', 'Rotate the skymap');

% {
% Highlights so we need to gamma correct or HDR
if piCamBio, sceneSet(scene,'render flag','hdr');
else,        sceneSet(scene,'gamma',0.3);
end
%}

%%