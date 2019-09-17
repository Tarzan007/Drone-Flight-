%Range Equation
function [Range] = RangeEquation(MBatt, DroneMass, Drag, DroneWeight)
E = .36; %MJ/kg  This is the battery specific energy assuming the prototype battery provided
g = 9.81; %meters per second squared 
EtaTotal = 0.8;
Range = E*(MBatt/DroneMass)*(1/g)*(DroneWeight/Drag)*(EtaTotal); 
