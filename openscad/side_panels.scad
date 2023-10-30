// Heathkit H8 Computer Enclosure - Side Panels
// Copyright 2023 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

include <H8_parameters.scad>

//Panel Modules
module RoundedEdge(thickness, radius)
{
    rotate([0,0,0])cylinder(h=thickness, r = radius, center = true);
}

module Ledge(L,H,R)
{
    hull()
    {
        translate([0,L/2-R/2,0])cylinder(H,R,R,center=true);
        translate([0,-(L/2-R/2),0])cylinder(H,R,R,center=true);
    }
}

module LidLedge(side)
{
    color("lime")translate([PanelHeight/2-LedgeHeight/2-LedgeRecess,-LedgeOffset,side*(PanelThickness/2+LedgeWidth/2)])rotate([0,0,0]) Ledge(LedgeLength,LedgeWidth,LedgeHeight/2);
}
module FrontPanelLedge(side)
{
    translate([FP_LedgeOffset,PanelOverallLength/2-FP_LedgeRecess,side*(PanelThickness/2+FP_LedgeWidth/2)])rotate([0,0,FP_LedgeAngle]) Ledge(FP_LedgeLength,FP_LedgeWidth,FP_LedgeHeight/2);
}

module Panel()
{
    hull()
    {
        translate([-PanelHeight/2+PanelCornerRadius,-PanelOverallLength/2+PanelCornerRadius,0])RoundedEdge(PanelThickness,PanelCornerRadius);  // lower rear corner
        translate([PanelHeight/2-PanelCornerRadius,-PanelOverallLength/2+PanelCornerRadius,0])RoundedEdge(PanelThickness,PanelCornerRadius);  // upper rear corner
        translate([-PanelHeight/2+PanelCornerRadius+PanelFrontBottomRecessHeight,PanelOverallLength/2-PanelCornerRadius,0])RoundedEdge(PanelThickness,PanelCornerRadius);  // lower front corner (not bottom)
        translate([-PanelHeight/2+PanelCornerRadius,PanelOverallLength/2-PanelCornerRadius-PanelFrontBottomRecessLength,0])RoundedEdge(PanelThickness,PanelCornerRadius);  // bottom front corner (recessed)
        translate([PanelHeight/2-PanelCornerRadius,PanelTopLength-PanelOverallLength/2-PanelCornerRadius,0])RoundedEdge(PanelThickness,PanelCornerRadius);  // upper front corner

    }
}

module BackPanelBoltHoles()
{
    BoltClearanceY_Offset = 0;
    BoltClearanceX_Offset1 = BackPanelMountLength/2 -WasherRecessDiameterTopNo8;
    BoltClearanceX_Offset2 = -BoltClearanceX_Offset1;
    BoltClearanceZ_Offset = -(BackPanelThickness+BaseMountThickness+0)/2+WasherEmbossDepth;

    color("Magenta")translate([BoltClearanceX_Offset1,BoltClearanceY_Offset,BoltClearanceZ_Offset])rotate([180,0,0])BoltWasherHoleNo8();
    color("Magenta")translate([BoltClearanceX_Offset2,BoltClearanceY_Offset,BoltClearanceZ_Offset])rotate([180,0,0])BoltWasherHoleNo8();
}

module BackPanelRails()
{ 
    difference(){
       // Back panel mounting rails

        translate([-BackPanelRailsOffset,-PanelOverallLength/2+BasePlateHeight/2+BackPanelRecess,PanelThickness/2+BaseMountLength/2])rotate([90,0,0])
       difference(){ 
            PanelMount(BackPanelMountLength);
            BackPanelBoltHoles();
        }
       // remove excess fillet on bottom    
       translate([0,-PanelOverallLength/2-PanelThickness*2,0])cube([PanelHeight,PanelThickness*4,PanelThickness*4],center=true);
    }

}

BasePlateMountingRailsOffset = -(PanelOverallLength-BaseMountWidth)/2 +(BackPanelRecess+BackSupportThickness);
//echo(BasePlateMountingRailsOffset = BasePlateMountingRailsOffset);
   
module BasePlateMountingRailBoltHoles()
{
    BoltClearanceX_Offset = -PanelHeight/2+BasePlateRecess+BasePlateHeight+BaseMountThickness/2-WasherEmbossDepth;
    BoltClearanceY_Offset1 = -WasherRecessDiameterTopNo8;
    BoltClearanceY_Offset2 = -BoltClearanceY_Offset1;
    BoltClearanceY_Offset3 = BaseMountWidth/2-WasherRecessDiameterTopNo8 + BasePlateMountingRailsOffset;
    BoltClearanceY_Offset4 = -BaseMountWidth/2 + WasherRecessDiameterTopNo8 + BasePlateMountingRailsOffset;//-BoltClearanceY_Offset3;
    
