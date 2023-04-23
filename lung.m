%filename: lung.m (main program)
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;

beta_range = 0:0.05:1;  % range to loop over for beta

M_track = zeros(1,21);  % save M values

for i = 1:21
    beta = beta_range(i);
    for M = 0.01:0.001:0.04     % loop M values
        setup_lung
        if(Mdiff(0,r)<0)        % check to see if lung can support this level of consumption
          M_track(i) = M;
        end
    end
end

figure(4)
plot(beta_range,M_track)
xlabel('beta')
ylabel('M (moles/minute)')
title('Maximum Oxygen Consumption vs. Beta')
