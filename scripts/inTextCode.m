%% Line 154

filename = fullfile(isetRootPath,'data','images','rgb','woodDuck.png');
meanLuminance = 50;
scene = sceneFromFile(filename,'RGB',meanLuminance,'LCD-Apple');
sceneWindow(scene);

%% Line 280

% The default OI is a model of the human foveal optics
oi = oiCreate;

% Convert the scene spectral radiance to retinal spectral irradiance
oi = oiCompute(oi,scene);

% View a rendering of the spectral irradiance image
oiWindow(oi);


%% Line 300
% 
oi = oiPosition('Artal2012', ...
'position',[5,0], ...
'eye side','right', ...
'subject rank',5);

%% Line 320

oi = oiCreate('diffraction limited');
oi = oiSet(oi,'optics fnumber',5.6);
oiPlot(oi,'psf 550');
set(gca,'xlim',[-20 20],'ylim',[-20 20]);


%% Line 425
photons = Energy2Quanta(wavelength, energy);
energy  = Quanta2Energy(wavelength, photons);

%% Line 458

ieNewGraphWin;
thisLens = Lens;
for dd = 0.8:0.1:1.2
    thisLens.density = dd;
    plot(thisLens.wave,thisLens.transmittance);
    hold on;
end
grid on; xlabel('Wavelength (nm)'); ylabel('Transmittance')

%% Line 489

cmP = cMosaicParams;         % Return the settable parameters
cmP.positionDegs = [3,0];    % Center position of the mosaic
cmP.sizeDegs = [6 1];        % Size of the mosaic
cm = cMosaic(cmP);           % Create the cone mosaic
cm.visualize                 % Visualize the mosaic

%% Line 504

% The scene spectral radiance
scene = sceneCreate('dead leaves');
scene = sceneSet(scene,'fov',2);

% The optical image (retinal spectral irradiance)
oi    = oiCreate;
oi    = oiCompute(oi,scene);

% The cMosaic
cmP   = cMosaicParams; cmP.positionDegs = [0,0]; cmP.sizeDegs = [2 2];
cm    = cMosaic(cmP);
allE  = cm.compute(oi);

% Show an image of the excitations
cm.plot('excitations',allE);  colormap("jet")

%%



    



    