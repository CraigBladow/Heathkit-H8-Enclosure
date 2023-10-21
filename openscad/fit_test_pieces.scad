// Heathkit H8 Computer Enclosure - Fit Test Pieces
// Generates pieces with bulk areas removed to speed up printing
// and reduce material use.  This is to check initial measurments.
// Copyright 2023 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

include <H8_parameters.scad>
include <side_panels.scad>



module TestFrontLeftPanel()
{
    
    difference()
    {
        FrontLeftPanel();

        color("magenta") linear_extrude(height=PanelThickness+10,center=true)translate([0,0,0])polygon(points=[[-60,25],[-60,150],[50,100],[50,25]],paths=[[0,1,2,3]]);
    }
}




$fn=128;
TestFrontLeftPanel();
