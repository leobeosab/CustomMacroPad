// CherryMX Switch
switchBaseSize = 14;
switchBaseHeight = 5;
switchTopHeight = 4.7;
switchSkirtHeight = 1;
switchSkirtOffset = 1.6;
switchSpacing = 6;
switchTotalWidth = switchBaseSize + switchSkirtOffset;

// Switch Config
switchesWide = 2;
switchesTall = 2;

// Calculate Values for base
switchesWidth = switchesWide * switchTotalWidth;
switchesLength = switchesTall * switchTotalWidth;
    
offsetWidth = ((switchesWide+1) * switchSpacing);
offsetLength = ((switchesTall+1) * switchSpacing);

// Base
baseThickness = 6;
baseHeight = 15;
baseWidth = switchesWidth + offsetWidth;
baseLength = switchesLength + offsetLength;

// Plate
plateHeight = 1.5;
plateWidth = baseWidth;
plateLength = baseLength;
plateOffsetFromBase = 10;

// Plate Supports
supportWidth = 5;
supportLength = 5;

// Cable Hole
cableHoleWidth = 8;
cableHoleHeight = 3.5;

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
    for (x = [0: switchesWide-1]) {
        for (y = [0: switchesTall-1]) {
            translate([
                (x * switchTotalWidth) + ((x + 1) * switchSpacing),
                (y * switchTotalWidth) + ((y + 1) * switchSpacing),
                0
            ])
            switchBase();
        }
    }
        
}

module macroBase() {
    // Bottom of macroHolder
    color("cyan")
    linear_extrude(height=baseThickness) {
        offset(r=baseThickness) {
            square([
                baseWidth,
                baseLength,
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
                baseWidth,
                baseLength,
            ], false);
        }
        square([
                baseWidth,
                baseLength,
            ], false);
        }
    }
}

module switchPlate() {
    difference() {
        translate([0,0, plateOffsetFromBase + baseThickness])
        color("pink")
        cube([plateWidth, plateLength, plateHeight]);
        
        translate([0,0, plateOffsetFromBase + baseThickness])
        switches();
    }
}

module support() {
    cube([supportWidth, supportLength, plateOffsetFromBase]);
}

module plateSupports() {
    translate([0, 0, baseThickness])
    union() {
        support();
        
        translate([baseWidth - supportWidth, 0, 0])
        support();
        
        translate([0, baseLength - supportLength, 0])
        support();
        
        translate([baseWidth - supportWidth, baseLength - supportLength, 0])
        support();
    }
}

module renderSwitches() {
    translate([0,0, plateOffsetFromBase + baseThickness - switchBaseHeight + plateHeight])
switches();
}

module cableHole() {
    // Center the hole in the middle of the case at the back
    translate([baseWidth / 2, baseLength + baseThickness / 2, baseThickness * 1.5])
        cube([cableHoleWidth, baseThickness, cableHoleHeight], true);
}

difference() {
    macroBase();
    //cableHole();
}


plateSupports();
switchPlate();
renderSwitches();
