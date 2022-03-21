%% Figure generation derived from for RealityLabs 2021 application
%
% ISETBio-ISET3D
%
% thisDir = '/Volumes/GoogleDrive/My Drive/Papers/Book Chapters/2021 Circadian Functions (Spitschan)';
% chdir(thisDir)
%

%% Rendering of letters
if piCamBio
    fprintf('%s: requires ISETBio, not ISETCam\n',mfilename); 
    return;
end
ieInit;
if ~piDockerExists, piDockerConfig; end

%% Here are the World positions of the letters in the scene

% The units are in meters
toA = [-0.0486     0.0100     0.5556];
toB = [  0         0.0100     0.8333];
toC = [ 0.1458     0.0100     1.6667];

%% Show the scene

% This is rendered using a pinhole so the rendering is fast.  It has
% infinite depth of field (no focal distance).
thisSE = sceneEye('letters at depth','human eye','legrand');
% thisSE.summary;

% Position the eye off to the side so we can see the 3D easily
from = [0.25,0.3,-1.3];
thisSE.set('from',from);

% Look at the position with the 'B'.  The values for each of the letters
% are included above.
thisSE.set('to',toB);
thisSE.set('from',from - [0.5 0 0.7]);

% Reduce the rendering noise by using more rays. 
thisSE.set('rays per pixel',32);      

% Increase the spatial resolution by adding more spatial samples.
thisSE.set('spatial samples',512);  

% Have a quick check with the pinhole
thisSE.set('use pinhole',true);

% thisSE.get('object distance')   % Default is 2.1674
% If we make it further, we can narrow the FOV, I think
% thisSE.set('object distance',6);
% thisSE.set('fov',6);

% Given the distance from the scene, this FOV captures everything we want
thisSE.set('fov',6);             % Degrees

letterA = '001_A_O';
letterB = '001_B_O';
letterC = '001_C_O';

bPos = thisSE.get('asset',letterB,'world position');
cPos = thisSE.get('asset',letterC,'world position');

% The fraction of the distance from C to B.
thisSE.set('asset',letterC,'world position', cPos + 0.5*(bPos - cPos));

thisSE.set('asset','001_Ground_O','scale',[0.15 .3 1]);

% Adds a bunch of default materials
thisSE.recipe = piMaterialsInsert(thisSE.recipe);

%% Add textures

thisSE.recipe = piTextureInsert(thisSE.recipe);

% The texture is set by placing the
groundMaterial = thisSE.recipe.get('material','GroundMaterial');
groundMaterialName = piMaterialGet(groundMaterial,'name');
thisSE.recipe.set('material', groundMaterialName, 'kd val', 'wood');

wallMaterial = thisSE.recipe.get('material','WallMaterial');
wallTextureName = piMaterialGet(wallMaterial,'name');
thisSE.set('material',wallTextureName,'kd val','brickwall');

%%
thisSE.set('lights','delete','all');

%{
spotName = 'spot1';
spotLight = piLightCreate(spotName, 'type','spot','rgb spd',[1 1 0.5],'cameracoordinate',1);
thisSE.set('light','add',spotLight);
thisSE.set('light',spotLight,'coneangle',75);

spotName = 'spot2';
spotLight = piLightCreate(spotName, 'type','spot','rgb spd',[0.5 1 1]);
thisSE.set('light','add',spotLight);
thisSE.set('light',spotLight,'translation value',{[1 0 0]});
thisSE.set('light',spotLight,'coneangle',20);

%}

% {
envName = 'infinite';
envLight = piLightCreate(envName, 'type','infinite','rgb spd',[1 1 1]);
thisSE.set('light','add',envLight);
%}

% Experiments.
% thisSE.set('light',spotLight,'scale',[1000,1000,10]);

%% Render the scene at different camera positions. 

% Add those in to make some point about stereo.
from = thisSE.get('from');

thisSE.set('asset', letterA, 'material name', 'glass');
thisSE.set('asset', letterB, 'material name', 'mirror');
thisSE.set('asset', letterC, 'material name', 'Shiny');

scene = thisSE.render('render type','radiance'); sceneWindow(scene);
% piAssetGeometry(thisSE.recipe);
% thisSE.recipe.show('objects');
% thisSE.recipe.show('lights');

%% Change view positions

thisSE.set('from',from - [0.06 0.0 0]);
scene = thisSE.render('render type','radiance'); sceneWindow(scene);

thisSE.set('from',from + [0.06 0.0 0]);
scene = thisSE.render('render type','radiance'); sceneWindow(scene);


%% Use the eye model now

% Turn off the pinhole.  The model eye (by default) is the Navarro model.
thisSE.set('use pinhole',false);

% We turn on chromatic aberration.  That slows down the calculation, but
% makes it more accurate and interesting.  We oftens use only 8 spectral
% bands for speed and to get a rought sense. You can use up to 31.  It is
% slow, but that's what we do here because we are only rendering once. When
% the GPU work is completed, this will be fast!
nSpectralBands = 8;
thisSE.set('chromatic aberration',nSpectralBands);

% Find the distance to the object
oDist = thisSE.get('object distance');

% This is the distance to the B and we set our accommodation to that.
thisSE.set('focal distance',oDist);  

% Reduce the rendering noise by using more rays. 
thisSE.set('rays per pixel',256);      

% Increase the spatial resolution by adding more spatial samples.
thisSE.set('spatial samples',512);     

thisSE.set('from',from);
oi = thisSE.render('render type','radiance');
oiWindow(oi);

% This takes longer than the pinhole rendering, so we do not bother with
% the depth.
thisSE.set('from',from - [0.06,0,0]);
oi = thisSE.render('render type','radiance');
oiWindow(oi);

thisSE.set('from',from + [0.06,0,0]);
oi = thisSE.render('render type','radiance');
oiWindow(oi);

save(fullfile(thisDir,'oiLetters'),'oi');

%% Render the 3D letters on the mosaic


% load('cm1x1.mat','cm');
load('cm5x5.mat','cm');

% A long strip along the horizontal axis
% cm = cMosaic('positionDegs',[0 0],'sizeDegs',[1 1]);
cm.visualize;
title('');

oi = vcGetObject('oi');

% save('cm5x5','cm');
[allE, noisyE] = cm.compute(oi);
cm.plot('excitations',allE);
title('');




