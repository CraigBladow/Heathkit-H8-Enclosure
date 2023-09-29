// Heathkit H8 Computer Enclosure
// Copyright 2023 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

// TO DO LIST:
// DONE: Trial joining two pieces with square 3d printed pins
// DONE: Separate left side panel into two pieces for printing
// DONE: Add rails to left side panel for attaching to baseplate
// Add tabs to left side panel for attaching back panel pieces.
// Add tabs to right side panel for baseplate and back panel connections.
// Add tabs to right side panel for attaching back panel pieces.
// Determine the H8 Front panel slope and adjust side panel edge slope and front panel alignment ridge on side panel.
// Add front panel PCB support bracket to left/right panels
// Add insert locations for ataching to front panel
// Right side - add insert locations to support side plane PC mounting

$fn = 128; // Rendering setting
include <H8_parameters.scad>
include <side_panels.scad>

module BackSupport()
{
    cube([BasePlateWidth,BackSupportThickness,BackSupportHeight],center=true);    
}


module BasePlate()
{
    cube([BasePlateWidth,BasePlateLength,BasePlateHeight],center=true);
}

module H8Case()
{
    rotate([0,-90,0])union(){
        echo(left= left);
        color("Magenta") LeftPanel();
        color("Lime") translate([0,0,BasePlateWidth+PanelThickness])rotate([0,0,0])RightPanel();
        translate([-(PanelHeight/2)+BasePlateHeight/2,-(PanelOverallLength-BasePlateLength)/2,BasePlateWidth/2+PanelThickness/2])rotate([0,90,0])color("Orange") BasePlate();
        translate([PanelHeight/2-BackSupportHeight/2,-BasePlateLength/2-BackSupportThickness/2,BasePlateWidth/2+PanelThickness/2]) rotate([0,90,0])BackSupport();
        translate([-(PanelHeight/2-BackSupportHeight/2),-BasePlateLength/2-BackSupportThickness/2,BasePlateWidth/2+PanelThickness/2]) rotate([0,90,0])BackSupport();
    }
}

//H8Case();
//SidePinSnap();
//TestFrontLeftSidePanelSubSection();
//TestRearLeftSidePanelSubSection();
