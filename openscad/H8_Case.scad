// Heathkit H8 Computer Enclosure
// Copyright 2023 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

// Notes:
// Clean out bolt holes on side panels by hand with 11/64 inch drill bit.
// When slicing Side and Back Panels, add support enforcers, tool type 'smart fill', to only place support for the vertical mounting holes. Support is not needed for the snap pin holes and likely not completely removable.
// Intended base plate material is 9mm Baltic Birch.  There is a 3D model of the base plate in the project which was created to help confirm measurements.

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
// Add washer imprints to bottom side panel rails.
// Print front panel PCB Bracket and check measurements.
// Add fillet to front panel PCB Bracket backside and attach to side panel just behind fp ledge
// Add insert locations for ataching to front panel to left side panel.
// Create back panel structure in two 3D printed pieces with two openings for attaching 3D printed sub-panels. Panel is 9mm thick at ends and <= 12.7mm in middle and snaps together
// Add tabs to right side panel for baseplate and back panel connections.
// Add tabs to right side panel for attaching back panel pieces.
// Add bracket to right side panel
// Right side - add insert locations to support side plane PC mounting.
// Create 3D printed base plate for fit testing (so only need to cut one piece of wood) :)
// Create Front Panel in two or more 3D printed pieces.
// Create a sub-frame that can be used as a drill guide for the bottom plate.
// Determin Lid solution, if acrylic note that cast acrylic should sag less.

$fn = 128; // Rendering setting
include <H8_parameters.scad>
include <side_panels.scad>

module BackSupport()
{
    cube([BasePlateWidth,BackSupportThickness,BackSupportHeight],center=true);    
}


module BasePlate(BP_Width)
{
    cube([BasePlateWidth,BasePlateLength,BasePlateHeight],center=true);
}

module H8Case()
{
    rotate([0,-90,0])union(){
        echo(left= left);
        color("Magenta") LeftPanel();
        color("Lime") translate([0,0,BasePlateWidth+PanelThickness])RightPanel();
    
    BasePlateOffset = -(PanelOverallLength-BasePlateLength)/2+BackPanelRecess; 
        translate([-(PanelHeight/2)+BasePlateHeight/2+BasePlateRecess,BasePlateOffset,BasePlateWidth/2+PanelThickness/2])rotate([0,90,0])color("Orange") BasePlate();
        
    BackSupportOffset = -PanelOverallLength/2+BackSupportThickness/2+BackPanelRecess;    
        translate([PanelHeight/2-BackSupportHeight/2-LedgeRecess,BackSupportOffset,BasePlateWidth/2+PanelThickness/2]) rotate([0,90,0])BackSupport();
        
       translate([-(PanelHeight/2-BackSupportHeight/2)+BasePlateHeight+BasePlateRecess,BackSupportOffset,BasePlateWidth/2+PanelThickness/2]) rotate([0,90,0])BackSupport();
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



//TestFrontLeftSidePanelSubSection();
//TestRearLeftSidePanelSubSection();
