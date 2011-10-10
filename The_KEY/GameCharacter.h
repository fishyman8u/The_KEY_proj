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
}

-(void) checkAndClampSpritePosition;
-(int)getWeaponDamage;
@property(readwrite) int characterHealth;
@property(readwrite) CharacterStates characterState;
@end
