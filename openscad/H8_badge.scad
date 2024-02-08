// Heathkit H8 Computer Enclosure - H8 Badge
// Copyright 2024 Craig Bladow
// Released under MIT license:
// Uses hilbert texture per:
// https://github.com/prusa3d/PrusaSlicer/issues/4455
// Status is testing, font and style and dimensions are TBD


letter_height = 0.2001; //Match layer height

module letter(letter,letter_height, size)
{

    // convexity is needed for correct preview
    // since characters can be highly concave
    linear_extrude(height=letter_height, convexity=4)
        text(letter, 
             size=size,//width*22/30,
             //font="Bitstream Vera Sans:style=Bold",
             //font="Liberation Sans:style=Bold",
             //font="Liberation Sans",
             //font="Liberation Sans:style=Italic",
            //font="DM Sans Medium:style=Bold",
            //font="DM Sans Medium:style=Italic",
            font="Rodeo58",
            //font="DM Sans Medium:",
             halign="center",
             valign="center");
}

module letter_font(letter,lfont, letter_height, size)
{

    // convexity is needed for correct preview
    // since characters can be highly concave
    linear_extrude(height=letter_height, convexity=4)
        text(letter, 
             size=size,//width*22/30,
            font=lfont,
             halign="center",
             valign="center");
}

module heathkit(name,calc,hhc,location)
{
        rotate([0,180,90]) letter("HEATHKIT",letter_height,10);
}



heathkit();
/*
difference()
{
    cube([20,20,4],center = true);
    translate([0,0,2])cube([16,16,4],center = true);
} */

