// Heathkit H8 Computer Enclosure - Card and Top Bracket
// Copyright 2023 Craig Bladow
// Released under MIT license:
//          https://github.com/CraigBladow/Heathkit-H8-Enclosure/blob/main/LICENSE

include <H8_parameters.scad>

// Card and Top Bracket
CardBracketWidth = 14; // mm
CardBracketThickness = 1.54; //mm
CardBracketLength = mm(6.25);
CardBrackeTabLength = mm(0.625);
CardBracketCardHoleDia = 3.6; //mm
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

CardBracketSpan();
color("lime")CardBracketTab();