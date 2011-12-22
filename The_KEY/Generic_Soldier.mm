//
//  Generic_Soldier.m
//  The_KEY
//
//  Created by Nathan Jones on 10/8/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "Generic_Soldier.h"

@implementation Generic_Soldier
@synthesize fire_rate;
//@synthesize last_time;
@synthesize recoil;
@synthesize delegate;
@synthesize left_Joystick;
@synthesize right_Joystick;
@synthesize crouch_Button;
@synthesize prone_Button;
@synthesize isProne;
@synthesize isPlayerControlled;
@synthesize isCrouching;
@synthesize step_counter;
@synthesize squad_num;
@synthesize point_value;
@synthesize detection_distance;
//@synthesize sight_distance;

@synthesize cover;
@synthesize Walking_Anim;
@synthesize Prone_Anim;
@synthesize Standing_Anim;
@synthesize Crouching_Anim;
@synthesize weapon;
@synthesize button_lock;
@synthesize Running_Anim;
@synthesize Crouching_to_prone;
@synthesize Crouching_to_Standing;
@synthesize Prone_to_Standing;
@synthesize Prone_to_Crouching;
@synthesize Dying_Prone;
@synthesize Dying_Standing;
@synthesize Dying_Crouching;
@synthesize isFiring;
@synthesize leftover_time;
@synthesize ammo;
@synthesize mags;
@synthesize isUnderAttack;
@synthesize aiState;
-(void) dealloc
{
    left_Joystick = nil;
    right_Joystick = nil;
    crouch_Button = nil;
    prone_Button = nil;
    [Walking_Anim release];
    [Prone_Anim release];
    [Crouching_Anim release];
    [Standing_Anim release];

    [super dealloc];
}
-(void) initAnimations
{
    [self setWalking_Anim:[self loadPlistForAnimationWithName:@"Walking_Anim" andClassName:NSStringFromClass([self class])]];
    [self setStanding_Anim:[self loadPlistForAnimationWithName:@"Standing_Anim" andClassName:NSStringFromClass([self class])]];
    [self setCrouching_Anim:[self loadPlistForAnimationWithName:@"Crouching_Anim" andClassName:NSStringFromClass([self class])]];
    [self setProne_Anim:[self loadPlistForAnimationWithName:@"Prone_Anim" andClassName:NSStringFromClass([self class])]];
    [self setCrouching_to_Standing:[self loadPlistForAnimationWithName:@"Crouching_to_Standing" andClassName:NSStringFromClass([self class])]];
    [self setProne_to_Standing:[self loadPlistForAnimationWithName:@"Prone_to_Standing" andClassName:NSStringFromClass([self class])]];
    //dying animations
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
        isFiring = false;
        squad_num = 0;
        sight_distance = 100;
        detection_distance = 100;
        point_value = 0;
        cover = kNoCover;
        movement_speed = 1;
        fire_rate = .5;
        leftover_time = 0;
        last_time = 0;
        ammo = 40;
        mags = 4;
        frame_count = 0;
        [self initAnimations];
        step_counter = 0;
        
    }
    
    return self;
}
-(void) applyJoystick:(SneakyJoystick*)aJoysick forTimeDelta:(float) deltaTime
{
    CGPoint scaledVelocity = ccpMult(aJoysick.velocity, self.movement_speed); 
    CGPoint oldPosition = [self position];
    CGPoint newPosition = ccp(oldPosition.x +scaledVelocity.x *deltaTime, oldPosition.y+ scaledVelocity.y * deltaTime);
    [self setPosition:newPosition];
    if(isFiring == FALSE)
    {
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
}

-(void) updateAI:(CCArray*)listOfGameObjects andDelta:(float) deltaTime
{
    
    //ai_target_info targets[5];
    //int target_count = 0;
    
    if(isMovingtoPoint)
    {
        [self movementUpdate:deltaTime];
        if([self numberOfRunningActions] == 0) [self changeState:kStateWalking];
    }
    /*
    if(isEnemySet)
    {
        [self attackUpdate:deltaTime];
    }
    else
    {
        [self chooseTarget:listOfGameObjects];
    }
     */
        [self checkCollisions:listOfGameObjects];
            if(isUnderAttack)
            {
                [self changeState: kStateProne];
            }
            
            if(!(isUnderAttack) && !(isEnemySet) && ([self numberOfRunningActions] == 0))
            {
               // CCLOG(@"Patrolling!");
                [self changeAIState:kStatePatrolling];
            }
                      
            
        
   // CCLOG(@"update AI ");
    //return kStateNone;
}
-(void) changeAIState:(AI_States)ai_state
{
    [self stopAllActions];
    //id action = nil;
    self.aiState = ai_state;
    switch(ai_state)
    {
        case kStatePatrolling:
              if(self.step_counter == 0)
              {
                  if(!(self.isMovingtoPoint)){
                  CGPoint current_pos = self.position;
                  CGPoint offset;
                  offset.x = current_pos.x + 200.0f;
                  offset.y = current_pos.y;
                  [self moveTo:offset];
                  self.step_counter ++;
                    /*  CCAction * moving;
                      CCAction *walking;
                     float time;
                      time = offset.x / self.movement_speed; 
                      moving = [CCMoveTo actionWithDuration:time position:offset];
                      walking = [CCAnimate actionWithAnimation:Walking_Anim restoreOriginalFrame:NO];
                      [self runAction:moving];
                      [self runAction:walking;
                    */  
                      CCLOG(@"patrolling right");
                  }
                  break;
              }
            if (self.step_counter == 1) {
                if(!(self.isMovingtoPoint)){
                  //  CGPoint current_pos = self.position;
                    CGPoint offset;
                    offset.x = self.position.x ;
                    offset.y = self.position.y + 200.0f;
                    [self moveTo:offset];
                    self.step_counter ++;
                    CCLOG(@"patrolling up");
                    
                }
                break;
            }
            if(self.step_counter == 2)
            {
                if(!(self.isMovingtoPoint)){
                    CGPoint current_pos = self.position;
                    CGPoint offset;
                    offset.x = current_pos.x - 200.0f;
                    offset.y = current_pos.y;
                    [self moveTo:offset];
                    self.step_counter ++;
                    CCLOG(@"patrolling left");
                }
                break;
                
            }
            if (self.step_counter == 3) {
                if(!(self.isMovingtoPoint)){
                    CGPoint current_pos = self.position;
                    CGPoint offset;
                    offset.x = current_pos.x ;
                    offset.y = current_pos.y - 200.0f;
                    [self moveTo:offset];
                    self.step_counter = 0;
                    CCLOG(@"patrolling down");
                }
                break;            
            }
           
            break;
        case kStateWaiting:
            break;
        case kStateMovingto:
            break;
        case kStateAttacking:
            break;
        case kStateRotating:
            break;
        case kStateDefending:
            break;
        case kStateSeekCover:
            break;
        case kStateRetreating:
            break;
            default:
            break;
    }
}
-(void)AIAttack:(float)deltaTime andTargetInfo:(NSInteger) target_tag
{
    CCLOG(@"Attacking!");
    frame_count++;
    self.last_time = deltaTime * frame_count;
    if (last_time >= kDefaultFireRate) {
        CCNode * target_char = [parent_ getChildByTag:target_tag];
        float x,y,daRotation;
        x = self.position.x - target_char.position.x;
        y = self.position.y - target_char.position.y;
        daRotation = sinf(x / y);
        [self setRotation:daRotation];
        if(self.ammo != 0){
            [delegate createBulletWithRotation:self.rotation andVelocity:kBulletSpeed andPosition:self.position andtag:self.tag];
            self.ammo = self.ammo -1;
            last_time = 0;
            frame_count = 0;
        }
        else
        {
            self.ammo = 40;
        }
        
       // [self changeState:kStateCrouching];
    }
    
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
        case kStateCrouchToStanding:
            action = [CCAnimate actionWithAnimation:Crouching_to_Standing restoreOriginalFrame:NO];
            break;
        case kStateProneToCrouch:
            action = [CCAnimate actionWithAnimation:Prone_to_Standing restoreOriginalFrame:NO];
            break;
        case kStateProneToStanding:
            action = [CCSequence actions:[CCAnimate actionWithAnimation:Prone_to_Standing restoreOriginalFrame:NO],[CCAnimate actionWithAnimation:Crouching_to_Standing restoreOriginalFrame:NO], nil];
        case kStateTakingDamage:
            CCLOG(@"Taking a hit!");
            self.characterHealth -= 10;
            break;
        case kStateDead:
            CCLOG(@"DEAD!!");
            [self setVisible:NO];
            [self removeFromParentAndCleanup:YES];
            break;
        default:
            CCLOG(@"ERROR: Undefined State! setting to standing");
            [self changeState:kStateStanding];
            [self setIsProne:NO];
            [self setIsCrouching:NO];
            break;
    }
    if(action !=nil)
    {
        [self runAction:action];
    }
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListofGameObjects:(CCArray *)listOfGameObjects
{
    if(self.characterState == kStateDead) return;
    if(self.characterHealth <=0)
    {
        [self changeState:kStateDead];
    }

    if(isPlayerControlled)
    {
    self.last_time = deltaTime;
    
    if(button_lock == YES)
    {
        if(frame_count < 10)
        {
             frame_count = frame_count +1;
        }
        else
        {
            frame_count = 0;
            button_lock = NO;
        }
    }
    
       /* if(self.isPlayerControlled == FALSE)
    {
        [self updateAI];
        return;
    }*/
    [self checkCollisions:listOfGameObjects];
    [self handleProneState];
    [self handleCrouchingState];
    if((self.isProne != YES) && (self.isCrouching != YES))
    {
        [self otherStates:deltaTime];
    }
    else
    {
        if((self.right_Joystick.velocity.x != 0) || (self.right_Joystick.velocity.y != 0))
        {
            [self setIsFiring:YES];
            [self handleShooting:right_Joystick forTime:deltaTime];
        }
        else
        {
            [self setIsFiring:NO];
        }

    }
    }
    else
    {
        [self checkCollisions:listOfGameObjects];
        [self updateAI:listOfGameObjects andDelta:deltaTime];
    }
    
}
-(void) checkCollisions: (CCArray *) listOfGameObjects
{
    
    CGRect DaBox = [self adjustedBoundingBox];
    for(GameCharacter * character in listOfGameObjects)
    {
        CGRect charBox = [character adjustedBoundingBox];
        if(CGRectIntersectsRect(DaBox, charBox))
        {
            if([character gameObjectType] == kBullet)
            {
                if(character.owner_tag != self.tag)
                {
                    [self setIsUnderAttack:YES];
                    [character changeState:kStateDead];
                    [self changeState:kStateTakingDamage];
                }
                
                //[self changeState:kStateTakingDamage];
                //[character changeState:kStateDead];
            }
            //movement restrictions can go here
        }
        
    }

}
-(void) handleProneState
{
    if(self.isProne)
    {
        if((prone_Button.active) && (button_lock == NO))
        {
            [self changeState:kStateCrouchToStanding];
            [self setIsProne:NO];
            [self setButton_lock:YES];
            CCLOG(@"Changing state to is NOT prone");
            return;
        }
        else
        {
            
            //do nothing
            return;
        }
    }
    else
        {
            if((prone_Button.active) && (button_lock == NO))
            {
                [self changeState:kStateProne];
                CCLOG(@"Changing state to is prone");
                [self setIsProne:YES];
                 [self setButton_lock:YES];
                return;
            }
            else
            {
                //do nothing
                return; 
            }
        }
    
}
-(void) handleCrouchingState
{
    if(self.isCrouching)
    {
        if((crouch_Button.active) &&(button_lock == NO))
        {
            if(self.isProne)
            {
                [self changeState:kStateProneToCrouch];
                [self setIsProne:NO];
                [self setIsCrouching:YES];
                 [self setButton_lock:YES];
                return;
            }
            else
            {
                [self changeState:kStateCrouchToStanding];
                [self setIsCrouching:NO];
                 [self setButton_lock:YES];
                return;
            }
        }
    }
    else
    {
        if((crouch_Button.active) && (button_lock == NO))
        {
            if(self.isProne)
            {
                [self changeState:kStateProneToCrouch];
                [self setIsProne:NO];
                [self setIsCrouching:YES];
                 [self setButton_lock:YES];
                return;
            }
            else
            {
                [self changeState:kStateCrouching];
                [self setIsCrouching:YES];
                 [self setButton_lock:YES];
                return;
            }
        }
    }
}
-(void) handleShooting:(SneakyJoystick*) aJoystick forTime:(float)deltaTime
{
    float rotation_factor;
    // CCLOG(@"%f", aJoysick.degrees);
    if((aJoystick.degrees <360) && (aJoystick.degrees >90))
    {
        rotation_factor = 450;
        rotation_factor = rotation_factor -  aJoystick.degrees ;
        
    }
    if ((aJoystick.degrees > 0) && (aJoystick.degrees < 90))
    {
        rotation_factor = 90;
        rotation_factor = rotation_factor - aJoystick.degrees;
    }
    
    
    [self setRotation:rotation_factor];
    
    
    if(self.ammo != 0)
    {
   // if(self.recoil != YES){
        frame_count++;
        self.last_time = deltaTime * frame_count;
        //CCLOG(@"Last time: %f, deltaTime: %f", last_time, deltaTime);
        if (last_time >= kDefaultFireRate) {
            [delegate createBulletWithRotation:self.rotation andVelocity:kBulletSpeed andPosition:self.position andtag:self.tag];
            CCLOG(@"Firing bullet with rotation: %f, speed: %i, at position: x: %f, y:%f", self.rotation, kBulletSpeed, self.position.x, self.position.y);
            self.ammo = self.ammo -1;
            last_time = 0;
            frame_count = 0;
        }
        /*[delegate createBulletWithRotation:self.rotation andVelocity:kBulletSpeed andPosition:self.position];
    CCLOG(@"Firing bullet with rotation: %f, speed: %i, at position: x: %f, y:%f", self.rotation, kBulletSpeed, self.position.x, self.position.y);
        self.ammo = self.ammo -1;*/
    }
    else if ((self.ammo == 0) && (self.mags != 0))
    {
        self.mags = self.mags - 1;
        self.ammo = 40;
    }
    else
    {
        CCLOG(@"NO AMMO!");
    }
      //  self.recoil = YES;
        
   // }
       // [delegate createBulletWithRotation:rotation_factor andVelocity:kBulletSpeed andPosition:self.position];
}
-(void) otherStates:(float) deltaTime
{
   /* if(self.recoil)
    {
        last_time = deltaTime + last_time;
        if(last_time > kDefaultFireRate)
        {
            CCLOG(@"setting recoil to NO");
            last_time = 0;
            self.recoil = NO;
        }
    }*/
    if((self.right_Joystick.velocity.x != 0) || (self.right_Joystick.velocity.y != 0))
    {
        [self setIsFiring:YES];
        [self handleShooting:right_Joystick forTime:deltaTime];
    }
    else
    {
        [self setIsFiring:NO];
    }

    if((self.characterState == kStateStanding) ||
       (self.characterState == kStateWalking) ||
       (self.characterState == kStateRunning))
    {
        if((self.left_Joystick.velocity.x != 0) || (self.left_Joystick.velocity.y != 0))
        {
            [self setIsProne:NO];
            [self setIsCrouching:NO];
            [self applyJoystick:left_Joystick forTimeDelta:deltaTime];
            if(( self.characterState != kStateWalking) || ([self numberOfRunningActions] == 0))
                [self changeState:kStateWalking];
            
        }
                //need to divide up apply joystick methods between running and walking
        else
        {
            if(self.characterState != kStateStanding)
            {
                [self changeState:kStateStanding];
                CCLOG(@"Changing state to standing!");
            }
        }
    }
    else if ((self.characterState == kStateCrouchToStanding) || (self.characterState == kStateProneToStanding))
    {
        if(button_lock == NO)
        {
            [self changeState:kStateStanding];
        }
    }
    
}

@end
