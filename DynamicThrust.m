% Rachel Johnson Dynamic Trust Function
% Function for theoretical propeller dynamic thrust calculation
function [Thrust]=DynamicThrust(RPM,pitch,diameter,V, rho)% all the inputs are from the propeller
%% I broke up the large equation into sections
A=(rho*((pi*diameter^2)/4));
B=((RPM*pitch*(1/60))^2);
C=((RPM*pitch*(1/60))*V);%V is the freestream velocity vector that we will input
D=((diameter/(3.29546*pitch))^1.5);
%% Calculations
inner=B-C;  
Thrust=A*inner*D;% Answer will be a plotted as a function of V
end