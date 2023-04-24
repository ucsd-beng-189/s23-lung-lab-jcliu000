%filename: lung.m (main program)
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;

beta = 0.5;                 % first use beta = 0.5

cstar_frac_range = 0.1:0.1:1;   % range to loop over for multiplier for cstar

cref=0.2/(22.4*(310/273));  % reference concentration of oxygen in air

PA_track = zeros(1,10);     % save mean alveolar partial pressures
cA_track = zeros(1,10);     % save mean alveolar concentrations
Pa_track = zeros(1,10);     % save mean arterial partial pressures
ca_track = zeros(1,10);     % save mean arterial concentrations
Pv_track = zeros(1,10);     % save venous partial pressures
cv_track = zeros(1,10);     % save venous concentrations


for i = 1:10                % loop for multipliers for cI
    cstar = cref*cstar_frac_range(i);
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

figure(4)   % plot pressures
plot(cref*cstar_frac_range,Pressures_track)
xlabel('Blood Oxygen Concentration at Saturation (mol/L)')
ylabel('Pressure (mmHg)')
title('Partial Pressures of Oxygen vs. Hemoglobin Content')
legend('Mean Alveolar','Mean Arterial','Venous')

figure(5)   % plot concentrations
plot(cref*cstar_frac_range,Concentrations_track)
xlabel('Blood Oxygen Concentration at Saturation (mol/L)')
ylabel('Concentration of Oxygen (mol/L)')
title('Concentrations of Oxygen vs. Hemoglobin Content')
legend('Mean Alveolar','Mean Arterial','Venous')

beta_range = 0:0.1:1;       % range to loop over for beta

for j = 1:11                % loop over beta
    beta = beta_range(j);
    cstar_frac_range = 0.1:0.1:1;   % range to loop over for multiplier for cstar
    
    cref=0.2/(22.4*(310/273));  % reference concentration of oxygen in air
    
    PA_track = zeros(1,10);     % save mean alveolar partial pressures
    cA_track = zeros(1,10);     % save mean alveolar concentrations
    Pa_track = zeros(1,10);     % save mean arterial partial pressures
    ca_track = zeros(1,10);     % save mean arterial concentrations
    Pv_track = zeros(1,10);     % save venous partial pressures
    cv_track = zeros(1,10);     % save venous concentrations
    
    
    for i = 1:10                % loop for multipliers for cI
        cstar = cref*cstar_frac_range(i);
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
    
    figure(6)   % plot pressures
    subplot(3,4,j)
    plot(cref*cstar_frac_range,Pressures_track)
    subtitle("beta = " + beta)
    legend('Mean Alveolar','Mean Arterial','Venous')
    
    figure(7)   % plot concentrations
    subplot(3,4,j)
    plot(cref*cstar_frac_range,Concentrations_track)
    subtitle("beta = " + beta)
    legend('Mean Alveolar','Mean Arterial','Venous')
end

% making things pretty for the pressures plot
fig6 = figure(6);
fig6axes = axes(fig6,'visible','off'); 
fig6axes.XLabel.Visible = 'on';
fig6axes.YLabel.Visible = 'on';
fig6axes.Title.Visible = 'on';
xlabel(fig6axes,'Blood Oxygen Concentration at Saturation (mol/L)');
ylabel(fig6axes,'Pressure (mmHg)');
title(fig6axes,'Partial Pressures of Oxygen vs. Hemoglobin Content')

% making things pretty for the concentrations plot
fig7 = figure(7);
fig7axes = axes(fig7,'visible','off'); 
fig7axes.XLabel.Visible = 'on';
fig7axes.YLabel.Visible = 'on';
fig7axes.Title.Visible = 'on';
xlabel(fig7axes,'Blood Oxygen Concentration at Saturation (mol/L)');
ylabel(fig7axes,'Concentration of Oxygen (mol/L)');
title(fig7axes,'Concentrations of Oxygen vs. Hemoglobin Content')