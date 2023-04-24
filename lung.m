%filename: lung.m (main program)
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;

cstar_range = 0.1:0.1:1;        % range of cstar multipliers to loop over

for j = 1:10
    cI_frac_range = 0.1:0.1:2;  % range to loop over for multiplier for cI

    cref=0.2/(22.4*(310/273));  % reference concentration of oxygen in air

    cstar = cref*cstar_range(j);% cstar value
    
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
    subplot(3,4,j)
    plot(elevation,Pressures_track)
    subtitle("cstar = " + cstar)
    legend('Mean Alveolar','Mean Arterial','Venous')
    
    figure(5)   % plot concentrations
    subplot(3,4,j)
    plot(elevation,Concentrations_track)
    subtitle("cstar = " + cstar)
    legend('Mean Alveolar','Mean Arterial','Venous')
end

% making things pretty for the pressures plot
fig4 = figure(4);
fig4axes = axes(fig4,'visible','off'); 
fig4axes.XLabel.Visible = 'on';
fig4axes.YLabel.Visible = 'on';
fig4axes.Title.Visible = 'on';
xlabel(fig4axes,'Blood Oxygen Concentration at Saturation (mol/L)');
ylabel(fig4axes,'Pressure (mmHg)');
title(fig4axes,'Partial Pressures of Oxygen vs. Elevation')

% making things pretty for the concentrations plot
fig5 = figure(5);
fig5axes = axes(fig5,'visible','off'); 
fig5axes.XLabel.Visible = 'on';
fig5axes.YLabel.Visible = 'on';
fig5axes.Title.Visible = 'on';
xlabel(fig5axes,'Blood Oxygen Concentration at Saturation (mol/L)');
ylabel(fig5axes,'Concentration of Oxygen (mol/L)');
title(fig5axes,'Concentrations of Oxygen vs. Elevation')