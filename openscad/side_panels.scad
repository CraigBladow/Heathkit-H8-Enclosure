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
    
    
    //cube([LedgeWidth,LedgeHeight,LedgeLength],center=true);
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

module LeftPanel()
{
    union()
    {
        Panel();
        LidLedge(left);
        color("magenta")FrontPanelLedge(left);
    }
}

module FrontLeftPanel()
{
    difference()
    {
        union()
        {
            LeftPanel();
            translate([-(PanelHeight)/2+BasePlateRecess+BasePlateHeight,BaseMountWidth/2,(BaseMountLength+PanelThickness)/2])rotate([90,0,90])BaseMount();
        }
        translate([0,-PanelOverallLength/2,0]) cube([PanelHeight*2,PanelOverallLength,PanelThickness * 4],center=true);
    }
}

module RightPanel()
{
    union()
    {
        Panel();
        LidLedge(right);
        FrontPanelLedge(right);
    }
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
            
            rotate([90,0,0])
            {
                            translate([(SidePinLength-SidePinSnapBumpLength)/2,0,(SidePinXY+SidePinSnapBumpHeight)/2]) cube([SidePinSnapBumpLength+SidePinTol,SidePinXY+SidePinTol,SidePinSnapBumpHeight+SidePinTol],center=true);
            translate([(SidePinLength-SidePinSnapBumpLength)/2,0,-(SidePinXY+SidePinSnapBumpHeight)/2]) cube([SidePinSnapBumpLength+SidePinTol,SidePinXY+SidePinTol,SidePinSnapBumpHeight+SidePinTol],center=true);
            translate([-(SidePinLength-SidePinSnapBumpLength)/2,0,(SidePinXY+SidePinSnapBumpHeight)/2]) cube([SidePinSnapBumpLength+SidePinTol,SidePinXY+SidePinTol,SidePinSnapBumpHeight+SidePinTol],center=true);
            translate([-(SidePinLength-SidePinSnapBumpLength)/2,0,-(SidePinXY+SidePinSnapBumpHeight)/2]) cube([SidePinSnapBumpLength+SidePinTol,SidePinXY+SidePinTol,SidePinSnapBumpHeight+SidePinTol],center=true);
            
            }
        }

}

// Tabs that are attached to the side panel to attach it to the Base Plate
// todo: round corners / fillet all edges
module BaseMount()
{
    difference()
    {
        translate([0,0,BaseMountFilletRadius*2+BaseMountThickness/2])cube([BaseMountWidth,BaseMountLength, BaseMountFilletRadius*4 + BaseMountThickness],center = true);
        
       translate([0,-BaseMountFilletRadius/2,BaseMountFilletRadius+BaseMountThickness/2])hull()
        {
            translate([0,0,BaseMountFilletRadius*2+BaseMountThickness])cube([BaseMountWidth,BaseMountFilletRadius*2,BaseMountFilletRadius*2],center = true);
            translate([0,BaseMountLength-BaseMountFilletRadius/2,BaseMountFilletRadius*2+BaseMountThickness])cube([BaseMountWidth,BaseMountFilletRadius*2,BaseMountFilletRadius*2],center = true);
            translate([0,BaseMountLength-BaseMountFilletRadius/2,0])cube([BaseMountWidth,BaseMountFilletRadius*2,BaseMountFilletRadius*2],center = true);
    
            translate([0,0,0])rotate([0,90,0])cylinder(h = BaseMountWidth, r = BaseMountFilletRadius,center = true);
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


// test for inter and mounting tab dimensions
difference()
{
   $fn = 128;
    FrontLeftPanel();
        translate([0,PanelOverallLength/2+BaseMountWidth,0]) cube([PanelHeight*2,PanelOverallLength,PanelThickness * 4],center=true);
    translate([0,BaseMountWidth/2,(PanelThickness-Insert_6_32_hole_depth)/2])Insert_IUB_632_2();
}
