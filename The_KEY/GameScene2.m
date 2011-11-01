//
//  GameScene2.m
//  The_KEY
//
//  Created by Nathan Jones on 10/24/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "GameScene2.h"

@implementation GameScene2

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        controlLayer = [ControlLayer2d node];
        [self addChild:controlLayer z:2 tag:2];
        
        Scrolling_Tilemap_Gameplay_test * scrolling_layer = [Scrolling_Tilemap_Gameplay_test node];
        [self addChild:scrolling_layer z: 1 tag: 1];
        //connect joystick and buttons
        [scrolling_layer connectControlsWithRightJoystick:[controlLayer rightJoystick] andLeftJoystick:[controlLayer leftJoystick] andProneButton:[controlLayer proneButton] andCrouchButton:[controlLayer crouchButton]];
    }
    
    return self;
}

@end
