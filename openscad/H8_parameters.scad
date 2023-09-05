// Heathkit H8 Computer Enclosure - Parameters and Functions
// Copyright 2023 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

//All measurements in inches converted to mm
function mm(x) = x * 25.4;  //convert inches to mm

// Case Dimension
CaseWidth = mm(16.0);

// Front Panel Dimensions
FP_PCBLLength = mm(14.75);

// Side Panel overall dimensions in inches.
PanelHeight = mm(6.25);
PanelCornerRadius = mm(0.125);
PanelOverallLength = mm(17.0);
PanelFrontBottomRecessHeight = mm(1.0);
PanelFrontBottomRecessLength = mm(0.5);
PanelTopLength = mm(14.0);
PanelThickness = mm(0.5);

// Side Panel Base Plate Dado 
DadoDepth = mm(0.0);

// Base Plate dimensions
BasePlateWidth = CaseWidth - 2 * PanelThickness - DadoDepth;
BasePlateLength = mm(15.0); //Not verified
BasePlateHeight = mm(0.375);

