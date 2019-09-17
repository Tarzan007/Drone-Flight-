function[IDC]=InducedDragC(b, W, S, rho, V)
%Inputs:
%b = WingSpan
%W = DroneWeight
%S = Wing Theoretical Area
%rho = air density
%V = Velocity of drone


%Constants: e is the span efficiency factor
e=0.85;

%Equation: AR is the aspect ratio
%Used Inputs: b, S
AR=((b.^2)/S);

%Equation: LiftC is lift coefficient
%Used Inputs: W, V, rho, S 
LiftC=(2*W)/(rho*(V.^2)*S);

%Equation: IDC is the induced drag coefficient (output)
%Used Inputs: LiftC, AR
IDC=((LiftC.^2)/(pi*AR*e));



