//
//  Generic_Soldier.m
//  The_KEY
//
//  Created by Nathan Jones on 10/8/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "Generic_Soldier.h"

@implementation Generic_Soldier
@synthesize left_Joystick;
@synthesize right_Joystick;
@synthesize crouch_Button;
@synthesize prone_Button;
@synthesize isProne;
@synthesize isPlayerControlled;
@synthesize isCrouching;
@synthesize team;
@synthesize squad_num;
@synthesize point_value;
@synthesize detection_distance;
@synthesize sight_distance;
@synthesize movement_speed;
@synthesize cover;

-(void) dealloc
{
    left_Joystick = nil;
    right_Joystick = nil;
    crouch_Button = nil;
    prone_Button = nil;
    [super dealloc];
}
- (id)init
{
    self = [super init];
    if (self) {
        left_Joystick =nil;
        right_Joystick = nil;
        crouch_Button = nil;
        prone_Button = nil;
        team = kNeutral;
        isPlayerControlled = false;
        isCrouching = false;
        isProne = false;
        squad_num = 0;
        sight_distance = 100;
        detection_distance = 100;
        point_value = 0;
        cover = kNoCover;
        movement_speed = 1;
    }
    
    return self;
}
-(CharacterStates) updateAI
{
    CCLOG(@"update AI ------ NO AI SET!!!");
    return kStateNone;
}

@end
