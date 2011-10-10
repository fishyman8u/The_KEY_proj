//
//  AFC.m
//  The_KEY
//
//  Created by Nathan Jones on 10/8/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "AFC.h"

@implementation AFC
@synthesize Walking_Anim;
@synthesize Prone_Anim;
@synthesize Standing_Anim;
@synthesize Crouching_Anim;
@synthesize weapon;

- (void) dealloc
{
    [Walking_Anim release];
    [Standing_Anim release];
    [Crouching_Anim release];
    [Prone_Anim release];
    [super dealloc];
}
- (int) getWeaponDamage
{
    if(weapon == kWeapon_p90)
    {
        return kP90_Weapon_Damage;
    }
    if(weapon == kWeapon_Laser)
    {
        return kLaser_Weapon_Damage;
    }
    CCLOG(@"Undefined Weapon Type");
    return 0;
}
-(void) applyJoystick:(SneakyJoystick*)aJoysick forTimeDelta:(float) deltaTime
{
    CGPoint scaledVelocity = ccpMult(aJoysick.velocity, self.movement_speed); 
    CGPoint oldPosition = [self position];
    CGPoint newPosition = ccp(oldPosition.x +scaledVelocity.x *deltaTime, oldPosition.y+ scaledVelocity.y * deltaTime);
    [self setPosition:newPosition];
    float rotation_factor;
    // CCLOG(@"%f", aJoysick.degrees);
    if((aJoysick.degrees <360) && (aJoysick.degrees >90))
    {
        rotation_factor = 450;
        rotation_factor = rotation_factor -  aJoysick.degrees ;
       
    }
    if ((aJoysick.degrees > 0) && (aJoysick.degrees < 90))
             {
                 rotation_factor = 90;
                 rotation_factor = rotation_factor - aJoysick.degrees;
             }
    

    [self setRotation:rotation_factor ];
    }
-(void) applyWeaponJoystick:(SneakyJoystick*)aJoysick forTimeDelta:(float) deltaTime
{
    
}
-(void)checkAndClampSpritePosition
{
    
}
-(void)changeState:(CharacterStates)newState
{
    [self stopAllActions];
    id action = nil;
  //  id movementAction = nil;
   // CGPoint newPosition;
    [self setCharacterState:newState];
    switch (newState) {
        case kStateStanding:
            action = [CCAnimate actionWithAnimation:Standing_Anim restoreOriginalFrame:NO];
            break;
        case kStateWalking:
            action = [CCAnimate actionWithAnimation:Walking_Anim restoreOriginalFrame:NO];
            break;
        case kStateCrouching:
            CCLOG(@"Playing Crouch anim");
            action = [CCAnimate actionWithAnimation:Crouching_Anim restoreOriginalFrame:NO];
            break;
        case kStateProne:
            action = [CCSequence actions:[CCAnimate actionWithAnimation:Crouching_Anim restoreOriginalFrame:NO],[CCAnimate actionWithAnimation:Prone_Anim restoreOriginalFrame:NO] ,nil];
            break;
        case kStateDead:
            break;
        default:
            CCLOG(@"ERROR: Undefined State!");
            break;
    }
    if(action !=nil)
    {
        [self runAction:action];
    }
}
-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListofGameObjects:(CCArray *)listOfGameObjects
{
    //check if dead
    if(self.characterState == kStateDead) return;
    if(self.characterHealth <=0)
    {
        [self changeState:kStateDead];
    }
    
    //check if running taking damage
    if((self.characterState == kStateTakingDamage) && self.numberOfRunningActions > 0) return;
    //check for collisions
   CGRect DaBox = [self adjustedBoundingBox];
    for(GameCharacter * character in listOfGameObjects)
    {
        CGRect charBox = [character adjustedBoundingBox];
        if(CGRectIntersectsRect(DaBox, charBox))
           {
               if([character gameObjectType] == kBullet)
               {
                   [self changeState:kStateTakingDamage];
                   [character changeState:kStateDead];
               }
               //movement restrictions can go here
           }
        
    }
   // if([self numberOfRunningActions] >= 1) return;
    //handle crouching, prone, walking, etc
    if((self.characterState == kStateCrouching) ||
       (self.characterState == kStateProne) ||
       (self.characterState == kStateWalking) ||
       (self.characterState == kStateStanding))
    {
        
        if(prone_Button.active)
        {
            
            //if(isProne == NO){
            if(self.isProne == NO){
            [self changeState:kStateProne];
                [self setIsProne:YES];
                CCLOG(@"Setting state to prone");
                //return;
            }
            //else if(self.isProne == YES)
            /*{
                CCLOG(@"Setting state to standing");
                [self changeState:kStateStanding];
                [self setIsProne:NO];  
                //return;
            }*/
          //  [self setIsProne:YES];
                
         //   }
          //  if(isProne == YES)
         //   {
          //      [self changeState:kStateStanding];
          //      [self setIsProne:NO];
          //  }
            //[self setIsProne:YES];
            // CCLOG(@"Prone!");
        }
       if(crouch_Button.active)
        {
            if(isCrouching == NO){
            [self changeState:kStateCrouching];
                [self setIsCrouching:YES];
                }/*
            else if(isCrouching == YES)
            {
                [self changeState:kStateStanding];
                [self setIsCrouching:NO];
            }*/
            //if(!(isProne)){
           //     if(self.characterState != kStateCrouching){
          //        [self changeState:kStateCrouching];  
          //    [self setIsCrouching:YES];
           //         CCLOG(@"Crouching!");}
           // }
            
        }
       
       /* if(!(prone_Button.active) && (isProne))
        {
            if(crouch_Button.active)
            {
                [self changeState:kStateCrouching];
            }
            else
            {
                [self changeState:kStateStanding];
            }
            [self setIsProne:NO];
        }
        if(!(crouch_Button.active) && (isCrouching))
        {
            [self changeState:kStateStanding];
            [self setIsCrouching:NO];
        }
        */
       if((self.left_Joystick.velocity.x != 0) || (self.left_Joystick.velocity.y != 0))
           {
               [self setIsProne:NO];
               [self setIsCrouching:NO];
               [self applyJoystick:left_Joystick forTimeDelta:deltaTime];
               if(( self.characterState != kStateWalking) || ([self numberOfRunningActions] == 0))
               [self changeState:kStateWalking];
               
           }
    }

}
    //if no actions check for death
  


-(CGRect) adjustedBoundingBox
{
    CGRect placeholder = [self boundingBox];
    
    
    return placeholder;
}
-(void)initAnimations
{
    [self setWalking_Anim:[self loadPlistForAnimationWithName:@"Walking_Anim" andClassName:@"Air_Force_Commando"]];
    [self setStanding_Anim:[self loadPlistForAnimationWithName:@"Standing_Anim" andClassName:@"Air_Force_Commando"]];
    [self setCrouching_Anim:[self loadPlistForAnimationWithName:@"Crouching_Anim" andClassName:@"Air_Force_Commando"]];
    [self setProne_Anim:[self loadPlistForAnimationWithName:@"Prone_Anim" andClassName:@"Air_Force_Commando"]];
    CCLOG(@" ---- init animations");
}
- (id)init
{
    self = [super init];
    if (self) {
        self.gameObjectType = kAFC;
        [self initAnimations];
        //self.flipY = YES;
        //self.flipX = YES;
    }
    
    return self;
}

@end
