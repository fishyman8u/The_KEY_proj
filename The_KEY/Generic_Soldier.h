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
   
    BOOL isPlayerControlled;
    BOOL isCrouching;
    BOOL isProne;
    BOOL isFiring;
    BOOL recoil;
    BOOL isUnderAttack;
    float fire_rate;
    float leftover_time;
   // float last_time;
    int squad_num;
    //float sight_distance;
    float detection_distance;
    int point_value;
    CoverState cover;
    
    int frame_count;
    //AI Related
    int step_counter;
    AI_States aiState;
    //UI Pointers
    SneakyJoystick *left_Joystick;
    SneakyJoystick *right_Joystick;
    SneakyButton *crouch_Button;
    SneakyButton *prone_Button;
    //button_lock
    BOOL button_lock;
    
    //anims
    //standing
    CCAnimation *Standing_Anim;
    
    //walking
    CCAnimation *Walking_Anim;
    CCAnimation *Running_Anim;
    //Crouching
    CCAnimation *Crouching_Anim;
    CCAnimation *Crouching_to_prone;
    CCAnimation *Crouching_to_Standing;
    //Prone
    CCAnimation *Prone_Anim;
    CCAnimation *Prone_to_Crouching;
    CCAnimation *Prone_to_Standing;
    //Dying Anim
    CCAnimation *Dying_Prone;
    CCAnimation *Dying_Crouching;
    CCAnimation *Dying_Standing;
    //other info 
    //weapon type
    WeaponType weapon;
    
    //ammo and mags
    float ammo, mags;


}
@property(readwrite) AI_States aiState;
@property(readwrite) float ammo;
@property(readwrite) float mags;
//@property(readwrite) float last_time;
@property(readwrite) float leftover_time;
@property(readwrite) float fire_rate;
@property(readwrite) BOOL recoil;
@property(nonatomic, assign) id <GameplayLayerDelegate> delegate;
@property(readwrite) int step_counter;
@property (readwrite) int squad_num;
@property (readwrite) int point_value;
//@property (readwrite) float sight_distance;
@property (readwrite) float detection_distance;

@property (readwrite) BOOL isPlayerControlled;
@property (readwrite) BOOL isCrouching;
@property (readwrite) BOOL isProne;
@property (readwrite) BOOL isUnderAttack;
@property (readwrite) CoverState cover;
@property (nonatomic, retain) SneakyButton * crouch_Button;
@property (nonatomic, retain) SneakyButton * prone_Button;
@property (nonatomic, retain) SneakyJoystick * left_Joystick;
@property (nonatomic, retain) SneakyJoystick * right_Joystick;
@property(nonatomic, retain) CCAnimation *Standing_Anim;
@property(nonatomic, retain) CCAnimation *Walking_Anim;
@property(nonatomic, retain) CCAnimation *Crouching_Anim;
@property(nonatomic, retain) CCAnimation *Prone_Anim;
@property(nonatomic, retain) CCAnimation *Crouching_to_prone;
@property(nonatomic, retain) CCAnimation *Crouching_to_Standing;
@property(nonatomic, retain) CCAnimation *Prone_to_Crouching;
@property(nonatomic, retain) CCAnimation *Prone_to_Standing;
@property(nonatomic, retain) CCAnimation *Running_Anim;
@property(nonatomic, retain) CCAnimation *Dying_Prone;
@property(nonatomic, retain) CCAnimation *Dying_Crouching;
@property(nonatomic, retain) CCAnimation *Dying_Standing;
@property(readwrite) WeaponType weapon;
@property(readwrite) BOOL button_lock;
@property(readwrite) BOOL isFiring;
//methods
-(void) handleProneState;
-(void) handleCrouchingState;
-(void) handleShooting:(SneakyJoystick*) aJoystick forTime:(float) deltaTime;
-(void) otherStates:(float) deltaTime;
-(void) AIAttack:(float)deltaTime andTargetInfo:(NSInteger) target_tag;
    //update AI
    //
    //override object methods
@end
