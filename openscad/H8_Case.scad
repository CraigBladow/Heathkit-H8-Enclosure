// Heathkit H8 Computer Enclosure
// Copyright 2023 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

// TO DO LIST:
// Confirm side panel dimensions and shape (current values are just placehodlers).
// Separate into two pieces for printing
// Modify edge to add alignment structure for the two pieces
// Add insert locations for ataching to back, bottom and front panels
// Right side add insert locations to support side plane PC mounting

$fn = 128; // Rendering setting
include <H8_parameters.scad>
include <side_panels.scad>

module BasePlate()
{
    cube([BasePlateWidth,BasePlateLength,BasePlateHeight],center=true);
}

module H8Case()
{
    rotate([0,-90,0])union(){
    color("Magenta") Panel();
    color("Lime") translate([0,0,BasePlateWidth+PanelThickness/2])rotate([0,0,0])Panel();
    translate([-(PanelHeight/2)+BasePlateHeight,0,BasePlateWidth/2+PanelThickness/2])rotate([0,90,0])color("Orange") BasePlate();
    }
}

//H8Case();
Panel();