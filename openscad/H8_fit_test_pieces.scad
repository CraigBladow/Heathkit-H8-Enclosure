// Heathkit H8 Computer Enclosure - Fit Test Pieces
// Generates pieces with bulk areas removed to speed up printing
// and reduce material use.  This is to check initial measurments.
// Copyright 2024 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

include <H8_parameters.scad>
include <H8_side_panels.scad>
include <H8_back_base_panels.scad>



module TestFrontLeftPanel()
{
    
    difference()
    {
        FrontLeftPanel();

        //color("magenta") linear_extrude(height=PanelThickness+10,center=true)translate([0,0,0])polygon(points=[[-60,25],[-60,150],[50,100],[50,25]],paths=[[0,1,2,3]]);
        color("magenta") linear_extrude(height=PanelThickness+10,center=true)translate([0,0,0])polygon(points=[[-50,25],[-50,140],[50,90],[50,25]],paths=[[0,1,2,3]]);
    }
}



module TestRearLeftPanel()
{
    
    difference()
    {
        RearLeftPanel();

        //color("magenta") linear_extrude(height=PanelThickness+10,center=true)polygon(points=[[-60,-25],[-60,-190],[60,-190],[60,-25]],paths=[[0,1,2,3]]);
        color("magenta") linear_extrude(height=PanelThickness+10,center=true)polygon(points=[[-50,-25],[-50,-190],[50,-190],[50,-25]],paths=[[0,1,2,3]]);
    }
}

module TestVerticalBoltHoleSize()
{
  difference(){
    cube([25,25,BasePlateHeight],center=true);
    cylinder(h=50,r=BoltHoleDiameterNo8/2,center=true);
  }
}

module TestFrontRightPanel()
{
    mirror([1,0,0]) TestFrontLeftPanel();

}

module TestRearRightPanel()
{
    mirror([1,0,0]) TestRearLeftPanel();
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
        
        //Triangle subtraction
        T=18; //width of diagonal, sort of.
        W = SidePinLength*.75;
        X1 = BasePlateWidth/2-W;
        Y1 = -(BasePlateLength/2 - BasePlateMountingRailsOffset)+W;
        X2 =W;
        Y2 = -W;      
        triangle(points =[[X1,Y1+T],[X1,Y2],[X2+T,Y2]],BasePlateHeight+5);
        triangle(points =[[X1-T,Y1],[X2,Y2-T],[X2,Y1]],BasePlateHeight+5);  
    } 
}

module triangle(points, T_Height)
{
        color("magenta") linear_extrude(height=T_Height,center=true)translate([0,0,0])polygon(points,paths=[[0,1,2]]);
}

module TestBasePlateRightRear()
{
    mirror([1,0,0])TestBasePlateLeftRear();
}

module TestBasePlateLeftFront()
{
    difference()
    {
        TestBasePlateLeft();
        translate([0,-BasePlateLength/2,0])color("magenta")cube([BasePlateWidth,BasePlateLength,BasePlateHeight*4],center = true);
        
        translate([BasePlateWidth/4,0,0])SidePinPlugSockets(BasePlateWidth/2);
        translate([0,BasePlateLength/4+BackSupportThickness,0])rotate([0,0,90])SidePinPlugSockets(BasePlateLength/2);

        
        //Triangle subtraction
        T=18; //width of diagonal, sort of.
        W = SidePinLength*.75;
        X1 = BasePlateWidth/2-W;
        Y1 = W;
        X2 =W;
        Y2 = (BasePlateLength/2 + BasePlateMountingRailsOffset)-W;;      
        triangle(points =[[X1,Y1+T],[X1,Y2],[X2+T,Y2]],BasePlateHeight*5);
        triangle(points =[[X1-T,Y1],[X2,Y2-T],[X2,Y1]],BasePlateHeight+5);  
    } 

}

module TestBasePlateRightFront()
{
    mirror([1,0,0])TestBasePlateLeftFront();
}

