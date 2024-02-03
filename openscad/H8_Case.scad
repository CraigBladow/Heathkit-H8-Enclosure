// Heathkit H8 Computer Enclosure
// Copyright 2024 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

// Notes:
// Clean out bolt holes on side panels by hand with 11/64 inch drill bit.
// When slicing Side and Back Panels, add support enforcers, tool type 'smart fill', to only place support for the vertical mounting holes. Support is not needed for the snap pin holes and likely not completely removable.
// Intended base plate material is 9mm Baltic Birch.  There is a 3D model of the base plate in the project which was created to help confirm measurements. It may be used but may not be as sturdy.

// TO DO LIST:
// DONE: Trial joining two pieces with square 3d printed pins
// DONE: Separate left side panel into two pieces for printing
// DONE: Add rails to left side panel for attaching to baseplate
// DONE: Add tabs to left side panel for attaching back panel pieces.
// DONE: Align back panel top support rail to lid ledge heigth
// DONE: Align base plate rail to initial position
// DONE:Align base plate and back supports to match left side panel.
// DONE: Create initial front panel PCB bracket
// DONE: Add holes for #8 bolts and recesses for washers to side panel mounting rails.
// DONE: Calculate Front Panel supports slope angle from side panel parameters.
// DONE: Determine the H8 Front panel slope and adjust side panel edge slope and front panel alignment ridge on side panel.
// DONE: Shorten base plate and fix bolt hole locations in base mount rail.
// DONE: Add washer imprints to bottom side panel rails.
// DONE: Print front panel PCB Bracket and check measurements.
// DONE: Add holes to base plate model
// DONE:  Add feet to Base Plate Model
// DONE: Section Base Plate Model for fit test
// DONE: Create 3D printed base plate for fit testing (so only need to cut one piece of wood) :)
// DONE: Model and test use of flathead screws for base plate mounting.
// DONE: Update the following measurements based on input from TS: Lid support ledge Inset 0.25 inch.
// DONE Update PrimeSlopeAngle to match side panel pcb slope of 29.6 degrees
// DONE Organize note on original case dimensions and calculaote prime slope angle
// DONE: PrimeSlopeAngle = atan((PanelOverallLength-PanelTopLength)/ (PanelHeight-PanelFrontBottomRecessHeight))
// DONE: Calculate top front corner position (PanelTopLength) using prime slope angle and PanelOverallLength, PanelFrontBottomRecessHeight, PanelHeight
// DONE:   PanelTopLength = PanelOverallLength - tan(PrimeSlopeAngle)*(PanelHeight - PanelFrontBottomRecessHeight;)
// DONE: Add calculation of vertical stackup and emit result
// DONE: Increase case height by 0.35 inches.
// DONE: Calculate UnderSlopeAngle, adjust PanelFrontBottomRecessHeight, PanelFrontBottomRecessLength to match.
// DONE: Locate FP support ledge Inset is 1.0 inch. DeltaY = mm(1.0)*COS(PrimeSlopeAmgle);
// DONE: Add calculation of FP support ledge offset
// DONE: Revise Panel() to use offset() to round corners vs. using hull() which introduces errors on leading edges of case sides.
// Add calculation of front to back stackup and emit result
// FP support ledge Inset is 1.0 inch. DeltaY = mm(1.0)*COS(PrimeSlopeAmgle);
// Calculate case side bottom length from SideFrontEdgeLowerAngle.
// Left and Right side - add insert locations (see module PCB_InsertMountPoints() ) to support side plane PC mounting and test fit. 
// Ensure room for MicroATX power supply
// Print Right side of case to check 

// Add fillet to front panel PCB Bracket backside and attach to side panel just behind fp ledge
// Create back panel structure in two 3D printed pieces with two openings for attaching 3D printed sub-panels. Panel is 9mm thick at ends and <= 12.7mm in middle and snaps together
// Create Card PCB bracket printed replacement solution since bolts come up through bottom
// Card PCB mounting holes in bottom are elongated in the original case
// Create Front Panel in two or more 3D printed pieces.
// Possibly implement orange peel/ powder coated texture for front case panel.
// Create a badge. see https://github.com/prusa3d/PrusaSlicer/issues/4455 for texture. 
// Create a sub-frame that can be used as a drill guide for the bottom plate. (Or not if using plastic base)
// Determine Lid solution, if acrylic note that cast acrylic should sag less.

$fn = 128; // Rendering setting
include <H8_parameters.scad>
include <side_panels.scad>
include <back_base_panels.scad>

module H8Case()
{
    rotate([0,-90,0])union(){
        
        color("Magenta") LeftPanel();
        color("Lime") translate([0,0,BasePlateWidth+PanelThickness])RightPanel();
    
    
        translate([-(PanelHeight/2)+BasePlateHeight/2+BasePlateRecess,BasePlateOffset,BasePlateWidth/2+PanelThickness/2])rotate([0,90,0])color("Orange") BasePlate();
        
    BackSupportOffset = -PanelOverallLength/2+BackSupportThickness/2+BackPanelRecess;    
       translate([-BackPanelRailsOffset,BackSupportOffset,BasePlateWidth/2+PanelThickness/2]) rotate([0,90,0])BackSupport();
    }
}

module LeftPanelExplodedAssembly()
{

    translate([0,35,0])FrontLeftPanel();
    translate([0,-35,0])RearLeftPanel();

    for(i = [1 : PanelSocketsNumber])translate([(i*PanelHeight/PanelSocketsNumber)-PanelHeight/2-PanelHeight/(2*PanelSocketsNumber),0,0])rotate([(i-0)*90+45+90,0,90])SidePinSnap();
}

module SixSnapPins()
{
        translate([-7*15/2,0,0])for(i = [1 : 6])translate([(i*15),0,0])rotate([0,0,90])SidePinSnap();
}

H8Case();

//LeftPanelExplodedAssembly();
//mirror([0,1,0])LeftPanel();
//FrontPCB_Bracket();
//SixSnapPins();
//SidePinSnap();

// Spacers / washers if needed
//washers(16, mm(3/8),BoltHoleDiameterNo6,mm(1/16));



//TestFrontLeftSidePanelSubSection();
//TestRearLeftSidePanelSubSection();
