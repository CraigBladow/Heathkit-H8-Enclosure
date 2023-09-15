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
    translate([PanelHeight/2-LedgeHeight/2-LedgeRecess,-LedgeOffset,side*(PanelThickness/2+LedgeHeight/2)])rotate([0,0,0]) Ledge(LedgeLength,LedgeWidth,LedgeHeight/2);
    
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


BaseMount();
//LeftPanel();
//Ledge(250,8,4);
