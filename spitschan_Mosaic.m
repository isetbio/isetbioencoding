%% Mosaic illustrated
%
% thisDir = '/Volumes/GoogleDrive/My Drive/Papers/Book Chapters/2021 Circadian Functions (Spitschan)';
% chdir(thisDir)
%
% ISETBio.


%%

%cmP = cMosaicParams;
% cm = cMosaic(cmP);
% cm.visualize;

%% A decent look at a strip along the horizontal axis

% The LSF is pretty constant along here.  The macular pigment is not.
cmP = cMosaicParams;
cmP.positionDegs = [3,0];
cmP.sizeDegs = [6 1];
cm = cMosaic(cmP);
cm.visualize('plotTitle',' ');

%%
hP = harmonicP;
hP.col = 512;
hP.freq = 10;
scene = sceneCreate('harmonic',hP);
scene = sceneSet(scene,'fov',7);
oi = oiCreate('wvf human');
oi = oiCompute(oi,scene);

%%
cm.integrationTime = 0.05;
allE = cm.compute(oi);
cm.plot('excitations',allE);
uData = cm.plot('excitations horizontal line',allE,'ydeg',0);


%% Check that the total number of photons per deg is about the same

% This might be an artifact of the way NC is computing.  But the general
% idea is sane.
nRegions = 50;
xRange = max(uData.pos(:,1));
xStep = xRange/nRegions;
regionE = zeros(nRegions,1);
regionP = region;
excitations = squeeze(uData.roiE);
for ii=1:nRegions
    l = uData.pos(:,1) <= xStep*ii & uData.pos(:,1) > xStep*(ii - 1);
    regionP(ii) = xStep*ii;
    regionE(ii) = sum(excitations(l));
end

ieNewGraphWin;
plot(regionP,regionE);
grid on;
xlabel('Retinal position (deg)'); ylabel('Summed excitations');

%%
%%