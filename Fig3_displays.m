%%  Figure helpers
%
%  Describes rgb to scene ideas
%
%  Wood duck series here.  Requires only ISETBio, I think.
%
% thisDir = '/Volumes/GoogleDrive/My Drive/Papers/Book Chapters/2021 Circadian Functions (Spitschan)';
% chdir(thisDir)

%% SceneFromFile demonstration

displayName = 'LCD-Apple';
scene = sceneFromFile('woodDuck.png','rgb',100,displayName);
sceneWindow(scene);
thisAx = gca;
thisAx.Children.LineWidth = 2;
thisAx.Children.Color = 'k';

% Pick a region.  But maybe first update the select routines?
% roi = vcROISelect(scene);
% rect = ieLocs2Rect(roi)

rect = [193 93 120 190];

scenePlot(scene,'radiance energy roi',roi);
thisAx = gca;
thisAx.Children.LineWidth = 2;
thisAx.Children.Color = 'k';
%%
displayName = 'reflectance-display';
scene = sceneFromFile('woodDuck.png','rgb',100,displayName);
sceneWindow(scene);

scenePlot(scene,'radiance energy roi',roi);
thisAx = gca;
thisAx.Children.LineWidth = 2;
thisAx.Children.Color = 'k';


%%
displayName = 'OLED-Samsung';
scene = sceneFromFile('woodDuck.png','rgb',100,displayName);
sceneWindow(scene);

scenePlot(scene,'radiance energy roi',roi);
thisAx = gca;
thisAx.Children.LineWidth = 2;
thisAx.Children.Color = 'k';


%%
displayName = 'LCD-Apple';
thisDisplay = displayCreate(displayName);
displayPlot(thisDisplay,'spd');
set(gca,'xtick',[400:100:700],'ytick',[1:4]*1e-3);

displayName = 'reflectance-display';
thisDisplay = displayCreate(displayName);
displayPlot(thisDisplay,'spd');
set(gca,'xtick',[400:100:700],'ytick',[-1:4]*1e-3);
p = xaxisLine;
p.LineWidth = 0.5;

wave = 400:1:700;
basis = ieReadSpectra('reflectanceBasis.mat',wave);
basis(:,1) = -1*basis(:,1);
[~,p] = plotReflectance(wave,basis(:,1:3));
p(1).Color = 'k';
p(2).Color = 'k'; p(2).LineStyle = ':';
p(3).Color = 'k'; p(3).LineStyle = '--';
thisLine = xaxisLine;
thisLine.LineWidth = 0.5;
title('');

d65 = ieReadSpectra('d65.mat',wave);
d65 = d65/max(d65(:));
[~,p] = plotRadiance(wave,d65);
p.Color = 'k';
title('');

% Calibration files are stored in data/displays/
% d = displayCreate('OLED-Samsung');

%{
displayName = 'reflectance-display';
scene = sceneFromFile('stanfordQuadEntryLowRes.png','rgb',100,displayName);
sceneWindow(scene);
%}
%%  Illustrate text
scene = sceneFromFile('text.png','rgb',50,'reflectance-display');
sceneWindow(scene);




