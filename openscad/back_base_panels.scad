// Heathkit H8 Computer Enclosure - Back and Base panel modules
// Copyright 2023 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

include <H8_parameters.scad>
include <side_panels.scad>

module BasePlateBoltHoleSet(BPB_Offset)
{
    BoltClearanceX_Offset = BoltLength3_4/2-WasherRecessHeightNo8;
    BoltClearanceY_Offset1 = -WasherRecessDiameterTopNo8+BackSupportThickness/2-BasePlateMountingRailsOffset;
    BoltClearanceY_Offset2 = WasherRecessDiameterTopNo8+BackSupportThickness/2-BasePlateMountingRailsOffset;  
    BoltClearanceY_Offset3 = BasePlateLength/2-WasherRecessDiameterTopNo8;

    BoltClearanceY_Offset4 = -BasePlateLength/2 + WasherRecessDiameterTopNo8 + BackSupportThickness;
    
    color("Magenta")translate([BoltClearanceX_Offset,BoltClearanceY_Offset1,BPB_Offset])rotate([0,90,0])BoltWasherHoleNo8();
    color("Magenta")translate([BoltClearanceX_Offset,BoltClearanceY_Offset2,BPB_Offset])rotate([0,90,0])BoltWasherHoleNo8();
    color("Magenta")translate([BoltClearanceX_Offset,BoltClearanceY_Offset3,BPB_Offset])rotate([0,90,0])BoltWasherHoleNo8();
    color("Magenta")translate([BoltClearanceX_Offset,BoltClearanceY_Offset4,BPB_Offset])rotate([0,90,0])BoltWasherHoleNo8();  

}

module BasePlateBoltHoles()
{
    BoltClearanceZ_Offset = BasePlateWidth/2-BaseMountLength/2;
    BasePlateBoltHoleSet(BoltClearanceZ_Offset);
    BasePlateBoltHoleSet(-BoltClearanceZ_Offset);   
}     

module BasePlate(BP_Width)
{
    //union()
    difference()
    {
    cube([BasePlateWidth,BasePlateLength,BasePlateHeight],center=true);
    color("lime")rotate([0,90,0])BasePlateBoltHoles();
    }
}
module LeftBackSupport()
{
    difference()
    {
        BackSupport();
        translate([BasePlateWidth/4,0,0])cube([BasePlateWidth/2,BackSupportThickness,BackPanelHeight],center=true);
                color("lime")translate([-BasePlateWidth/4-SidePinLength/4,0,0])cube([BasePlateWidth/2-SidePinLength/2,BackSupportThickness,BackPanelHeight/1.5],center=true);
    }
            
}
module RightBackSupport()
{
    mirror([1,0,0]) LeftBackSupport();      
}

module BackSupport()
{

    difference()
    {
        cube([BasePlateWidth,BackSupportThickness,BackPanelHeight],center=true); 
        translate([BasePlateWidth/2-BackPanelBoltInset,0,0])rotate([90,90,0])BackPanelBoltHoles();
        translate([-BasePlateWidth/2+BackPanelBoltInset,0,0])rotate([90,90,0])BackPanelBoltHoles();
        
        rotate([90,90,0])SidePinPlugSockets(BackPanelHeight);
        
    }   
}



//$fn=128;
//BackSupport();
//LeftBackSupport();
//RightBackSupport();
//BasePlate();





