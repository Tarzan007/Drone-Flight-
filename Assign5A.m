%13952  Team 10 4/3/2019

%The purpose of this program will be to calculate the aerodynamic drag and 
%dynamic thrust of our prototype design when given the geometrics inputs. 
%This program will plot the thrust and drag functions as well as deliver
%the maximum velocity the prototype can fly at, the endurance of the
%prototype, and the range of the prototype.

clc;clear
fprintf(['Please input the geometry of your drone design to calculate\n',... 
    'the aerodynamic drag and dynamic thrust of your design.\n',...
    'Units should be in Meters and Newtons.\n'])  
disp('--------------------------------------------------')
%% Input Of Parameters
WingArea = input('Wing Theoretical Area: ');
WingSpan = input('Wing Span: ');
WetAreaWing = input('Wetted Area of the Wing: ');
WetAreaFuselage = input('Wetted Area of the Fuselage: ');
WetAreaVertTail = input('Wetted Area of the Vertical Tail: ');
WetAreaHorTail = input('Wetted Area of the Horizontal Tail: ');
FuselageDia = input('Fuselage Average Diameter: ' );
FuselageLength = input('Fuselage Overall Length: ');
AveWingThicc = input('Average Wing Thickness: ');
AveVertTailThicc = input('Average Vertical Tail Thickness: ');
AveHorTailThicc = input('Average Horizontal Tail Thickness: ');
AveWinChordLength = input('Average Wing Chord Length: ');
AveVertTailChordLength = input('Average Vertical Tail Chord Length: ');
AveHorTailChordLength = input('Average Horizontal Tail Chord Length: ');
DroneWeight = input('Drone Weight: ');
BMass = input('Battery Mass: ');
%% Conditions:  
%Creating Velocity Vector that come in increments of .001
Velocity = (0:.001:30); 
%% Constants 
AirDen = 1.134; %Air Density (rho)(May change on location)
RPM = 15000; %Rotations per minutes of the propeler 
pitch = 0.0762; %Pitch of propeller
proDia = 0.1524; %Propeller diameter
DroneMass = DroneWeight/(9.81); %Drone Total Mass, May Move some where else
%% Creating Thrust Vecotor For Plot
%Functions Used: Dynamic Thrust
for i = 1:length(Velocity)
    %Dynamic Thrust Equation
    Thrust = DynamicThrust(RPM, pitch, proDia, Velocity(i), AirDen);
    %Storing each value in thrust vector
    ThrustVector(i) = Thrust;
end
%% Creating Drag Vector For Plot 
%Functions Used: Induced Drag & Zero Lif Drag & Total Drag
%ZeroLiftDragCoefficient 
ZeroDragCoefficient = ZeroLiftDrag(WetAreaFuselage, WetAreaVertTail, WetAreaHorTail ...
    ,WetAreaWing ,WingArea, FuselageDia, FuselageLength, AveWingThicc, AveVertTailThicc...
    , AveHorTailThicc, AveWinChordLength, AveVertTailChordLength, AveHorTailChordLength);
for x = 1:length(Velocity)
    %Induced Drag Equation 
    InducedDrag = InducedDragC(WingSpan, DroneWeight, WingArea, AirDen, Velocity(x));
    %Calculating Total Drag Coefficient 
    DragCoefficient = InducedDrag + ZeroDragCoefficient;
    %Basic Drag Equation
    Drag = BasicDrag(AirDen, Velocity(x), DragCoefficient, WingArea);   
    %Storing each value in drag vector
    DragVector(x) = Drag;
end
%% Finding Optimal Velocity
%Calculating the differences between the two vector componenents
DifferenceVector = abs(DragVector - ThrustVector);
%For loop to find the right-most value where the two lines intersect
for j = 1:length(Velocity)
    %Checks where the greateset velocity is less than .0001 and 
    %determines this as the rightmost intersection on the graph
    if (.0001 > DifferenceVector(j))        
        SmallestIndex = j;
    end
end
%Defining the maximum velocity drag would allow 
MaxVelocity = Velocity(SmallestIndex);
%% Endurance and Range
%Getting max drag value
MaxDrag = DragVector(SmallestIndex);
%Range Function
Range = RangeEquation(BMass, DroneMass, MaxDrag, DroneWeight) * 1000; %1000 fixes MJ
%Endurance Equation
Endurance = EnduranceFunc(MaxDrag, MaxVelocity);
%% Plotting 
%Ploting both drag and thrust as a function of time in different colors
plot(Velocity, ThrustVector, 'b', Velocity, DragVector, 'r')
hold on
grid on
%Creating x, y, and title labels
xlabel('Speed (m/s)');
ylabel('Force (N)');
title('Plot of Thrust & Drag vs. Speed of the Medical Drone Prototype') 
%Plotting point of intersection on graph
plot(MaxVelocity, ThrustVector(SmallestIndex), 'O')
%Creating legend for plot
legend('Thrust', 'Drag', 'Maximum Speed')
axis([0 30 -5 30]);

%% Creating Table Containing Parameters
%Creating the paramers and inputs of the table
Parameters = {'Overall Fuselage Length(m)'; 'Drone Total Weight(N)' ...
    ;'Wing Theoretical Area(m^2)'; 'Wing Span(m)'; 'Average Fuselage Diameter(m)'};
Values = [FuselageLength; DroneWeight; WingArea; WingSpan; FuselageDia];
%Setting up table but not displaying it
Table = table(Parameters, Values);
%Displaying Table of inputs
disp('--------------------------------------------------')
disp(Table)
disp('--------------------------------------------------')
fprintf(['Max velocity only occurs at the second intersection of the\n',...
    'Thrust & Drag vs. Speed of the Medical Drone Prototype plot.\n'])
%Creating statements for fprintf
VelocityResult = 'Maximum Velocity(m/s): %0.3f\nEndurance(hours): %0.3f\nRange(km): %0.3f\n';
%Creating the variables that come along with the fprintf statements
Variable = [MaxVelocity, Endurance, Range];
%Displaying results 
fprintf(VelocityResult, Variable)
%% Entering Experimental Values
%Inputting experimental Velocity 
ExpVelocity = input('Please input experimental velocity: ');
%% Endurance and Range for ExpVelocity
%Finding index of ExpVelocity and Drag from ExpVelocity
ExpIndex = find(Velocity == ExpVelocity);
ExpDrag = DragVector(ExpIndex);
%Range Function
ExpRange = RangeEquation(BMass, DroneMass, ExpDrag, DroneWeight)*1000*.00094; %1000 fixes MJ
%Endurance Equation
ExpEndurance = EnduranceFunc(ExpDrag, ExpVelocity)*.00094; %With fudge factor 
%% ExtraPlotting 
%Plotting point of intersection on graph
plot([ExpVelocity ExpVelocity], [-5 30], 'g'); %%Change bc does not take double
%Creating legend for plot
legend('Thrust', 'Drag', 'Maximum Speed', 'Actual Prototype Speed')
hold off
%% Experimental Outputs
disp('--------------------------------------------------')
%Creating statements for fprintf
VelocityResult = 'Experimental Velocity(m/s): %0.3f\nRange(km): %0.3f\n';
%Creating the variables that come along with the fprintf statements
Variable = [ExpVelocity, ExpRange];
%Displaying results 
fprintf(VelocityResult, Variable)

    


