%% Display letters
%
% thisDir = '/Volumes/GoogleDrive/My Drive/Papers/Book Chapters/2021 Circadian Functions (Spitschan)';
% chdir(thisDir)
%
% ISETBio.

%%
ieInit;

%% Create a scene to zoom in on the rendered font

% displayName = 'LCD-Apple';
% displayName = 'Dell-Chevron';
% displayName = 'OLED-Sony';
displayName = 'OLED-Samsung';
thisDisplay = displayCreate(displayName);

% family, size, dpi
font = fontCreate('R', 'Georgia', 14, 96);

scene = sceneCreate('letter', font, displayName);
scene = sceneSet(scene,'wangular',0.6);
sceneWindow(scene);

% Or in the display window
rgb = sceneGet(scene,'rgb');
thisDisplay = displaySet(thisDisplay,'main image',rgb);
displayWindow(thisDisplay)

%% If we need an image of a human eye model

gullstrand = lensC('file name','gullstrand.json');

gullstrand.set('aperture diameter',5);

gullstrand.draw;
grid on
title('LeGrand-Gullstrand eye')

% line([16 16],[-5,5],'Color','b');

%% Plot the excitations in various ways

oi = oiCreate;
oi = oiCompute(oi,scene);
oiWindow(oi);

cm = cMosaic('positionDegs',[0.3 0],'sizeDegs',[0.5 0.5]);
cm.visualize;
cm.integrationTime = 0.05;

allE = cm.compute(oi);
cm.plot('excitations',allE);

[uData,hdl] = cm.plot('excitations horizontal line',allE,'ydeg',-0.1,'thickness',0.02);
cm.plot('roi',allE,'roi',uData.roi)

[uData,hdl] = cm.plot('excitations horizontal line',allE,'ydeg',0.15,'thickness',0.02);
cm.plot('roi',allE,'roi',uData.roi)

%%