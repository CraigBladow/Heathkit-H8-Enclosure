// Heathkit H8 Computer Enclosure - Parameters and Functions
// Copyright 2024 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

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
SidePlanePCBBottomEdgeLength = mm(14.25);// wrong! old version: mm(13.25);
SidePlanePCBFrontEdgeLength = mm(6.52);// wrong! old version: mm(6.25);
PCB_Thickness = 1.6; //mm
CardPCB_Length = mm(12.0);
CardPCB_Height = mm(6.0);
CardToSidePlaneGap = mm(3.0/16.0);
SidePlanePrimeSlopeAngle = atan((SidePlanePCBBottomEdgeLength - SidePlanePCBTopEdgeLength)/SidePlanePCBHeight);
echo(SidePlanePrimeSlopeAngle = SidePlanePrimeSlopeAngle);

// Side Panel PCB mount locations
SP_MountVerticalInset = mm(7.0/16.0);
SP_MountTopBackHorizInset = mm(3.0/4.0);
SP_MountBottomBackHorizInset = mm(3.0+9.0/16.0);
SP_MountHolesOffset = mm(4.0+5.0/8.0);
SP_PCB_InsetFromCaseBack = mm(1.0); // A big guess at the moment... :)
SP_PCB_HeightFromCaseBottom = mm(0);

SP_PCB_StandOffHeight = 6.5; //mm


// Side Panel overall dimensions in inches.
PanelHeight = mm(6.25); //NCCP 6.1375
PanelCornerRadius = mm(0.125);
PanelOverallLength = mm(17);
PanelFrontBottomRecessHeight = mm(0.5);
PanelFrontBottomRecessLength = mm(0.5);
PanelTopLength = mm(14.0);
PanelThickness = mm(0.5);
PanelSocketsNumber = 6;

//Find the angle for to base front panel ledge and bracket on
// Todo - use side panel dimensions,also adjusting the Panel dimensions currently used.
PrimeSlopeAngle = atan((PanelOverallLength-PanelTopLength)/(PanelHeight-PanelFrontBottomRecessHeight));
echo(PrimeSlopeAngle = PrimeSlopeAngle);
// Front Panel Ledge
FP_LedgeLength = mm(4);
FP_LedgeWidth = mm(0.08);
FP_LedgeHeight = mm(0.121);
FP_LedgeAngle = 90 - PrimeSlopeAngle; //58.15; //degrees
FP_LedgeRecess = mm(2.5);
FP_LedgeOffset = mm(0.0);

// Lid support
LedgeRecess = mm(0.27);
LedgeOffset = mm(1.875);
LedgeWidth = mm(0.05);
LedgeHeight = mm(0.125);
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
BoltLength3_4 = mm(3/4);

BaseFootTopDiameter = mm(0.75);
BaseFootBottomDiameter = mm(0.5);
BaseFootHeight = mm(0.5);

//echo(BackPanelRecess = BackPanelRecess);
//echo(BackPanelThickness = BackPanelThickness);
//echo(BaseMountThickness = BaseMountThickness);
//echo(PanelOverallLength = PanelOverallLength);
//echo(BaseMountWidth = BaseMountWidth);
//echo(BasePlateLength = BasePlateLength);
//echo(WasherRecessDiameterTopNo8 = WasherRecessDiameterTopNo8);
//echo(BoltHoleDiameterNo8  = BoltHoleDiameterNo8 );