    color("Magenta")translate([BoltClearanceX_Offset,BoltClearanceY_Offset1,PanelThickness/2+BaseMountLength/2])rotate([0,90,0])BoltWasherHoleNo8();
    color("Magenta")translate([BoltClearanceX_Offset,BoltClearanceY_Offset2,PanelThickness/2+BaseMountLength/2])rotate([0,90,0])BoltWasherHoleNo8();
    color("Magenta")translate([BoltClearanceX_Offset,BoltClearanceY_Offset3,PanelThickness/2+BaseMountLength/2])rotate([0,90,0])BoltWasherHoleNo8();
    color("Magenta")translate([BoltClearanceX_Offset,BoltClearanceY_Offset4,PanelThickness/2+BaseMountLength/2])rotate([0,90,0])BoltWasherHoleNo8();    
    
}

module BasePlateMountingRails()
{

    difference(){   
            
        translate([-PanelHeight/2+BasePlateHeight/2+BasePlateRecess,BasePlateMountingRailsOffset,PanelThickness/2+BaseMountLength/2])rotate([90,0,90]) PanelMount(BaseMountWidth);

        // remove excess fillet on bottom    
        translate([-PanelHeight/2-PanelThickness*2,0,0])color("lime")cube([PanelThickness*4,PanelOverallLength,PanelThickness*4],center=true);
        
       BasePlateMountingRailBoltHoles(); 
                        
    }
}

module LeftPanel()
{
    union()
    {
        Panel();
        LidLedge(left);
        FrontPanelLedge(left);
        BackPanelRails();
        BasePlateMountingRails();

    }
}


module PanelMount(PM_Width)
{
        translate([0,0,BasePlateHeight/2])BaseMount(PM_Width);
        translate([0,0,-BasePlateHeight/2])rotate([180,0,180])BaseMount(PM_Width);
}

module FrontLeftPanel()
{
    difference()
    {
        LeftPanel();
        
        // Remove other half of left panel
        translate([0,-PanelOverallLength/2,0]) cube([PanelHeight*2,PanelOverallLength,PanelThickness * 4],center=true);
        // Make Sockets for pins
        SidePinPlugSockets(PanelHeight);
    }
}

module RearLeftPanel()
{
    difference()
    {
        LeftPanel();
            
        // Remove other half of left panel
        translate([0,PanelOverallLength/2,0]) cube([PanelHeight*2,PanelOverallLength,PanelThickness * 4],center=true);
        // Make sockets for pins
        SidePinPlugSockets(PanelHeight);
    }
}

module RightPanel()
{
    rotate([180,0,0])mirror([0,1,0])LeftPanel();
/*
    union()
    {
        Panel();
        LidLedge(right);
        FrontPanelLedge(right);
    }
 */
}

module Insert_IUB_632_2()
{
    union()
    {
        translate([0,0,Insert_6_32_taper_length/2])cylinder(h = Insert_6_32_taper_length, r1 = Insert_6_32_bottom_dia/2,r2 = Insert_6_32_opening_dia/2, center = true); 
        translate([0,0,-(Insert_6_32_hole_depth - Insert_6_32_taper_length)/2])cylinder(h = (Insert_6_32_hole_depth - Insert_6_32_taper_length), r = Insert_6_32_bottom_dia/2, center = true);
        
    }
}


module SidePinSnap()
{
    rotate([90,0,0])difference()
    {
        union()
        {
            
            cube([SidePinLength, SidePinXY, SidePinXY], center=true);
            // Add snap bumps
            translate([(SidePinLength-SidePinSnapBumpLength)/2,0,(SidePinXY+SidePinSnapBumpHeight)/2]) cube([SidePinSnapBumpLength,SidePinXY,SidePinSnapBumpHeight],center=true);
            translate([(SidePinLength-SidePinSnapBumpLength)/2,0,-(SidePinXY+SidePinSnapBumpHeight)/2]) cube([SidePinSnapBumpLength,SidePinXY,SidePinSnapBumpHeight],center=true);
            translate([-(SidePinLength-SidePinSnapBumpLength)/2,0,(SidePinXY+SidePinSnapBumpHeight)/2]) cube([SidePinSnapBumpLength,SidePinXY,SidePinSnapBumpHeight],center=true);
            translate([-(SidePinLength-SidePinSnapBumpLength)/2,0,-(SidePinXY+SidePinSnapBumpHeight)/2]) cube([SidePinSnapBumpLength,SidePinXY,SidePinSnapBumpHeight],center=true);
            rotate([90,0,0])
            {
                translate([-SidePinXY,0,0])la_bosse();
                translate([SidePinXY,0,0])la_bosse();
            }
            
        }
        // create gap
        translate([(SidePinLength-SidePinSnapGapLength)/2,0,0])cube([SidePinSnapGapLength,SidePinXY,SidePinSnapGapWidth],center=true);
        translate([-(SidePinLength-SidePinSnapGapLength)/2,0,0])cube([SidePinSnapGapLength,SidePinXY,SidePinSnapGapWidth],center=true);
    }
}

