// Heathkit H8 Computer Enclosure - Parameters and Functions
// Copyright 2024 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

include <H8_parameters.scad>


module Card()
{
    color("lime") cube([CardPCB_Length,PCB_Thickness,CardPCB_Height],center=true);
}

module SidePanel()
{
    color("lime") translate([0,0,-SidePlanePCBHeight/2])rotate([90,0,90])linear_extrude(PCB_Thickness,center=true) polygon(points=[[0,0],[0,SidePlanePCBHeight],[SidePlanePCBTopEdgeLength,SidePlanePCBHeight],[SidePlanePCBBottomEdgeLength,0]]);
}



module PCB_Assembly()
{
    translate([CardPCB_Length/2+CardToSidePlaneGap+PCB_Thickness/2,(SidePlanePCBTopEdgeLength+SidePlanePCBBottomEdgeLength)/2,0])rotate([alpha,0,0])Card();
    SidePanel();    
}

module HoleTest()
{
    
}

A = SidePlanePCBHeight;
B = SidePlanePCBBottomEdgeLength - SidePlanePCBTopEdgeLength;
C = sqrt(A*A+B*B);
echo(A= A,B= B,Ccacl= C,SPFE= SidePlanePCBFrontEdgeLength);
alpha = atan(B/A);
beta = atan(A/B);
echo(alpha = alpha, beta= beta);

PCB_Assembly();

