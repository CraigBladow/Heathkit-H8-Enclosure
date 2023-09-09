// Heathkit H8 Computer Enclosure - Parameters and Functions
// Copyright 2023 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

// Common Constants
left = 1.0;
right = -1.0;

//All measurements in inches converted to mm
function mm(x) = x * 25.4;  //convert inches to mm

// Case Dimension
CaseWidth = mm(16.0);

// Front Panel Dimensions
FP_PCB_Length = mm(14.75);
FP_PCB_Height = mm(5.75);
SidePlanePCBHeight = mm(5.5);
SidePlanePCBTopEdgeLength = mm(11.125);
SidePlanePCBBottomEdgeLength = mm(13.25);
SidePlanePCBFrontEdgeLength = mm(6.25);
PCB_Thickness = 1.6; //mm
CardPCB_Length = mm(12.0);
CardPCB_Height = mm(6.0);
CardToSidePlaneGap = mm(3.0/16.0);

// Front Panel Ledge (temporary)
FP_LedgeLength = mm(4);
FP_LedgeWidth = mm(0.08);
FP_LedgeHeight = mm(0.121);
FP_LedgeAngle = 58.15; //degrees
FP_LedgeRecess = mm(2.5);
FP_LedgeOffset = mm(0.0);


// Side Panel overall dimensions in inches.
PanelHeight = mm(6.25); //NCCP 6.1375
PanelCornerRadius = mm(0.125);
PanelOverallLength = mm(17);
PanelFrontBottomRecessHeight = mm(0.5);
PanelFrontBottomRecessLength = mm(0.5);
PanelTopLength = mm(14.0);
PanelThickness = mm(0.5);

// Lid support
LedgeRecess = mm(0.27);
LedgeOffset = mm(1.875);
LedgeWidth = mm(0.05);
LedgeHeight = mm(0.125);
LedgeLength = mm(10.7);

// Side Panel Base Plate Dado 
DadoDepth = mm(0.0);

// Base Plate dimensions
BasePlateWidth = CaseWidth - 2 * PanelThickness - DadoDepth;
BasePlateLength = mm(16.0); //Not verified
BasePlateHeight = 9.0; //Baltic Birch Plywood 9mm