module SidePin()
{
    cube([SidePinLength, SidePinXY, SidePinXY], center=true);
}

module SidePinSocket()
{
    cube([SidePinLength + SidePinTol, SidePinXY + SidePinTol, SidePinXY + SidePinTol], center=true);
}

module SidePinPlugSockets(SockePanelLength)
{
    for(i = [1 : PanelSocketsNumber])translate([(i*SockePanelLength/PanelSocketsNumber)-SockePanelLength/2-SockePanelLength/(2*PanelSocketsNumber),0,0])rotate([(i-0)*90+45,0,90])SidePinPlugSocket();
}


module la_bosse()  // a bump
{
        cube([0.8,SidePinXY + SidePinTol, SidePinXY],center=true);
}



module SidePinPlugSocket()
{

        union()
        {
            
            cube([SidePinLength+SidePinTol, SidePinXY+SidePinTol, SidePinXY+SidePinTol], center=true);
            // Add snap bumps
            translate([(SidePinLength-SidePinSnapBumpLength)/2,0,(SidePinXY+SidePinSnapBumpHeight)/2]) cube([SidePinSnapBumpLength+SidePinTol,SidePinXY+SidePinTol,SidePinSnapBumpHeight+SidePinTol],center=true);
            translate([(SidePinLength-SidePinSnapBumpLength)/2,0,-(SidePinXY+SidePinSnapBumpHeight)/2]) cube([SidePinSnapBumpLength+SidePinTol,SidePinXY+SidePinTol,SidePinSnapBumpHeight+SidePinTol],center=true);
            translate([-(SidePinLength-SidePinSnapBumpLength)/2,0,(SidePinXY+SidePinSnapBumpHeight)/2]) cube([SidePinSnapBumpLength+SidePinTol,SidePinXY+SidePinTol,SidePinSnapBumpHeight+SidePinTol],center=true);
            translate([-(SidePinLength-SidePinSnapBumpLength)/2,0,-(SidePinXY+SidePinSnapBumpHeight)/2]) cube([SidePinSnapBumpLength+SidePinTol,SidePinXY+SidePinTol,SidePinSnapBumpHeight+SidePinTol],center=true);
            // Add flare for pins

            hull()
            {
                rotate([0,45,0])cube([SidePinXY+SidePinTol,SidePinXY+SidePinTol,SidePinXY+SidePinTol],center=true);
                rotate([0,90,0])cube([SidePinXY+SidePinTol,SidePinXY+SidePinTol,SidePinXY+SidePinTol],center=true);
            }
            
            
            rotate([90,0,0])
            {
                            translate([(SidePinLength-SidePinSnapBumpLength)/2,0,(SidePinXY+SidePinSnapBumpHeight)/2]) cube([SidePinSnapBumpLength+SidePinTol,SidePinXY+SidePinTol,SidePinSnapBumpHeight+SidePinTol],center=true);
            translate([(SidePinLength-SidePinSnapBumpLength)/2,0,-(SidePinXY+SidePinSnapBumpHeight)/2]) cube([SidePinSnapBumpLength+SidePinTol,SidePinXY+SidePinTol,SidePinSnapBumpHeight+SidePinTol],center=true);
            translate([-(SidePinLength-SidePinSnapBumpLength)/2,0,(SidePinXY+SidePinSnapBumpHeight)/2]) cube([SidePinSnapBumpLength+SidePinTol,SidePinXY+SidePinTol,SidePinSnapBumpHeight+SidePinTol],center=true);
            translate([-(SidePinLength-SidePinSnapBumpLength)/2,0,-(SidePinXY+SidePinSnapBumpHeight)/2]) cube([SidePinSnapBumpLength+SidePinTol,SidePinXY+SidePinTol,SidePinSnapBumpHeight+SidePinTol],center=true);
            
            }
        }

}

