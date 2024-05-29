// Heathkit H8 Computer Enclosure - Parameters and Functions
// Copyright 2024 Craig Bladow
// Released under MIT license:
//  
//        https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE
//  Notes on actual H8 case parameters:
//      Front Panel support ledge front edge is 1" from front edge of side panels
//      Lid support ledge edge recessed 0.25"
//      Front Panel, Front PCB, Circuit Cards, Side Plane front edge are all parallel to each other.
//      Case side panel: Length 17", Height 6.1", Top Edge Length 13.875-13.8", Bottom Edge Length 16.6", Height 6.1", Front edge vertex Height 0.6-0.7". Differences due to three different sources.

// Calculate Angles from case dimensions so relative profile can be maintained if case depth or height changes
SideFrontEdgeUpperAngle = atan((17-13.875)/(6.1-0.6)); // Using 13.875 and 0.6 as the angle matches the sideplane circuit card angles.
//echo(SideFrontEdgeUpperAngle = SideFrontEdgeUpperAngle);
SideFrontEdgeLowerAngle = atan((17-16.6)/(0.6));
//echo(SideFrontEdgeLowerAngle=SideFrontEdgeLowerAngle);
PanelHeightToFrontEdgeHeightRatio = (0.7/6.1);
//echo(PanelHeightToFrontEdgeHeightRatio = PanelHeightToFrontEdgeHeightRatio);

// Common Constants
left = 1.0;
right = -1.0;

//All measurements in inches converted to mm unless in mm directly.
function mm(x) = x * 25.4;  //convert inches to mm
function inch(x) = x / 25.4; // convert mm to inches


// Gap to use when splitting large parts in half or fourths
Gap = 0.15 *2.0; //mm

// Compensation for ridge produced at top layer for side panel halves
ridge_h = 3 * 0.3; //mm  3 layers at 0.3 mm layer height
ridge_w = 0.3; // mm for 0.6mm nozzle and 0.3 mm height

// Case Dimension
CaseWidth = mm(16.0);

// Front Panel PCB Dimensions
FP_PCB_Length = mm(14.75);
FP_PCB_Height = mm(5.75);
PCB_Thickness = 1.6; //mm
CardsNumberToModel = 7; // Not including rear expansion connector or Front Panel and last card.
CardPCB_Length = mm(12.0);
CardPCB_Height = mm(6.0);
CardPCB_Spacing = mm(1.0+5.0/32.0);
CardPCB_FirstOffsetFromFront = mm(5.0/8.0); //Rough
CardToSidePlaneGap = mm(3.0/16.0);

// Side Panel PCB dimensions and location of mount locations
SidePlanePCBHeight = mm(5.5);
SidePlanePCBTopEdgeLength = mm(11.125);
SidePlanePCBBottomEdgeLength = mm(14.25);
SidePlanePCBFrontEdgeLength = mm(6.52);


// Side Plane position location
SP_PCB_HorizOffset = mm(-0.25); // A big guess at the moment... :)
SP_PCB_HeightFromCaseBottom = mm(1.0/8.0); //Mk 1 estimate
SP_PCB_HeightFromLedgeRecess = mm(1.0/8.0); //Mk 1 estimate
SP_PCB_StandOffHeight = 6.5; //mm

// Side Plane mount locations
SP_MountVerticalInset = mm(7.0/16.0); // distance from upper or lower edge to center of mounting holes
SP_MountTopBackHorizInset = mm(3.0/4.0); // distance from back edge to the center of first upper mounting hole
SP_MountBottomBackHorizInset = mm(3.0+3.0/8.0); // distance from PCB back edge to the center of the first lower mounting hole
SP_MountHolesOffset = mm(4.0+5.0/8.0)+0.4; // distance between mounting holes, 0.4 added to make it work!
SP_MountHolesVerticalOffset = 2; //mm  Needed to clear base fillet.


