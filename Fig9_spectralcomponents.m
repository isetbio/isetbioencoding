% Figure 9:  spectral components
%
% Show the different spectral factors, and then show the fundamentals
%

%%  First the lens
thisLens = Lens;
wave = thisLens.get('wave');
lensDensity = thisLens.density;
ieNewGraphWin;
hold on;
for dd = -1:0.2:1.4
    thisLens.set('density',lensDensity + dd);
    t = thisLens.get('transmittance');
    p = plot(wave,t,'color',[0.5 0.5 0.5]);
    if dd == 0
        p.LineWidth = 2;
        p.Color = 'k';
    end
end
grid on;
xlabel('Wavelength (nm)');
ylabel('Transmittance');

%% Then the Macular pigment

thisM = Macular;
wave = thisM.wave;
macularDensity = thisM.density;

ieNewGraphWin;
hold on;
for dd = -0.2:0.05:0.2
    thisM.density = dd + macularDensity;
    t = thisM.transmittance;
    p = plot(wave,t,'color',[0.5 0.5 0.5]);
    if dd == 0
        p.LineWidth = 2;
        p.Color = 'k';
    end
end
grid on;
xlabel('Wavelength (nm)');
ylabel('Transmittance');

%% The cones
conePigments = photoPigment;
pigmentDensity = conePigments.opticalDensity;

ieNewGraphWin;
hold on;
for dd=-0.2:0.1:0.2
    conePigments.opticalDensity = pigmentDensity + dd*ones(size(pigmentDensity));
    p = plot(conePigments.wave,conePigments.absorptance,'color',[0.5 0.5 0.5]);
    if dd==0
        for ii=1:3
            p(ii).LineWidth = 2;
            p(ii).Color = 'k';
        end
    end
end

%% Fundamentals

% Build a mosaic
cm = cMosaic;

%% Default fundamentals

% Should we make some variations?

cm.wave = 400:1:700;
cm.plot('spectral qe');
xlabel('Wavelength (nm)');
ylabel('Quantal absorption');
grid on;

%%
hdl = ieNewGraphWin; 
hold on;
thisLens = Lens;
for ll = 1 %[-0.5 0 0.2]
    thisLens.density = lensDensity + ll;
    for mm = -0.3:0.1:0
        cm.macular.density = macularDensity + mm;
        [~,fighdl] = cm.plot('spectral qe',[],'lens',thisLens,'hdl',hdl);
        if mm == 0
            fighdl.Children.Children(end).Color = 'k';
        else 
            fighdl.Children.Children(end).Color = [0.5 0.5 0.5];
        end

        cm.macular.density
        thisLens.density
    end
end


