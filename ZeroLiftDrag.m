%Shalom Dukhande
%function for zero lift drag coefficient
function[zerodragCoefficient]=ZeroLiftDrag(wetareaFuselage,wetareaVertTail,wetareaHorTail,wetareaWing,theoWingArea,diameterBody,lengthBody,wingThickness,verttailThick,hortailThick,avgwingChord,avgverttailChord,avghortailChord)

%wetareaFuselage = wetted area of the fuselage
%wetareaVertTail= wetted area of the vertical tail
%wetareaHorTail= wetted area of the horizontal tail
%wetareawing= wetted area of the wings
%theoWingArea= theoretical area of the wings
%diameterBody= diameter of the the fuselage body
%lengthBody= length of the fuselage body
%wingThickness= average thickness of the wings
%verttailThick= average thickness of the vertical tail
%hortailThick= average thickness of the horizontal tail
%avgwingChord = average length of the wing chord
%avgverttailChord = average length of the vertical tail chord
%avghortailChord= average length of the horizontal tail chord

%Cf values in equation
cFuselage=0.455/((log10(182000)).^2.58);
cWing=0.455/((log10(36000)).^2.58);
cTail=0.455/((log10(36000)).^2.58);
%Form Factor values in equation
ffFuselage=1+1.5*((diameterBody/lengthBody).^1.5)+7*((diameterBody/lengthBody).^3);
ffWing=1+2*(wingThickness/avgwingChord)+60*(wingThickness/avgwingChord).^4;
ffVertTail=1+2*(verttailThick/avgverttailChord)+60*(verttailThick/avgverttailChord).^4;
ffHorTail=1+2*(hortailThick/avghortailChord)+60*(hortailThick/avghortailChord).^4;
%Zero lift drag coefficient for each component
componentFuselage=(cFuselage*ffFuselage*wetareaFuselage)/theoWingArea;
componentWing=(cWing*ffWing*wetareaWing)/theoWingArea;
componentVertTail=(cTail*ffVertTail*wetareaVertTail)/theoWingArea;
componentHorTail= (cTail*ffHorTail*wetareaHorTail)/theoWingArea;
%Total zero lift drag coefficent
zerodragCoefficient=componentFuselage+componentWing+componentVertTail+componentHorTail;