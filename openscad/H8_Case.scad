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



rotate([0,-90,0])union(){
color("Magenta") Panel();
color("Lime") translate([0,0,mm(16.0)])rotate([0,0,0])Panel();
}