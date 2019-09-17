%Basic Drag Equation Sebastian Gonzales
function Drag = BasicDrag(rho, Velocity, CD, S)
%Inputs: 
%rho = air density
%Velocity = Velocity
%CD = Drag Coefficient
%S = Theoretical Wing Area
    Drag = (1/2)*rho*(Velocity.^2)*CD*S;
end
