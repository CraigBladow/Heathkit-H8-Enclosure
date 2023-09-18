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

// Side Panel Base Plate Recess , how much the side panel extends below the bottom of the base plate
BasePlateRecess = mm(0.125);

// Base Plate dimensions
BasePlateWidth = CaseWidth - 2 * PanelThickness;
BasePlateLength = mm(16.0); //Not verified
BasePlateHeight = 9.0; //Baltic Birch Plywood 9mm

// Back Support Dimensions, 2 instances are needed
BackSupportThickness = BasePlateHeight;
BackSupportHeight = mm(1.0);

// Fasteners
Screw_Hole_Tol = 0.1; // mm
Screw_6_32x1_4_dia = mm(0.138) + Screw_Hole_Tol;
Screw_6_32x1_4_len = mm(0.25) + Screw_Hole_Tol;

Insert_6_32_hole_depth = mm(0.29) + mm(0.005);
Insert_6_32_opening_dia = mm(0.206) + mm(0.002);
Insert_6_32_bottom_dia = mm(0.185) + mm(0.002);
Insert_6_32_taper_length = mm(0.150);

// Mounting Tabs
BaseMountWidth = mm(0.75);
BaseMountLength = mm(0.6);
BaseMountThickness = mm(0.2);
BaseMountFilletRadius = mm(0.2);

// SidePanel Pin
SidePinLength = mm(1.6);
SidePinXY = mm(0.2);
SidePinTol = mm(0.01);
SidePinSnapGapWidth = SidePinXY * 0.4;
SidePinSnapGapLength = SidePinXY * 1.2;
SidePinSnapBumpHeight = (SidePinXY-SidePinSnapGapWidth) / 3;
SidePinSnapBumpLength = (SidePinXY-SidePinSnapGapWidth) / 2;



