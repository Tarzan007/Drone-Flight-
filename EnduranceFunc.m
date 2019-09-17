function[endurance]=EnduranceFunc(D,V)
%E is the energy available from the battery, which is found my multiplying the amps by
%the voltage 
%Eta is the efficiency of the propeller and motor
%D is the drag force for the maximum speed 
%V is the maximum speed 
Eta=0.8;
E=11.1*0.8;
endurance=(E*Eta)/(D*V);

