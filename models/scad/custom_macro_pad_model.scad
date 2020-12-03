switchBaseSize = 14;
switchBaseHeight = 5;
switchTopHeight = 4.7;
switchSkirtHeight = 1;
switchSkirtOffset = 1.6;
switchSpacing = 6;
switchTotalWidth = switchBaseSize + switchSkirtOffset;

switchesWide = 2;
switchesTall = 2;

baseThickness = 6;
baseHeight = 15;

module switchBase() {
    translate([switchSkirtOffset / 2, switchSkirtOffset / 2, 0])
    
    color("black")
    cube([
    switchBaseSize,
    switchBaseSize, 
    switchBaseHeight], false);
    
    color("blue")
    translate([switchSkirtOffset / 2, switchSkirtOffset / 2,switchBaseHeight+switchSkirtHeight])
    cube([
    switchBaseSize, 
    switchBaseSize, 
    switchTopHeight], false);

    color("white")
    translate([0,0,switchBaseHeight])
    cube([
    switchBaseSize+switchSkirtOffset, 
    switchBaseSize+switchSkirtOffset, 
    switchSkirtHeight], false);
}

module switches() {    
    //translate([baseThickness, baseThickness, baseThickness+8])
    for (x = [0: switchesWide-1]) {
        for (y = [0: switchesTall-1]) {
            translate([
                (x * switchTotalWidth) + ((x + 1) * switchSpacing),
                (y * switchTotalWidth) + ((y + 1) * switchSpacing),
                baseThickness
            ])
            switchBase();
        }
    }
        
}

module macroBase() {
    switchesWidth = switchesWide * switchTotalWidth;
    switchesLength = switchesTall * switchTotalWidth;
    
    offsetWidth = ((switchesWide+1) * switchSpacing);
    offsetLength = ((switchesTall+1) * switchSpacing);
    
    // Bottom of macroHolder
    color("cyan")
    linear_extrude(height=baseThickness) {
        offset(r=baseThickness) {
            square([
                switchesWidth + offsetWidth,
                switchesLength + offsetLength,
            ], false);
        }
    }
    
    // Move off of base
    translate([0,0, baseThickness])
    // Walls of macroholder
    linear_extrude(height=baseHeight + switchBaseHeight){
        difference() {
        offset(r=baseThickness) {
            square([
                switchesWidth + offsetWidth,
                switchesLength + offsetLength,
            ], false);
        }
        square([
                switchesWidth + offsetWidth,
                switchesLength + offsetLength,
            ], false);
        }
    }
    
    // Cable Hole
    
}

//translate([baseThickness, baseThickness, 0])
macroBase();
switches();
