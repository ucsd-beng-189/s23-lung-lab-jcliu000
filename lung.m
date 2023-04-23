%filename: lung.m (main program)
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;

beta_range = 0:0.05:1;   % range to loop over for beta

PI_track = zeros(1,11); % save inspired partial pressure of oxygen
PA_track = zeros(1,11); % save mean alveolar partial pressure of oxygen
Pa_track = zeros(1,11); % save mean arterial partial pressure of oxygen
Pv_track = zeros(1,11); % save venous partial pressure of oxygen

for i = 1:21
    beta = beta_range(i);
    setup_lung
    cvsolve
    outchecklung
    PI_track(i) = PI;
    PA_track(i) = PAbar;
    Pa_track(i) = Pabar;
    Pv_track(i) = Pv;
end

beta_pressures = [PI_track; PA_track; Pa_track; Pv_track];

figure(4)
plot(beta_range,beta_pressures)
xlabel('beta')
ylabel('Pressure (mmHg)')
title('Partial Pressures of Oxygen vs. Beta')
legend('Inspired Air','Mean Alveolar Air','Mean Arterial Blood','Venous Blood')
