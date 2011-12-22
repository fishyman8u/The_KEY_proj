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
        [self addChild:controlLayer z:3 tag:2];
        
        Default_Tile_Layer* scrolling_layer = [Default_Tile_Layer node];
        [self addChild:scrolling_layer z: 0 tag: 1];
        Default_GameplayLayer *gameplay_layer = [Default_GameplayLayer node];
        [self addChild:gameplay_layer z:2 tag:3];
        //connect joystick and buttons
        [gameplay_layer connectControlsWithRightJoystick:[controlLayer rightJoystick] andLeftJoystick:[controlLayer leftJoystick] andProneButton:[controlLayer proneButton] andCrouchButton:[controlLayer crouchButton]];
    }
    
    return self;
}

@end
