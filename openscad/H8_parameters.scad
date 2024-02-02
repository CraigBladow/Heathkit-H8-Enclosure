// Heathkit H8 Computer Enclosure - Parameters and Functions
// Copyright 2024 Craig Bladow
// Released under MIT license:
//  
//        https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE
//  Notes on actual H8 case parameters:
//      Front Panel support ledge front edge is 1" from front edge of side panels
//      Lid support ledge edge recessed 0.25"
//      Front Panel, Front PCB, Circuit Cards, Side Plane front edge are all parallel to each other.
//      Case side panel: Length 17", Height 6.1", Top Edge Length 13.875 or 13.8", Bottom Edge Length 16.6", Height 6.1", Front edge vertex Height 0.6-0.7"

// Calculate Angles from actual case dimensions so relative profile can be maintained if case depth or height changes
SideFrontEdgeUpperAngle = atan((17-13.875)/(6.1-0.6)); // Using 13.875 and 0.6 as the angle matches the sideplane circuit card angles.
echo(SideFrontEdgeUpperAngle = SideFrontEdgeUpperAngle);
SideFrontEdgeLowerAngle = atan((17-16.6)/(0.6));
echo(SideFrontEdgeLowerAngle=SideFrontEdgeLowerAngle);

// Common Constants
left = 1.0;
right = -1.0;

//All measurements in inches converted to mm or mm directly.
function mm(x) = x * 25.4;  //convert inches to mm

// Case Dimension
CaseWidth = mm(16.0);

// Front/Side Panel PCB Dimensions
FP_PCB_Length = mm(14.75);
FP_PCB_Height = mm(5.75);
SidePlanePCBHeight = mm(5.5);
SidePlanePCBTopEdgeLength = mm(11.125);
SidePlanePCBBottomEdgeLength = mm(14.25);
SidePlanePCBFrontEdgeLength = mm(6.52);
PCB_Thickness = 1.6; //mm
CardPCB_Length = mm(12.0);
CardPCB_Height = mm(6.0);
CardPCP_Spacing = mm(1.0+5.0/32.0);
CardToSidePlaneGap = mm(3.0/16.0);
SidePlanePrimeSlopeAngle = atan((SidePlanePCBBottomEdgeLength - SidePlanePCBTopEdgeLength)/SidePlanePCBHeight);
echo(SidePlanePrimeSlopeAngle = SidePlanePrimeSlopeAngle);

// Side Panel PCB mount locations
SP_MountVerticalInset = mm(7.0/16.0);
SP_MountTopBackHorizInset = mm(3.0/4.0);
SP_MountBottomBackHorizInset = mm(3.0+9.0/16.0);
SP_MountHolesOffset = mm(4.0+5.0/8.0);
SP_PCB_InsetFromCaseBack = mm(1.0); // A big guess at the moment... :)
SP_PCB_HeightFromCaseBottom = mm(1.0/8.0); //Mk 1 estimate
SP_PCB_HeightFromLedgeRecess = mm(1.0/8.0); //Mk 1 estimate
SP_PCB_StandOffHeight = 6.5; //mm

// Side Panel overall dimensions in inches.
PanelHeight = mm(6.6); //Old 6.25 /NCCP 6.1375
PanelCornerRadius = mm(0.125);
PanelOverallLength = mm(17);
PanelFrontBottomRecessHeight = mm(0.6); // was 0.5
PanelFrontBottomRecessLength = mm(0.4); // was 0.5
PanelThickness = mm(0.5);
PanelSocketsNumber = 6;

// Calculate PanelTopLength
//PanelTopLength = mm(13.73);
PanelTopLength = PanelOverallLength - tan(SideFrontEdgeUpperAngle)*(PanelHeight - PanelFrontBottomRecessHeight);
echo(PanelTopLength = PanelTopLength/25.4 , "inches");

//Find the angle for to base front panel ledge and bracket on
// Todo - use side panel dimensions,also adjusting the Panel dimensions currently used.
PrimeSlopeAngle = atan((PanelOverallLength-PanelTopLength)/(PanelHeight-PanelFrontBottomRecessHeight));
echo(PrimeSlopeAngle = PrimeSlopeAngle);
// Front Panel Ledge
FP_LedgeLength = mm(4.0);
FP_LedgeWidth = mm(0.08);   // how far the ledge sticks out
FP_LedgeHeight = mm(0.125);
FP_LedgeAngle = 90.0 - SidePlanePrimeSlopeAngle; 
echo (FP_LedgeAngle = FP_LedgeAngle);
FP_LedgeRecess = mm(2.5);
FP_LedgeOffsetVertical = mm(0.0);

// Lid support
LedgeRecess = mm(0.25); // Distance from side panel top edge to top of ledge
LedgeOffset = mm(1.875); 
LedgeWidth = mm(0.125);  // Horizontal dimension, was 0.05
LedgeHeight = mm(0.125); // Vertical height of ledge
LedgeLength = mm(10.7);

