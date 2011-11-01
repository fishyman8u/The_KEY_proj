//
//  GameCharacter.h
//  The_KEY
//
//  Created by Nathan Jones on 10/8/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "GameObject.h"

@interface GameCharacter : GameObject
{
    int characterHealth;
    CharacterStates characterState;
    AI_States characterAIState;
    int owner_tag;
     int team;
    float xVelocity;
    float yVelocity;
    BOOL isMovingtoPoint;
    BOOL Y_switch;
    BOOL X_switch;
    BOOL isEnemySet;
    CGPoint last_position;
    CGPoint move_to;
    CGPoint enemy_position;
    NSInteger enemy_tag;
    NSInteger frameCount;
    float movement_speed;
    float angle_adjustment;
    float sight_distance;
    float last_time;
}

-(void) checkAndClampSpritePosition;
-(int)getWeaponDamage;
-(void) checkCollisions: (CCArray *) listOfGameObjects;
-(void) changeAIState:(AI_States)ai_state;
//handle rotation and movement speed
-(void) moveTo:(CGPoint)location;
-(void) movementUpdate:(float)deltaTime;
-(void) chooseTarget:(CCArray *) listOfGameObjects;
-(void) setTarget:(NSInteger) enemyTag;
-(void) attackUpdate:(float)deltaTime;
-(float) findRotation:(CGPoint) origin andTarget:(CGPoint) target;
@property(readwrite) int characterHealth;
@property(readwrite) CharacterStates characterState;
@property(readwrite) int owner_tag;
@property (readwrite) int team;
@property(readwrite) float xVelocity;
@property(readwrite) float yVelocity;
@property(readwrite) float sight_distance;
@property(readwrite) BOOL isMovingtoPoint;
@property(readwrite) CGPoint move_to;
@property (readwrite) float movement_speed;
@property (readwrite) BOOL Y_switch;
@property(readwrite) BOOL X_switch;
@property(readwrite) CGPoint last_position;
@property(readwrite) float angle_adjustment;
@property(readwrite) BOOL isEnemySet;
@property(readwrite) CGPoint enemy_position;
@property(nonatomic, assign) id <GameplayLayerDelegate> delegate;
@property(readwrite) NSInteger enemy_tag;
@property(readwrite) float last_time;
@property(readwrite) NSInteger frameCount;
@end
