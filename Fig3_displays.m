%%  Figure 3 
%
% Chapter: Visual Encoding 
% Authors: Wandell, Brainard, Cottaris
% Editor:  Spitschan
%
% Figure caption:
%
% Path must include ISETBio
%

%{
thisDir = '/Volumes/GoogleDrive/My Drive/Papers/Book Chapters/2021 Circadian Functions (Spitschan)';
chdir(thisDir)
%}

%% SceneFromFile demonstration

displayName = 'LCD-Apple';
scene = sceneFromFile('woodDuck.png','rgb',100,displayName);
sceneWindow(scene);

% Pick a rectangular region.
% You can select another region this way:
%
%   roi = vcROISelect(scene); rect = ieLocs2Rect(roi)
%
rect = [193 93 120 190];

scenePlot(scene,'radiance energy roi',rect);
thisAx = gca;
thisAx.Children.LineWidth = 2;
thisAx.Children.Color = 'k';

%% The special display that creates natural radiance spectra
%
% The display is built for D65 illuminant
%

displayName = 'reflectance-display';
scene = sceneFromFile('woodDuck.png','rgb',100,displayName);
sceneWindow(scene);

scenePlot(scene,'radiance energy roi',roi);
thisAx = gca;
thisAx.Children.LineWidth = 2;
thisAx.Children.Color = 'k';

%% Now a pretty standard Samsung display

displayName = 'OLED-Samsung';
scene = sceneFromFile('woodDuck.png','rgb',100,displayName);
sceneWindow(scene);

scenePlot(scene,'radiance energy roi',roi);
thisAx = gca;
thisAx.Children.LineWidth = 2;
thisAx.Children.Color = 'k';

%%  Now the displays themselves

wave = 400:1:700;
wSamples = 400:50:700;
displayName = 'LCD-Apple';
thisDisplay = displayCreate(displayName);
displayPlot(thisDisplay,'spd');
set(gca,'xtick',wSamples,'ytick',(1:4)*1e-3);

displayName = 'reflectance-display';
thisDisplay = displayCreate(displayName);
displayPlot(thisDisplay,'spd');
set(gca,'xtick',wSamples,'ytick',(-1:4)*1e-3);
p = xaxisLine;
p.LineWidth = 0.5;

basis = ieReadSpectra('reflectanceBasis.mat',wave);
basis(:,1) = -1*basis(:,1);
hdl = plotReflectance(wave,basis(:,1:3));

thisAx = get(hdl,'CurrentAxes'); p = thisAx.Children;
p(1).Color = 'k';
p(2).Color = 'k'; p(2).LineStyle = '-.';
p(3).Color = 'k'; p(3).LineStyle = '--';

thisLine = xaxisLine;
lineShade = [0.7 0.7 0.7];
thisLine.LineWidth = 2; thisLine.LineStyle = '-'; thisLine.Color = lineShade;
title('');

d65 = ieReadSpectra('d65.mat',wave);
d65 = d65/max(d65(:));
hdl = plotRadiance(wave,d65);
thisAx = get(hdl,'CurrentAxes'); p = thisAx.Children;
for ii=1:numel(p)
    p(ii).Color = 'k';
end
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

%%


