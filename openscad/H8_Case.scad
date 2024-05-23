// Heathkit H8 Computer Enclosure
// Copyright 2024 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

// Notes:
// Clean out bolt holes on side panels by hand with 11/64 inch drill bit.
// When slicing Side and Back Panels, add support enforcers, tool type 'smart fill', to only place support for the vertical mounting holes. Support is not needed for the snap pin holes and likely not completely removable. Print with a Brim to reduce lifting. 
// Prints with 0.4 mm nozzle / 0.2 mm quality layer or 0.6 mm / 0.3 mm quality layer.
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
// DONE: Model PCB card assembly with case model. 
// DONE Model Power Supply
// DONE: Left and Right side - add insert locations (see module PCB_InsertMountPoints() ) to support side plane PC mounting and test fit. Need to locate the insert holes.
// DONE: Calculate case side bottom recess length from SideFrontEdgeLowerAngle.
// DONE: Create 0.15 mm gap in side halves to see if assembly is better.
// DONE: Test with 0.8 mm nozzle - result - snap pins don't work
// DONE: Remove 3 layer gap for top layer swelling compensation, also gap in lid ledge
// DONE:Remove 3 layer gap for top layer swelling compensation, also gap in lid ledg
// DONE: Printed with 15% infill.
// DONE: Printed with brim to reduce lifting of corners near print bed edge.

// DONE: Design 3 point test prints to confirm PCB mount locations
// DONE: PCB mount up 2 mm (DONE manually) and extend case height by 2.54 mm. Look at SP_PCB_HeightFromCaseBottom which was not used in calculating the PCB vertical offset but SP_MountHolesVerticalOffset was used.
// DONE: Move side plane PCB back by 0.25" to attain > 0.25" clearance from FP PCB
// DONE: In progress: design sliding FP PCB bracket

// In Progress: Determine and finalize FP PCB bracket mount locations see FP_MountLocations in H8_parameters.scad.
// Add Front Panel insets in side panels
// Add Front Panel mounting holes in base plate
// Add fillet to front panel PCB Bracket backside and attach to side panel just behind fp ledge

// Print Right side of case with 0.6 mm nozzle and no 0.15 mm gap to confirm fit and PCB mount locations

// Create back panel structure in two 3D printed pieces with two openings for attaching 3D printed sub-panels. Panel is 9mm thick at ends and <= 12.7mm in middle and snaps together
// Add Power supply mount in back panel
// Add cable pass throughs to back panel.
// Card PCB mounting holes in bottom are elongated in the original case
// Create Front Panel in two or more 3D printed pieces.
// Locate the badge in FP.
//Create a badge. see https://github.com/prusa3d/PrusaSlicer/issues/4455 for texture. 
// Create a sub-frame that can be used as a drill guide for the bottom plate. (Or not if using plastic base)
// Determine Lid solution, if acrylic note that cast acrylic should sag less.

$fn = 128; // Rendering setting
include <H8_parameters.scad>
include <H8_side_panels.scad>
include <H8_back_base_panels.scad>
include <H8_PCB_Assembly.scad>


module PowerSupply()
{
    color("Red") cube([PS_Width,PS_Length,PS_Height],center=true);
}


module H8Case()
{
    rotate([0,-90,0])union(){
        
        color("Magenta") LeftPanel();
        color("Red") translate([0,0,BasePlateWidth+PanelThickness])RightPanel();
    
    
        translate([-(PanelHeight/2)+BasePlateHeight/2+BasePlateRecess,BasePlateOffset,BasePlateWidth/2+PanelThickness/2])rotate([0,90,0])color("Orange") BasePlate();
        
    BackSupportOffset = -PanelOverallLength/2+BackSupportThickness/2+BackPanelRecess;    
       translate([-BackPanelRailsOffset,BackSupportOffset,BasePlateWidth/2+PanelThickness/2]) rotate([0,90,0])BackSupport();
        
    }
    // PCB Assembly
    translate([-PanelThickness/2-BasePlateWidth+PCB_Thickness/2+SP_PCB_StandOffHeight,-BasePlateLength/2,-(PanelHeight/2 - SidePlanePCBHeight/2)+(BasePlateHeight+BasePlateRecess)+SP_PCB_HeightFromCaseBottom])PCB_Assembly();
    // Power Supply
    translate([-(BaseMountLength+PS_Width/2+PanelThickness/2),PS_Length/2-PanelOverallLength/2+(BasePlateHeight+BasePlateRecess),-(PanelHeight/2 - PS_Height/2)+(BasePlateHeight+BasePlateRecess)+PS_Lift])PowerSupply();
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

//H8Case();

//LeftPanelExplodedAssembly();

//SixSnapPins();
//SidePinSnap();

// Spacers / washers if needed
//washers(16, mm(3/8),BoltHoleDiameterNo6,mm(1/16));

//TestFrontLeftSidePanelSubSection();
//TestRearLeftSidePanelSubSection();

//FrontRightPanel();
//RearRightPanel();

//FrontPCB_Bracket();
