// Heathkit H8 Computer Enclosure - Back and Base panel modules
// Copyright 2023 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

include <H8_parameters.scad>
include <side_panels.scad>



module BasePlate(BP_Width)
{
    cube([BasePlateWidth,BasePlateLength,BasePlateHeight],center=true);
}

module BackSupport()
{
    difference()
    {
        cube([BasePlateWidth,BackSupportThickness,BackPanelHeight],center=true); 
        translate([BasePlateWidth/2-BackPanelBoltInset,0,0])rotate([90,90,0])BackPanelBoltHoles();
        translate([-BasePlateWidth/2+BackPanelBoltInset,0,0])rotate([90,90,0])BackPanelBoltHoles();
        
    }   
}





$fn=128;
BackSupport();



