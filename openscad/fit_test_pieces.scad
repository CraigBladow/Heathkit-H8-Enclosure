// Heathkit H8 Computer Enclosure - Fit Test Pieces
// Generates pieces with bulk areas removed to speed up printing
// and reduce material use.  This is to check initial measurments.
// Copyright 2023 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

include <H8_parameters.scad>
include <side_panels.scad>
include <back_base_panels.scad>



module TestFrontLeftPanel()
{
    
    difference()
    {
        FrontLeftPanel();

        color("magenta") linear_extrude(height=PanelThickness+10,center=true)translate([0,0,0])polygon(points=[[-60,25],[-60,150],[50,100],[50,25]],paths=[[0,1,2,3]]);
    }
}

module TestRearLeftPanel()
{
    
    difference()
    {
        RearLeftPanel();

        color("magenta") linear_extrude(height=PanelThickness+10,center=true)polygon(points=[[-60,-25],[-60,-190],[60,-190],[60,-25]],paths=[[0,1,2,3]]);
    }
}

module TestVerticalBoltHoleSize()
{
  difference(){
    cube([25,25,BasePlateHeight],center=true);
    cylinder(h=50,r=BoltHoleDiameterNo8/2,center=true);
  }
}

module SidePinFitTest()
{
    rotate([90,0,0])difference()
    {
        union()
        {
            
            cube([SidePinLength, SidePinXY, SidePinXY], center=true);
            // Add snap bumps
            
            rotate([90,0,0])
            {
                translate([-SidePinXY,0,0])la_bosse();
                translate([SidePinXY,0,0])la_bosse();
                translate([-SidePinXY*2,0,0])la_bosse();
                translate([SidePinXY*2,0,0])la_bosse();
                translate([-SidePinXY*3,0,0])la_bosse();
                translate([SidePinXY*3,0,0])la_bosse();
                translate([-SidePinXY*3.8,0,0])la_bosse();
                translate([SidePinXY*3.8,0,0])la_bosse();
            }
            
        }
        // create gap
        translate([(SidePinLength-SidePinSnapGapLength)/2,0,0])cube([SidePinSnapGapLength,SidePinXY,SidePinSnapGapWidth],center=true);
        translate([-(SidePinLength-SidePinSnapGapLength)/2,0,0])cube([SidePinSnapGapLength,SidePinXY,SidePinSnapGapWidth],center=true);
    }
}
module TwelveSidePinFitTest()
{
        translate([-7*15/2,0,0])for(i = [1 : 6])translate([(i*15),0,0])rotate([0,0,90])SidePinFitTest();
                translate([-7*15/2,45,0])for(i = [1 : 6])translate([(i*15),0,0])rotate([0,0,90])SidePinFitTest();
}

module TestBasePlateLeft()
{
    difference()
    {
        translate([0,BasePlateMountingRailsOffset-BackSupportThickness/2,0])BasePlate();
        translate([-BasePlateWidth/2,0,0])cube([BasePlateWidth,BasePlateLength*2,BasePlateHeight*4],center=true);
    }
    
}

module TestBasePlateLeftRear()
{
    difference()
    {
        TestBasePlateLeft();
        translate([0,BasePlateLength/2,0])color("magenta")cube([BasePlateWidth,BasePlateLength,BasePlateHeight*4],center = true);
        translate([BasePlateWidth/4,0])SidePinPlugSockets(BasePlateWidth/2);
        translate([0,-BasePlateLength/4-BackSupportThickness,0])rotate([0,0,90])SidePinPlugSockets(BasePlateLength/2);
    } 
}

module triangle(points, T_Height)
{
        color("magenta") linear_extrude(height=T_Height,center=true)translate([0,0,0])polygon(points,paths=[[0,1,2]]);
}



$fn=16;
//SidePinFitTest();
//TwelveSidePinFitTest();
//mirror([0,1,0])TestFrontLeftPanel();
//mirror([0,1,0])TestRearLeftPanel();
//TestRearLeftPanel();
//TestVerticalBoltHoleSize();
//TestBasePlateLeft();
TestBasePlateLeftRear();
W = SidePinLength*.75;
T = 8;
X1 = BasePlateWidth/2-W;
Y1 = -(BasePlateLength/2 - BasePlateMountingRailsOffset)+W +T;
X2 =X1;
Y2 = -W;
X3 = W+T;
Y3 = Y2;
triangle(points =[[X1,Y1],[X2,Y2],[X3,Y3]],BasePlateHeight+5);
X4 = X1-T;
Y4 = -(BasePlateLength/2 - BasePlateMountingRailsOffset)+W;
X5 = X3;
Y5 = Y4; //Y2 - T;
X6 = X5;
Y6 = -W-T;
triangle(points =[[X4,Y4],[X5,Y5],[X6,Y6]],BasePlateHeight+5);
echo(W = W);
echo(SidePinLength = SidePinLength);
echo(X1 = X1);
echo(Y1=Y1);
echo(BasePlateWidth = BasePlateWidth);


