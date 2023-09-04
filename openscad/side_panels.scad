// Heathkit H8 Computer Enclosure - Side Panels
// Copyright 2023 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

// TO DO LIST:
// Confirm side panel dimensions and shape (current values are just placehodlers).
// Separate into two pieces for printing
// Modify edge to add alignment structure for the two pieces
// Add insert locations for ataching to back, bottom and front panels
// Right side add insert locations to support side plane PC mounting

$fn = 128; // Rendering setting

//All measurements in inches converted to mm
function mm(x) = x * 25.4;  //convert inches to mm

// Panel overall dimensions in inches.
PanelHeight = mm(6.5);
PanelCornerRadius = mm(0.25);
PanelOverallLength = mm(17.0);
PanelFrontBottomRecessHeight = mm(1.0);
PanelFrontBottomRecessLength = mm(0.5);
PanelTopLength = mm(15.0);
PanelThickness = mm(0.75);

//Panel Modules
module RoundedEdge(thickness, radius)
{
    rotate([0,0,0])cylinder(h=thickness, r = radius, center = true);
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

rotate([0,-90,0])union(){
color("Magenta") Panel();
color("Lime") translate([0,0,mm(16.0)])rotate([0,0,0])Panel();
}