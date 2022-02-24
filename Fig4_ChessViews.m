%% Chess set and letters and materials
%
%  thisDir = '/Volumes/GoogleDrive/My Drive/Papers/Book Chapters/2021 Circadian Functions (Spitschan)';
%  chdir(thisDir)
%
%  Material properties.  Figure fig:iset3dExamples
%
%  Best to use with ISETCam because IMHO, but works either way.
%
% For HDR, use ISETCam-ISET3d

%%
ieInit
if ~piDockerExists, piDockerConfig; end

%% Set up

% Grab the general scene
chessR = piRecipeDefault('scene name','ChessSet');
% piWRS(chessR);

chessR = piMaterialsInsert(chessR);
chessR.get('print materials')

% to
toObject = [0.03 0.05 -0.01];   % A good object
chessR.set('to',toObject);

% Top view, looking forward
topForward = [-0.0000  0.150   -0.6000];

% Top view, looking back
topBackward = [0 0.4 0.5];

% Side view
% sideView = [0.7 0.2 -0.1];
sideView = [0.5138    0.15   -0.40];

% Top view, lower, forward
topForward2 = [-0.0000  0.18   -0.6000];

chessR.set('fov',70);

% piWRS(chessR);

%%  Change the light

chessR.set('light', 'all', 'delete');

% fileName = 'cathedral_interior.exr';
% fileName = 'brightfences.exr';
fileName = 'room.exr';
envLight = piLightCreate('background', ...
    'type', 'infinite',...
    'mapname', fileName);

chessR.set('lights',  envLight, 'add');                       
% chessR.get('light print');

% chessR.show('skymap');

% 45 is a uniform yellow
% 90 is

% To see the windows use something like 80, -45, 0
%
% In this case the y value needs to be negative, but it does not seem
% to matter much what it is.  You generally want the rotation around
% the x and z axis to be 90 deg to square it up.
% Rotating z changes a lot.

chessR.set('light', 'background', 'world orientation', [90, -45, 0]);
chessR.get('light', 'background', 'world orientation')
% To change the position of the global illumination, ...
%{
 chessR.set('light',  'background', 'world orientation', [0 0 0]);
 piWRS(chessR);
%}

%% Low Res

% {
chessR.set('rays per pixel',64);
chessR.set('film resolution',[256 256]);
chessR.set('n bounces',2);
%}

%% Hi Res
%{
chessR.set('rays per pixel',512);
chessR.set('film resolution',[1024 1024]);
chessR.set('n bounces',4);
%}

%%
chessR.show('objects');

%% Glass and mirror

% Lyse_brikker_008 = chessR.get('material','Lyse_brikker_008');
% chessR.set('material','Lyse_brikker_008','kd val','wood');
% 
% Mrke_brikker_004 = chessR.get('material','Mrke_brikker_004');
% chessR.set('material','Mrke_brikker_004','kd val','brickwall');

chessR.set('n bounces',4);  % Needed for glass.
names = chessR.get('object names no id');
for ii=1:numel(names)
    if piContains(names{ii},'mesh')
        thisMaterial = chessR.get('asset',names{ii},'material name');
        if piContains(thisMaterial,'Lyse')
            chessR.set('asset',names{ii},'material name','glass');
        elseif piContains(thisMaterial,'Mrke')
            chessR.set('asset',names{ii},'material name','mirror');
        end
    end
end

%{
chessR.set('rays per pixel',1024);
chessR.set('film resolution',[1024 1024]);
chessR.set('n bounces',6);
%}
% {
chessR.set('from',topForward);
chessR.set('object distance',0.35);
piWRS(chessR);
%{

chessR.set('from',sideView);
chessR.set('object distance',0.35);
piWRS(chessR);

chessR.set('from',topBackward);
piWRS(chessR);

chessR.set('from',topForward2);
piWRS(chessR);
%}

%% Marble and mahogany

chessR = piRecipeDefault('scene name','chess set');
chessR = piMaterialsInsert(chessR);
chessR.set('to',toObject);
chessR.set('light', 'all','delete');  % Changed for V4
fileName = 'room.exr';
envLight = piLightCreate('background', ...
    'type', 'infinite',...
    'mapname', fileName);
chessR.set('lights', envLight,'add');  % Changed for V4                      

%{
chessR.set('rays per pixel',1024);
chessR.set('film resolution',[1024 1024]);
chessR.set('n bounces',6);
%}

names = chessR.get('object names no id');
for ii=1:numel(names)
    if piContains(names{ii},'mesh')
        thisMaterial = chessR.get('asset',names{ii},'material name');
        if piContains(thisMaterial,'Lyse')
            chessR.set('asset',names{ii},'material name','marbleBeige');
        elseif piContains(thisMaterial,'Mrke')
            chessR.set('asset',names{ii},'material name','mahogany_dark');
        end
    end
end

% These worked, too.
% chessR.set('material','planeTan','kd val','wood001');
% chessR.set('material','planeTan','kd val','wood002');
% chessR.set('material','planeTan','kd val','marbleBeige');

% For some reason, GroundMaterial gets a random number attached to it.
n = chessR.get('object names');
ii = find(piContains(n,'GroundMaterial'));
chessR.set('asset',n{ii},'material name','wood001');

%%  Mahogany series
% {
chessR.set('from',topForward);
piWRS(chessR);
%{
chessR.set('from',sideView);
piWRS(chessR);

chessR.set('from',topBackward);
piWRS(chessR);

chessR.set('from',topForward2);
piWRS(chessR);
%}

%% Write them out copying and pasting here

%{
  filename = 'front2-glass-metal.png';
  scene = ieGetObject('scene');  
  rgb = sceneGet(scene,'rgb');
  imwrite(rgb,fullfile(thisDir,filename));
%}

%{
scene1 = ieGetObject('scene');
scene2 = ieGetObject('scene');
save('sceneMaterials','scene1','scene2');
%}

%% END


