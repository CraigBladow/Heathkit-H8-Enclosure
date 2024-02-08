// Heathkit H8 Computer Enclosure - Parameters and Functions
// Copyright 2024 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

include <H8_parameters.scad>


module Card()
{
    color("lime") cube([CardPCB_Length,PCB_Thickness,CardPCB_Height],center=true);
}

module Cards()
{
    union()
    {
        for( i = [ 1 : CardsNumberToModel])
        {
            deltaY = -1.0 * (i-1)*CardPCB_Spacing;
            //echo(deltaY = inch(deltaY));
            translate([0,deltaY,]) rotate([alpha,0,0]) Card();
        }
    }
}


module SidePanel()
{
    
    difference()
    {
        
        color("lime") translate([0,0,-SidePlanePCBHeight/2])rotate([90,0,90])
            linear_extrude(PCB_Thickness,center=true) polygon(points=[[0,0],[0,SidePlanePCBHeight],[SidePlanePCBTopEdgeLength,SidePlanePCBHeight],[SidePlanePCBBottomEdgeLength,0]]);
        HoleTest();
    }
}

//echo(CardPCB_FirstOffsetFromFront = inch(CardPCB_FirstOffsetFromFront));

module PCB_Assembly()
{
    translate([CardPCB_Length/2+CardToSidePlaneGap+PCB_Thickness/2,-CardPCB_FirstOffsetFromFront+(SidePlanePCBTopEdgeLength+SidePlanePCBBottomEdgeLength)/2,0]) Cards();
    SidePanel();    
}



/*
T_Z = SidePlanePCBHeight/2 - SP_MountVerticalInset; // top row Z 
B_Z = -T_Z; // bottom row Z
TY_R = SP_MountTopBackHorizInset; //top rear Y
TY_M = TY_R + SP_MountHolesOffset; //top middle Y
TY_F = TY_M + SP_MountHolesOffset; //top front Y
BY_R = SP_MountBottomBackHorizInset; //top rear Y
BY_M = BY_R + SP_MountHolesOffset; //top middle Y
BY_F = BY_M + SP_MountHolesOffset; //top front Y

SP_MountLocations = [[0,TY_R,T_Z],[0,TY_M,T_Z],[0,TY_F,T_Z],[0,BY_R,B_Z],[0,BY_M,B_Z],[0,BY_F,B_Z]]; // [ Y, Z],..
*/
module HoleTest()  // make some holes
{
    for(i = SP_MountLocations)
    {
        translate(i) rotate([0,90,0])cylinder(h=10,r = 2, center = true);
    }
    
}

A = SidePlanePCBHeight;
B = SidePlanePCBBottomEdgeLength - SidePlanePCBTopEdgeLength;
C = sqrt(A*A+B*B);
//echo(A= A,B= B,Ccacl= C,SPFE= SidePlanePCBFrontEdgeLength);
alpha = atan(B/A);
beta = atan(A/B);
//echo(alpha = alpha, beta= beta);

//PCB_Assembly();
//$fn = 32;
//SidePanel();
//color("orange") HoleTest();