//echo(SidePlanePrimeSlopeAngle = SidePlanePrimeSlopeAngle);

// Side Panel overall dimensions in inches.
PanelHeight = mm(6.7); //Last: 6.6 Old 6.25 /NCCP 6.1375
PanelCornerRadius = mm(0.125);// testing orig value 0.125
PanelOverallLength = mm(17);
PanelFrontBottomRecessHeight = PanelHeightToFrontEdgeHeightRatio * PanelHeight;
//echo (PanelFrontBottomRecessHeight = inch(PanelFrontBottomRecessHeight));
//PanelFrontBottomRecessLength = mm(0.4); // was 0.5
PanelFrontBottomRecessLength = PanelFrontBottomRecessHeight * tan(SideFrontEdgeLowerAngle);
//echo(PanelFrontBottomRecessLength = inch(PanelFrontBottomRecessLength),"inch");
PanelThickness = mm(0.5);
PanelSocketsNumber = 6;

// Calculate PanelTopLength
PanelTopLength = PanelOverallLength - tan(SideFrontEdgeUpperAngle)*(PanelHeight - PanelFrontBottomRecessHeight);
//echo(PanelTopLength = PanelTopLength/25.4 , "inches");

//Check the leading case edge angle
SideFrontEdgeSlope = (PanelOverallLength-PanelTopLength)/(PanelHeight-PanelFrontBottomRecessHeight);
CheckPrimeSlopeAngle = atan(SideFrontEdgeSlope); //(PanelOverallLength-PanelTopLength)/(PanelHeight-PanelFrontBottomRecessHeight));
//echo(CheckPrimeSlopeAngle = CheckPrimeSlopeAngle);
//echo(SideFrontEdgeSlope = SideFrontEdgeSlope);

SidePlanePrimeSlopeAngle = atan((SidePlanePCBBottomEdgeLength - SidePlanePCBTopEdgeLength)/SidePlanePCBHeight);

// Front Panel Ledge
FP_LedgeLength = mm(4.0);
FP_LedgeWidth = mm(0.125);  // was 0.08 // how far the ledge sticks out
FP_LedgeHeight = mm(0.125); 
FP_LedgeAngle = 90.0 - SidePlanePrimeSlopeAngle; 
//echo (FP_LedgeAngle = FP_LedgeAngle);
FP_LedgeRecess = mm(1.0);
FP_LedgeOffsetVertical = (PanelHeight/2) - ((FP_LedgeLength/2)*cos(SidePlanePrimeSlopeAngle)) - mm(0.5);
// Solve for the Y1 value of the point on the leading edge that is the same X distance as the center of the front panel support ledge
L_M = -1.0 * SideFrontEdgeSlope;
//echo(L_M = L_M);
L_X = PanelHeight/2;
//echo(L_X = inch(L_X) , "inches");
L_Y = PanelTopLength - PanelOverallLength/2;
//echo(L_Y = inch(L_Y) , "inches");
L_B = L_Y - (L_M * L_X);
//echo(L_B = inch(L_B) , "inches");
Y1 = (L_M * FP_LedgeOffsetVertical) + L_B;
//echo(Y1 = inch(Y1) , "inches");
//FP_LedgeOffsetHorizontal = Y1;
FP_LedgeOffsetHorizontal = Y1 - (FP_LedgeRecess * cos(SidePlanePrimeSlopeAngle));
//offset = FP_LedgeRecess * cos(SidePlanePrimeSlopeAngle);
//echo(offset = inch(offset));

//- (FP_LedgeHeight * sin(SidePlanePrimeSlopeAngle));
//FP_LedgeOffsetHorizontal = PanelOverallLength/2-FP_LedgeRecess;

// Lid support
LedgeRecess = mm(0.25); // Distance from side panel top edge to top of ledge
LedgeOffset = mm(1.875); 
LedgeWidth = mm(0.125);  // Horizontal dimension, was 0.05
LedgeHeight = mm(0.125); // Vertical height of ledge
LedgeLength = mm(10.7);