// Side Panel PCB mount locations
SP_MountVerticalInset = mm(7.0/16.0);
SP_MountTopBackHorizInset = mm(3.0/4.0);
SP_MountBottomBackHorizInset = mm(3.0+9.0/16.0);
SP_MountHolesOffset = mm(4.0+5.0/8.0);
SP_PCB_InsetFromCaseBack = mm(1.0); // A big guess at the moment... :)

    
    HoleDiameter = 3.8;  //PCB hole size 4.0mm, size of peg to fit into it.
    TSP_T = 2.0;
    TSP_L = 2 * SP_MountHolesOffset + 4 * (HoleDiameter+0.2);
    TSP_W = 3 * HoleDiameter;
    RowDist = SidePlanePCBHeight- 2*SP_MountVerticalInset;
    HoleOffset = HoleDiameter*2;
    DY = RowDist;
    DX = SP_MountBottomBackHorizInset-SP_MountTopBackHorizInset;
    TSP_L2 = sqrt(DY*DY+DX*DX)+4 * (HoleDiameter+0.2);

module TestPegBar()
{
        cube([TSP_L,TSP_W,TSP_T],center=true);

        translate([HoleOffset-TSP_L/2,0,TSP_T])cylinder(h=TSP_T * 2, r = HoleDiameter/2, center = true);
        translate([HoleOffset+SP_MountHolesOffset-TSP_L/2,0,TSP_T])cylinder(h=TSP_T * 2, r = HoleDiameter/2, center = true);
        translate([HoleOffset+SP_MountHolesOffset*2-TSP_L/2,0,TSP_T])cylinder(h=TSP_T * 2, r = HoleDiameter/2, center = true);
    
}

module TestSidePanelHoles1()
{
        color("lime") translate([TSP_L/2,0,0]) TestPegBar();   
}

module TestPegBar2()
{
        cube([TSP_L2,TSP_W,TSP_T],center=true);

        translate([HoleOffset-TSP_L2/2,0,TSP_T])cylinder(h=TSP_T * 2, r = HoleDiameter/2, center = true);
        translate([TSP_L2/2-HoleOffset,0,TSP_T])cylinder(h=TSP_T * 2, r = HoleDiameter/2, center = true);
        //translate([HoleOffset+SP_MountHolesOffset*2-TSP_L/2,0,TSP_T])cylinder(h=TSP_T * 2, r = HoleDiameter/2, center = true);
    
}
module TestSidePanelHoles2()
{

    union()
    {
        //translate([TSP_L/2,0,0])cube([TSP_L,TSP_W,TSP_T],center=true);
       
        //translate([HoleOffset,0,TSP_T])cylinder(h=TSP_T * 2, r = HoleDiameter/2, center = true);
        //translate([HoleOffset+SP_MountHolesOffset,0,TSP_T])cylinder(h=TSP_T * 2, r = HoleDiameter/2, center = true);
        //translate([HoleOffset+SP_MountHolesOffset*2,0,TSP_T])cylinder(h=TSP_T * 2, r = HoleDiameter/2, center = true);
        //cylinder(h=TSP_T * 2, r = HoleDiameter/2, center = true);
        //rotate([0,0,SidePlanePrimeSlopeAngle])
        translate([SP_MountBottomBackHorizInset-SP_MountTopBackHorizInset+TSP_L/2,RowDist,0])TestPegBar();

        //color("blue")translate([SP_MountBottomBackHorizInset-SP_MountTopBackHorizInset+HoleOffset+SP_MountHolesOffset,RowDist,0])
        //rotate([0,0,90-SidePlanePrimeSlopeAngle])translate([TSP_L2,0,0])
        rotate([0,0,90-SidePlanePrimeSlopeAngle])
        translate([TSP_L2/2,0,0])TestPegBar2();
    }
    
}

module TestBaseChunk()
{
  difference()
  {
    TestBasePlateRightFront();
    translate([-65,90,0])cube([220,220,60],center = true);
    translate([-100,45,0])cube([220,180,60],center = true);
    
   }
  
}
module PCBSupportTemp()
{ 
    cube([20,200,mm(1.0/8.0)],center=true);
}

$fn=128;
//TestFrontLeftPanel();
//TestFrontRightPanel();

//TestFrontRightPanel();
TestRearRightPanel();

//TestBasePlateLeftRear();
//TestBasePlateRightRear();
//TestBasePlateLeftFront();
//TestBasePlateRightFront();
//TestSidePanelHoles1();
//TestSidePanelHoles2();
//TestPegBar2();

//PCBSupportTemp();
//TestBaseChunk();





