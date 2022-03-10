%% Fig12_melanopsin
%
% Quanta just means use this if your inputs are in quanta.
%
% There is no energy version.  In that case, if you have energy, you can use
% this an get a relative energy absorption.  In other cases, when we
% want quanta but you have energy, we create an 'Energy' version.
%
% Plot rod and melanopsin absorbance curves

wave = 400:1:700;
rods = ieReadSpectra('rods',wave);
melanopsin = ieReadSpectra('melanopsinQuanta',wave);

ieNewGraphWin;
plot(wave,melanopsin,'k-',wave,rods,'k--','LineWidth',3);
legend({'melanopsin','rods'})
xlabel('Wavelength (nm)');
ylabel('Relative sensitivity (quantal)');
grid on;

%%  How many melanopsin absorptions might there be?

% Relative SPD of daylight with a cct of 5000 deg Kelvin
thisDay = daylight(wave,5000);
% ieLuminanceFromEnergy(thisDay',wave);  % Luminance is 100 cd/m2
thisDayQ = Energy2Quanta(wave,thisDay);
melanopsin = ieReadSpectra('melanopsinQuanta',wave);
area = 2e-8;   % 200 microns on a side
coverage = 1e-3;
duration = 50e-3;
peak = 1e-1;  % Ten percent
melanopsinExcitation = thisDayQ'*melanopsin * area * coverage * duration * peak
