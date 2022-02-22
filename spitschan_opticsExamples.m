% PSF Optics examples
%
% thisDir = '/Volumes/GoogleDrive/My Drive/Papers/Book Chapters/2021 Circadian Functions (Spitschan)';
% chdir(thisDir)


%% opticsExamples
zCoeffDatabase   = 'Artal2012';
eyeside          = 'right';
pupilDiamMM      = 3.0;
centerpsf        = true;
wave             = 400:10:700;

% Top row
params.wave = [450 550 650];
params.thisSubject = 1;
params.positionDegs =[0 0];

for thisW = params.wave
    
    thisSubject = params.thisSubject;
    positionDegs = params.positionDegs;
    
    [oi, psf, support, zCoeffs, subjID]  = ...
        oiPosition(zCoeffDatabase, 'position',positionDegs, ...
        'pupil diameter', pupilDiamMM, 'subject rank', thisSubject, ...
        'wave',wave, ...
        'eye side', eyeside,'center psf',centerpsf);
    
    idx = find(wave == thisW);
    
    ieNewGraphWin;
    mp = parula(256);
    mp(1:4,:) = repmat([0.5 0.5 0.5],[4,1]);
    imagesc(support.x,support.y,psf(:,:,idx)/max2(psf(:,:,idx)));
    axis image; colormap(mp);
    tMarks  = (-15:5:15); mn = -10; mx = 10;
    set(gca,'xtick',tMarks,'xlim',[mn mx],'ylim',[mn mx]);
    set(gca,'ytick',tMarks);
    xlabel('Position (arc min)'); ylabel('Position (arc min)'); % zlabel('Relative intensity');
    grid on;
    
    % Superimp[ose the line spread
    ieNewGraphWin;
    lsf = psf2lsf(psf);
    lsf = lsf/sum(lsf(:));
    plot(support.y,lsf(:,idx),'Linewidth',2);
    tMarks  = (-15:5:15); mn = -10; mx = 10;
    set(gca,'xtick',tMarks,'xlim',[mn mx],'ylim',[0 5e-3]);
end

%% Second row
zCoeffDatabase = 'Artal2012';
params.wave = 550;
params.thisSubject = 4;
params.positionDegs =[0 0; 10 0; 20 0];

for ii = 1:3
    positionDegs = params.positionDegs(ii,:);
    thisW = params.wave;
    thisSubject = params.thisSubject;
    
    [oi, psf, support, zCoeffs, subjID]  = ...
        oiPosition(zCoeffDatabase, 'position',positionDegs, ...
        'pupil diameter', pupilDiamMM, 'subject rank', thisSubject, ...
        'wave',wave, ...
        'eye side', eyeside,'center psf',centerpsf);
    
    idx = find(wave == thisW);
    
    ieNewGraphWin;
    mp = parula(256);
    mp(1:4,:) = repmat([0.5 0.5 0.5],[4,1]);
    imagesc(support.x,support.y,psf(:,:,idx)/max2(psf(:,:,idx)));
    axis image; colormap(mp);
    tMarks  = (-15:5:15); mn = -10; mx = 10;
    set(gca,'xtick',tMarks,'xlim',[mn mx],'ylim',[mn mx]);
    set(gca,'ytick',tMarks);
    xlabel('Position (arc min)'); ylabel('Position (arc min)'); % zlabel('Relative intensity');
    grid on;
    
    % Superimp[ose the line spread
    ieNewGraphWin;
    lsf = psf2lsf(psf);
    lsf = lsf/sum(lsf(:));
    plot(support.y,lsf(:,idx),'Linewidth',2);
    tMarks  = (-15:5:15); mn = -10; mx = 10;
    set(gca,'xtick',tMarks,'xlim',[mn mx],'ylim',[0 5e-3]);
end

%% Second row
zCoeffDatabase = 'Artal2012';
params.wave = 550;
params.thisSubject = 4;
params.positionDegs =[0 0; 10 0; 20 0];

for ii = 1:3
    positionDegs = params.positionDegs(ii,:);
    thisW = params.wave;
    thisSubject = params.thisSubject;
    
    [oi, psf, support, zCoeffs, subjID]  = ...
        oiPosition(zCoeffDatabase, 'position',positionDegs, ...
        'pupil diameter', pupilDiamMM, 'subject rank', thisSubject, ...
        'wave',wave, ...
        'eye side', eyeside,'center psf',centerpsf);
    
    idx = find(wave == thisW);
    
    ieNewGraphWin;
    mp = parula(256);
    mp(1:4,:) = repmat([0.5 0.5 0.5],[4,1]);
    imagesc(support.x,support.y,psf(:,:,idx)/max2(psf(:,:,idx)));
    axis image; colormap(mp);
    tMarks  = (-15:5:15); mn = -10; mx = 10;
    set(gca,'xtick',tMarks,'xlim',[mn mx],'ylim',[mn mx]);
    set(gca,'ytick',tMarks);
    xlabel('Position (arc min)'); ylabel('Position (arc min)'); % zlabel('Relative intensity');
    grid on;
    
    % Superimp[ose the line spread
    ieNewGraphWin;
    lsf = psf2lsf(psf);
    lsf = lsf/sum(lsf(:));
    plot(support.y,lsf(:,idx),'Linewidth',2);
    tMarks  = (-15:5:15); mn = -10; mx = 10;
    set(gca,'xtick',tMarks,'xlim',[mn mx],'ylim',[0 5e-3]);
end

%% Third row

zCoeffDatabase = 'Artal2012';
params.wave = 550;
params.thisSubject = [5 15 25];
params.positionDegs =[5 0];

for ii = 1:3
    positionDegs = params.positionDegs;
    thisW = params.wave;
    thisSubject = params.thisSubject(ii);
    
    [oi, psf, support, zCoeffs, subjID]  = ...
        oiPosition(zCoeffDatabase, 'position',positionDegs, ...
        'pupil diameter', pupilDiamMM, 'subject rank', thisSubject, ...
        'wave',wave, ...
        'eye side', eyeside,'center psf',centerpsf);
    
    idx = find(wave == thisW);
    
    ieNewGraphWin;
    mp = parula(256);
    mp(1:4,:) = repmat([0.5 0.5 0.5],[4,1]);
    imagesc(support.x,support.y,psf(:,:,idx)/max2(psf(:,:,idx)));
    axis image; colormap(mp);
    tMarks  = (-15:5:15); mn = -10; mx = 10;
    set(gca,'xtick',tMarks,'xlim',[mn mx],'ylim',[mn mx]);
    set(gca,'ytick',tMarks);
    xlabel('Position (arc min)'); ylabel('Position (arc min)'); % zlabel('Relative intensity');
    grid on;
    
    % Superimp[ose the line spread
    ieNewGraphWin;
    lsf = psf2lsf(psf);
    lsf = lsf/sum(lsf(:));
    plot(support.y,lsf(:,idx),'Linewidth',2);
    tMarks  = (-15:5:15); mn = -10; mx = 10;
    set(gca,'xtick',tMarks,'xlim',[mn mx],'ylim',[0 5e-3]);
end

%%
h = colorbar;

