// Heathkit H8 Computer Enclosure - Fit Test Pieces
// Generates pieces with bulk areas removed to speed up printing
// and reduce material use.  This is to check initial measurments.
// Copyright 2023 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

include <H8_parameters.scad>



module BasePlate(BP_Width)
{
    cube([BasePlateWidth,BasePlateLength,BasePlateHeight],center=true);
}

module BackSupport()
{
        cube([BasePlateWidth,BackSupportThickness,BackSupportHeight],center=true);   
}

module NewBackSupport()
{
    union()
    {
        cube([BasePlateWidth,BackSupportThickness,BackSupportHeight],center=true); 
        cube([BasePlateWidth,BackSupportThickness,BackSupportHeight],center=true)
        cube([],center=true);
    }   
}





//$fn=128;
//BackSupport();