// Rail for the side panel to attach it to the Base Plate
module BaseMount(BM_Width)
{
    difference()
    {
        translate([0,0,BaseMountFilletRadius*2+BaseMountThickness/2])cube([BM_Width,BaseMountLength, BaseMountFilletRadius*4 + BaseMountThickness],center = true);
        
       translate([0,-BaseMountFilletRadius/2,BaseMountFilletRadius+BaseMountThickness/2])hull()
        {
            translate([0,0,BaseMountFilletRadius*2+BaseMountThickness])cube([BM_Width,BaseMountFilletRadius*2,BaseMountFilletRadius*2],center = true);
            translate([0,BaseMountLength-BaseMountFilletRadius/2,BaseMountFilletRadius*2+BaseMountThickness])cube([BM_Width,BaseMountFilletRadius*2,BaseMountFilletRadius*2],center = true);
            translate([0,BaseMountLength-BaseMountFilletRadius/2,0])cube([BM_Width,BaseMountFilletRadius*2,BaseMountFilletRadius*2],center = true);
    
            translate([0,0,0])rotate([0,90,0])cylinder(h = BM_Width, r = BaseMountFilletRadius,center = true);
        }
    }
    
}


module TestSocket()
{
    difference()
    {
        cube([SidePinLength/2,2*SidePinXY,2*SidePinXY],center=true);
        rotate([45,0,0])SidePinSocket();
    }
}

module TestPlugSocket()
{
    difference()
    {
        cube([SidePinLength,2*SidePinXY,PanelThickness],center=true);
        //translate([SidePinLength/2+SidePinTol,0,0])
        translate([-SidePinLength/2,0,0])rotate([45,0,0])SidePinPlugSocket();
    }
}


// test for inner and mounting tab dimensions
module TestFrontLeftSidePanelSubSection()
{
    $fn = 128;
    difference()
    {
        
        FrontLeftPanel();
        //translate([0,BaseMountWidth/2,(PanelThickness-Insert_6_32_hole_depth)/2])Insert_IUB_632_2();
        color("lime")translate([0,PanelOverallLength/2+mm(1.0),0]) cube([PanelHeight*2,PanelOverallLength,PanelThickness * 4],center=true);
    }

}

module TestRearLeftSidePanelSubSection()
{
    $fn = 128;
    difference()
    {
        
        RearLeftPanel(); //translate([0,BaseMountWidth/2,(PanelThickness-Insert_6_32_hole_depth)/2])Insert_IUB_632_2();
        color("lime")translate([0,-PanelOverallLength/2-mm(1.0),0]) cube([PanelHeight*2,PanelOverallLength,PanelThickness * 4],center=true);
    }

}



// The short piece attaches to the front panel PCB
module FrontPCB_Bracket()
{
    union()
    {
        color( "magenta" ) translate([0,0,FPB_Thickness/2]) cube([FPB_LengthLong,FPB_LengthLongWidth,FPB_Thickness],center=true);
        
            translate([0,-FPB_LengthLongWidth/2-FPB_Thickness/2,FPB_LengthShortWidth/2]) rotate([90,0,0]) difference()
        {
            cube([FPB_LengthShort,FPB_LengthShortWidth,FPB_Thickness],center=true);
            translate([FPB_HoleSpacing/2,FPB_HoleOffset,0]) cylinder(h=FPB_Thickness * 2, r = FPB_HoleDiameter/2, center=true);
            translate([-FPB_HoleSpacing/2,FPB_HoleOffset,0]) cylinder(h=FPB_Thickness * 2, r = FPB_HoleDiameter/2, center=true);
        }
        
    }
}

module BoltWasherHoleNo8()
{
    union()
    {
        translate([0,0,-BoltLength3_4/2])cylinder(h = BoltLength3_4, r = BoltHoleDiameterNo8/2, center=true);
        translate([0,0,WasherRecessHeightNo8/2]) cylinder(h = WasherRecessHeightNo8, r1 = WasherRecessDiameterBottomNo8/2, r2 = WasherRecessDiameterTopNo8/2, center = true);
        translate([0,0,-BasePlateHeight-BaseMountThickness]) rotate([0,180,0])cylinder(h = WasherRecessHeightNo8, r1 = WasherRecessDiameterBottomNo8/2, r2 = WasherRecessDiameterTopNo8/2, center = true);
    }
    //WasherRecessHeightNo8/2-15
}
//$fn=128;
//$fn=64;
//LeftPanel();
//BackPanelRails();
//BasePlateMountingRails();
//BoltWasherHoleNo8();







 
