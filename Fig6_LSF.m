%% Figure 6:  LSFs using the ISETBIOCsfGenerator methods
%
%  thisDir = '/Volumes/GoogleDrive/My Drive/Papers/Book Chapters/2021 Circadian Functions (Spitschan)';
%  chdir(thisDir)
%
% Where is the function oiPosition?  Not checked in from somewhere?
%

%% opticsLSF
zCoeffDatabase   = 'Artal2012';   
subjectRank      = 1:8; % [2, 5, 10, 20];
eyeside          = 'right';
pupilDiamMM      = 3.0;
centerpsf        = true;
wave             = 400:10:700;

pos = -3:1:3;

for thisSubject = subjectRank
    lsf = zeros(201,numel(wave),numel(pos));
    for ii=1:numel(pos)
        positionDegs     = [pos(ii) 0];   % v
        
        [oi, psf, support, zCoeffs, subjID]  = ...
            oiPosition(zCoeffDatabase, 'position',positionDegs, ...
            'pupil diameter', pupilDiamMM, 'subject rank', thisSubject, ...
            'wave',wave, ...
            'eye side', eyeside,'center psf',centerpsf);
        
        % x, w, pos
        lsf(:,:,ii) = psf2lsf(psf);
    end
    
    % Find the luminance weighted sum (luminance)
    
    lumLSF = zeros(201,numel(pos));
    vLambda = ieReadSpectra('Vlambda',wave);
    for ii=1:numel(pos)
        lumLSF(:,ii) = lsf(:,:,ii)*vLambda(:);
    end
    
    lumLSF = lumLSF/max(lumLSF(:));
    
    % Show as line plots
    
    ieNewGraphWin;
    hold on;
    for ii=1:2:numel(pos)
        if abs(pos(ii)) <= 4
            plot(support.y,lumLSF(:,ii),'k-','Linewidth',2);
        end
    end
    grid on;
    xlabel('Arc min'); ylabel('Relative luminance')
    set(gca,'ylim',[-0.1 1]); set(gca,'xlim',[-5 5]);
    set(gca,'xtick',(-5:2.5:5));
    legend(sprintf('Subject %d',thisSubject));
    drawnow; pause(0.5);
    print(sprintf('LSF_%s_%d',zCoeffDatabase,thisSubject),'-dpng');
end

%% Show multiple waves

wavesamples = [400, 450, 500, 550, 600, 650];

leg = cell(numel(wavesamples),1);
for ii=1:numel(wavessamples)
    leg{ii} = [num2str(wavesamples(ii)),' nm'];
end

%%
ieNewGraphWin;
hold on;
for ii=1:numel(wavessamples)
    idx = find(wave == wavessamples(ii));
    plot(support.y,lsf(:,idx),'Linewidth',2);
end
set(gca,'xlim',[-8 8],'ylim',[0 1]);
legend(leg);
xlabel('Arc min'); ylabel('Relative intensity');
grid on;

%%

lsfs = zeros(201,numel(pos));
for ii=1:numel(pos)
    tmp = squeeze(lsf(:,idx,ii));
    thisLSF = lsf(:,idx,ii)/sum(lsf(:,idx,ii));
    lsfs(:,ii) = thisLSF;
end

%% Show as a surface
surf(pos,support.y,lumLSF);
xlabel('Eccentricity (deg)'); ylabel('Arc min');
set(gca,'ylim',[-5 5]);
title(sprintf('Artal data, Subj rank: %d',subjectRank));


%%  Compare at a single wavelength

thisWave = 450;
idx = find(wave == thisWave);

lsfs = zeros(201,numel(pos));
for ii=1:numel(pos)
    tmp = squeeze(lsf(:,idx,ii));
    thisLSF = lsf(:,idx,ii)/sum(lsf(:,idx,ii));
    lsfs(:,ii) = thisLSF;
end

%{
ieNewGraphWin;
hold on;
for ii=1:numel(pos)
   plot(support.x,lsfs(:,ii));
end
%}

%% Highest resolution

ieNewGraphWin;
surf(pos,support.y,lsfs);
xlabel('Eccentricity (deg)'); ylabel('Arc min');
colormap(cool);
title(sprintf('Wave %d',thisWave));

%%  Sampled at 0.5 min which is the cone density in the fovea

possamples = (0:1:10);
% arcmin = support.y(:);
% possamples = pos;
arcmin = (-10:0.5:10)';
lsfsInterp = interp2(pos(:),support.y(:),lsfs,possamples,arcmin);

ieNewGraphWin;
surf(possamples,arcmin,lsfsInterp);
xlabel('Eccentricity (deg)'); ylabel('Arc min');
title(sprintf('Wave %d',thisWave));

%%
%{
surf(possamples',arcmin(:),sInterp);
xlabel('Eccentricity (deg)'); ylabel('Arc min');
colormap(cool);
%}
%%
%{
xlabel('arc min'); ylabel('relative intensity');
imagesc(support.x, support.y, squeeze(psf(:,:,idx)));
axis 'square'; colormap(gray); xlabel('arc min'); ylabel('arc min');
%}