// Side Panel Base Plate and Back Panel Recess , how much the side panel extends below the bottom of the base plate
BasePlateRecess = mm(0.125);
BackPanelRecess = BasePlateRecess;

// Base Plate dimensions
BasePlateWidth = CaseWidth - 2 * PanelThickness;
BasePlateLength = mm(15); //Not verified
BasePlateHeight = 9.0; //mm Baltic Birch Plywood
BasePlateOffset = -(PanelOverallLength-BasePlateLength)/2+BackPanelRecess; 

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


// SidePanel Pin
SidePinLength = mm(1.6);
SidePinXY = mm(0.2);
SidePinTol = mm(0.01);
SidePinSnapGapWidth = SidePinXY * 0.4;
SidePinSnapGapLength = SidePinXY * 1.2;
SidePinSnapBumpHeight = (SidePinXY-SidePinSnapGapWidth) / 3;
SidePinSnapBumpLength = (SidePinXY-SidePinSnapGapWidth) / 2;

// Card and Top Bracket
CardBracketWidth = 14; // mm
CardBracketThickness = 1.54; //mm
CardBracketLength = mm(6.25);
CardBrackeTabLength = mm(0.625);
CardBracketCardHoleDia = 3.6; //mm
CardBracketCardHoleSpacing = mm(4.0);
CardBracketTabCornerRadius = mm(0.1);

// Base Plate Mounting Rails
BaseMountThickness = mm(0.2);
BaseMountWidth = BasePlateLength-(BackSupportThickness);
BaseMountLength = mm(0.6);
BaseMountFilletRadius = mm(0.2);

//Back Panel
BackPanelHeight = PanelHeight-LedgeRecess-BasePlateHeight-BasePlateRecess;
BackPanelMountLength = BackPanelHeight;
BackPanelRailsOffset = (LedgeRecess-BasePlateHeight-BasePlateRecess)/2;
BackPanelThickness = BasePlateHeight;
BackPanelBoltInset = BaseMountLength/2; 

// FrontPanel Support Bracket
// Front PCB support Bracket
FPB_LengthLong = mm(4.5);
FPB_LengthLongWidth = mm(0.5);
FPB_LengthShortWidth = mm(0.5+1/6);
FPB_LengthShort = mm(3.75);
FPB_Thickness = mm(1/16);
FPB_HoleSpacing = mm(3.0);
FPB_HoleDiameter = mm(0.165);
FPB_HoleOffset = FPB_LengthShortWidth/2 - (mm(0.1)+FPB_HoleDiameter/2);

// No. 8 bolt carve out
WasherRecessDiameterBottomNo8 = mm(3/8)+mm(1/16); // extra 1/16 cleareance
WasherRecessDiameterTopNo8 = mm(3/8)+mm(1/8); // slighty conical clearance
WasherRecessHeightNo8 = mm(1/32)*3; //extra height to clear flillet
WasherEmbossDepth = 0.8; // mm
BoltHoleDiameterNo8 = mm(11/64);
BoltHoleDiameterNo6 = mm(0.17);//mm(0.185);
BoltLength3_4 = mm(3/4);

// No. 8 flat head bolt head dimensions
FlatHeadBolt8TopDia = mm(5/16);
FlatHeadBolt8BotDia = BoltHoleDiameterNo8;
FlatHeadBolt8Height = mm(0.125);

// Printed base plate feet
BaseFootTopDiameter = mm(0.75);
BaseFootBottomDiameter = mm(0.5);
BaseFootHeight = mm(0.5);

// Calculate vertical stackup
BottomStackup = BasePlateHeight+BasePlateRecess;
LidSupportStackup = LedgeHeight + LedgeRecess;
// Note: SP_PCB_HeightFromCaseBottom is greater thant BaseMountThickness / 2 so it is not included
CircuitCardCageStackup = SidePlanePCBHeight + SP_PCB_HeightFromCaseBottom + SP_PCB_HeightFromLedgeRecess;
VerticalStackup = CircuitCardCageStackup + BottomStackup + LidSupportStackup;
echo (BottomStackup = BottomStackup/25.4 ,"inches");
echo (LidSupportStackup = LidSupportStackup/25.4 ,"inches");
echo (CircuitCardCageStackup = CircuitCardCageStackup/25.4 ,"inches");
echo (VerticalStackup = VerticalStackup/25.4 ,"inches");
echo(PanelHeight = PanelHeight/25.4 ,"inches");
echo("Margin =", (PanelHeight - VerticalStackup)/25.4, "inches");

//echo(BackPanelRecess = BackPanelRecess);
//echo(BackPanelThickness = BackPanelThickness);
//echo(BaseMountThickness = BaseMountThickness);
//echo(PanelOverallLength = PanelOverallLength);
//echo(BaseMountWidth = BaseMountWidth);
//echo(BasePlateLength = BasePlateLength);
//echo(WasherRecessDiameterTopNo8 = WasherRecessDiameterTopNo8);
//echo(BoltHoleDiameterNo8  = BoltHoleDiameterNo8 );



