%filename: lung.m (main program)
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;

cI_frac_range = 0.1:0.1:2;  % range to loop over for multiplier for cI

cref=0.2/(22.4*(310/273));  % reference concentration of oxygen in air

PA_track = zeros(1,20);     % save mean alveolar partial pressures
cA_track = zeros(1,20);     % save mean alveolar concentrations
Pa_track = zeros(1,20);     % save mean arterial partial pressures
ca_track = zeros(1,20);     % save mean arterial concentrations
Pv_track = zeros(1,20);     % save venous partial pressures
cv_track = zeros(1,20);     % save venous concentrations


for i = 1:20                % loop for multipliers for cI
    cI = cref*cI_frac_range(i);
    setup_lung
    cvsolve
    outchecklung
    PA_track(i) = PAbar;
    cA_track(i) = cAbar;
    Pa_track(i) = Pabar;
    ca_track(i) = cabar;
    Pv_track(i) = Pv;
    cv_track(i) = cv;
end

Pressures_track = [PA_track; Pa_track; Pv_track];
Concentrations_track = [cA_track; ca_track; cv_track];

% calculate elevation
elevation = -log(cI_frac_range)/(29/6.022/10^26)/9.8*1.38*10^-23*310;

figure(4)   % plot pressures
plot(elevation,Pressures_track)
xlabel('Elevation (m)')
ylabel('Pressure (mmHg)')
title('Partial Pressures of Oxygen vs. Elevation')
legend('Mean Alveolar','Mean Arterial','Venous')
subtitle('Elevation Adaptation')

figure(5)   % plot concentrations
plot(elevation,Concentrations_track)
xlabel('Elevation (m)')
ylabel('Concentration of Oxygen (mol/L)')
title('Concentrations of Oxygen vs. Elevation')
subtitle('Elevation Adaptation')
legend('Mean Alveolar','Mean Arterial','Venous')