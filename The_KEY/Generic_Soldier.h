//
//  Generic_Soldier.h
//  The_KEY
//
//  Created by Nathan Jones on 10/8/11.
//  Copyright 2011 Student. All rights reserved.
//




//This class will contain standard AI and human UI controls for all soldier type entities in the game
#import "GameCharacter.h"
#import "SneakyButton.h"
#import "SneakyJoystick.h"
#import "CommonProtocols.h"
@interface Generic_Soldier : GameCharacter
{
    //control info
    int team;
    BOOL isPlayerControlled;
    BOOL isCrouching;
    BOOL isProne;
    int squad_num;
    float sight_distance;
    float detection_distance;
    int point_value;
    CoverState cover;
    float movement_speed;
    
        
    //UI Pointers
    SneakyJoystick *left_Joystick;
    SneakyJoystick *right_Joystick;
    SneakyButton *crouch_Button;
    SneakyButton *prone_Button;

}
@property (readwrite) int team;
@property (readwrite) int squad_num;
@property (readwrite) int point_value;
@property (readwrite) float sight_distance;
@property (readwrite) float detection_distance;
@property (readwrite) float movement_speed;
@property (readwrite) BOOL isPlayerControlled;
@property (readwrite) BOOL isCrouching;
@property (readwrite) BOOL isProne;
@property (readwrite) CoverState cover;
@property (nonatomic, retain) SneakyButton * crouch_Button;
@property (nonatomic, retain) SneakyButton * prone_Button;
@property (nonatomic, retain) SneakyJoystick * left_Joystick;
@property (nonatomic, retain) SneakyJoystick * right_Joystick;
//methods

    //update AI
    //
    //override object methods
@end
