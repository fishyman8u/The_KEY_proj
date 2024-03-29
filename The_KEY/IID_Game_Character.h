//
//  IID_Game_Character.h
//  The_KEY
//
//  Created by Nathan Jones on 12/1/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "IID_Game_Object.h"
#import "Box2D.h"

@interface IID_Game_Character : IID_Game_Object
{
    //BOOLs
    BOOL isPlayerControlled;
    
    //counters
    int Health;
   
    //physics vars
    b2Vec2 velocity;
    b2Body *body;
    //enums
    CharacterStates characterState;
    //Planned states:
        //walking
        //running
        //stalking
        //patrolling
        //move and shoot
        //kneel and shoot
        //prone and shoot
        //prone crawl
        //standing
        //dead
        //lean and shoot
        //stand and shoot
        //diving for cover
        //guarding
        //prone
        //kneelling
    
    //Points
    CGPoint destination;
    CGPoint Target_point;
    
    //AI
   
}
@property(nonatomic, assign) int health;
@property (assign) b2Body *body;
@property(nonatomic, assign) CharacterStates characterState;
@property(assign) b2Vec2 velocity;
@property(nonatomic, assign) CGPoint destination;
@property(nonatomic, assign) CGPoint Target_point;
@property(nonatomic, assign) BOOL isPlayerControlled;
@end
