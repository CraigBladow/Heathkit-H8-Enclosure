// Heathkit H8 Computer Enclosure - Card and Top Bracket
// Copyright 2024 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

include <H8_parameters.scad>

// Card and Top Bracket
CardBracketWidth = 14; // mm
CardBracketThickness = 1.54; //mm
CardBracketLength = mm(6.25);
CardBrackeTabLength = mm(0.625);
CardBracketCardHoleDia = 4.0; //mm
CardBracketCardHoleSpacing = mm(4.0);
CardBracketTabCornerRadius = mm(0.1);

module CardBracketSpan()
{
    cube([CardBracketLength,CardBracketThickness,CardBracketWidth],center=true
    );
}

module CardBracketTab()
{
    union()
    {
        cylinder(h=CardBracketThickness,r=CardBracketTabCornerRadius,center=true);
    }
}

module washer(OuterDia, InnerDia, Thickness)
{
    difference()
    {
        cylinder(h = Thickness, r = OuterDia/2, center=true);
        cylinder(h = Thickness, r = InnerDia/2, center=true);
        
    }
}

module washers(NumWashers, OuterDia, InnerDia, Thickness)
{
//echo();
    X = ceil(sqrt(NumWashers));
    echo(X = X);
    count = 0;
    offset_xy = 1.5 * OuterDia;
    for(i = [ 1: X]) 
    {
        for(j = [ 1:X]) 
        {
            if(count < NumWashers)
            {
                translate([i * offset_xy,j * offset_xy,0]) washer(OuterDia, InnerDia, Thickness);
            }
        
        }  
    }
}

//SidePlanePrimeSlopeAngle
//$fn=64;
//CardBracketSpan();
//color("lime")CardBracketTab();