// Side Panel Base Plate and Back Panel Recess , how much the side panel extends below the bottom of the base plate
BasePlateRecess = mm(0.125);
BackPanelRecess = BasePlateRecess;

// Side Plane PCB and Front Panel Mounting Hole locations
T_Z = (SidePlanePCBHeight/2 - SP_MountVerticalInset) + SP_MountHolesVerticalOffset; // top row Z 
B_Z = -(SidePlanePCBHeight/2 - SP_MountVerticalInset)+ SP_MountHolesVerticalOffset; // bottom row Z
TY_R = SP_MountTopBackHorizInset + SP_PCB_HorizOffset; //top rear Y
TY_M = TY_R + SP_MountHolesOffset; //top middle Y
TY_F = TY_M + SP_MountHolesOffset; //top front Y
BY_R = SP_MountBottomBackHorizInset; //bottom rear Y
BY_M = BY_R + SP_MountHolesOffset; //bottom middle Y
BY_F = BY_M + SP_MountHolesOffset; //bottom front Y

// Front Panel mount side panel insert location
//color("lime")translate([PanelHeight/2-LedgeHeight/2-LedgeRecess,-LedgeOffset,side*(PanelThickness/2+LedgeWidth/2)])rotate([0,0,0]) Ledge(LedgeLength,LedgeWidth,LedgeHeight/2);
//FP_Z = T_Z + 12; //Front panel inset Z
FP_Z = PanelHeight/2-LedgeHeight/2-LedgeRecess;
FP_YORIG = TY_F + 50;
FP_Y = FP_LedgeOffsetHorizontal;
echo(FP_YORIG = FP_YORIG);
echo(FP_Z = FP_Z);
echo(FP_Y = FP_Y);

SP_MountLocations = [[0,TY_R,T_Z],[0,TY_M,T_Z],[0,TY_F,T_Z],[0,BY_R,B_Z],[0,BY_M,B_Z],[0,BY_F,B_Z]]; // [ Y, Z],..

//echo(MountsNew= SP_MountLocations);


/* before vertical offset 
ECHO: MountsOld = [[0, 19.05, 58.7375], [0, 136.925, 58.7375], [0, 254.8, 58.7375], [0, 85.725, -58.7375], [0, 203.6, -58.7375], [0, 321.475, -58.7375]]

after vertical 2 mm offset
ECHO: MountsNew = [[0, 19.05, 60.7375], [0, 136.925, 60.7375], [0, 254.8, 60.7375], [0, 85.725, -56.7375], [0, 203.6, -56.7375], [0, 321.475, -56.7375]]
*/



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

// Mini ITX power supply
PS_Height = 125;//mm
PS_Length = 100;//mm
PS_Width = 65;//mm
PS_Lift = mm(0.5);

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
FPB_LengthLongWidth = mm(0.41);
FPB_LengthLongHoleSpacing = mm(4.0);
FPB_LengthShortWidth = 14;//mm(0.5+1/6);
FPB_LengthShort = mm(3.75);
FPB_Thickness = mm(1/16);
FPB_HoleSpacing = mm(3.0);
FPB_HoleDiameter = mm(0.165);
//FPB_HoleOffsetShort = FPB_LengthShortWidth/2 - (mm(0.1)+FPB_HoleDiameter/2);
FPB_HoleOffsetShort = FPB_LengthShortWidth/2 - FPB_HoleDiameter/2 - 2;
FPB_LengthLongShift = mm(3/16);


//FP_MountLocations
// two holes FPB_LengthLongHoleSpacing apart rotated by SidePlanePrimeSlopeAngle
// one hole for Front Panel mount


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
CircuitCardCageStackup = SidePlanePCBHeight + SP_PCB_HeightFromCaseBottom + SP_PCB_HeightFromLedgeRecess + SP_MountHolesVerticalOffset;
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



