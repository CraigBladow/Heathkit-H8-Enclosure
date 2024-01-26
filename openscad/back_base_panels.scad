// Heathkit H8 Computer Enclosure - Back and Base panel modules
// Copyright 2024 Craig Bladow
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

module BasePlate()
{
    union()
    {
        difference()
        {
        cube([BasePlateWidth,BasePlateLength,BasePlateHeight],center=true);
        color("lime")rotate([0,90,0])BasePlateBoltHoles();
        }
        BaseFeet();
        
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
//aseFootTopDiameter = mm(0.75);
//BaseFootBottomDiameter = mm(0.5);
//BaseFootHeight = mm(0.5);
module BaseFoot()
{
    cylinder(h = BaseFootHeight, r1 = BaseFootBottomDiameter/2,r2 = BaseFootTopDiameter/2,  center = true);
}

module BaseFeet()
{
    BaseFootOffsetX = BasePlateWidth/2 - BaseMountLength - BaseFootTopDiameter;
    BaseFootOffsetY = BasePlateLength/2 - BaseFootTopDiameter;
    BaseFootOffsetZ = -BasePlateHeight/2-BaseFootHeight/2;
    translate([BaseFootOffsetX,BaseFootOffsetY,BaseFootOffsetZ])BaseFoot();
    translate([-BaseFootOffsetX,BaseFootOffsetY,BaseFootOffsetZ])BaseFoot();
    translate([BaseFootOffsetX,-BaseFootOffsetY,BaseFootOffsetZ])BaseFoot();
    translate([-BaseFootOffsetX,-BaseFootOffsetY,BaseFootOffsetZ])BaseFoot();

    
    BoltClearanceY_Offset1 = -WasherRecessDiameterTopNo8+BackSupportThickness/2-BasePlateMountingRailsOffset;
    BoltClearanceY_Offset2 = WasherRecessDiameterTopNo8+BackSupportThickness/2-BasePlateMountingRailsOffset;  
    
    BaseFootOffsetX1 = BaseFootTopDiameter;
    BaseFootOffsetYY = -BasePlateMountingRailsOffset+BackSupportThickness/2;
    BaseFootOffsetY1 = BaseFootOffsetYY+BaseFootTopDiameter;
    BaseFootOffsetY2 = BaseFootOffsetYY-BaseFootTopDiameter;
    BaseFootOffsetY3 = BaseFootOffsetYY-BaseFootTopDiameter;
    BaseFootOffsetY4 = BaseFootOffsetYY+BaseFootTopDiameter;
    translate([BaseFootOffsetX1,BaseFootOffsetY1,BaseFootOffsetZ])BaseFoot();
    translate([-BaseFootOffsetX1,BaseFootOffsetY2,BaseFootOffsetZ])BaseFoot();
    translate([BaseFootOffsetX1,BaseFootOffsetY3,BaseFootOffsetZ])BaseFoot();
    translate([-BaseFootOffsetX1,BaseFootOffsetY4,BaseFootOffsetZ])BaseFoot();
}



//$fn=128;
//BackSupport();
//LeftBackSupport();
//RightBackSupport();
//BasePlate();
//color("magenta") BaseFoot();







