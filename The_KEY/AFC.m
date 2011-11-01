//
//  AFC.m
//  The_KEY
//
//  Created by Nathan Jones on 10/8/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "AFC.h"

@implementation AFC


- (void) dealloc
{
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


-(CGRect) adjustedBoundingBox
{
    CGRect placeholder = [self boundingBox];
    
    
    return placeholder;
}
- (id)init
{
    self = [super init];
    if (self) {
        self.gameObjectType = kAFC;
        [self setCharacterHealth:100];
        angle_adjustment = 0;
        //self.flipY = YES;
        //self.flipX = YES;
    }
    
    return self;
}

@end
