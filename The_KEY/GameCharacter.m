//
//  GameCharacter.m
//  The_KEY
//
//  Created by Nathan Jones on 10/8/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "GameCharacter.h"

@implementation GameCharacter
@synthesize characterState;
@synthesize characterHealth;

-(void) dealloc
{
    [super dealloc];
}

-(int)getWeaponDamage {
    //default to 0 damage
    CCLOG(@"getWeaponDamage should be overidden");
    return 0;
}

//use only if necessary, needs to be adjusted for plan view use as well
-(void) checkAndClampSpritePosition {
    CGPoint currentSpritePosition = [self position];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if(currentSpritePosition.x < 30.0f) {
            [self setPosition:ccp(30.0f, currentSpritePosition.y)];
            
        }
        else if(currentSpritePosition.x > 1000.0f)
        {
            [self setPosition:ccp(1000.0f, currentSpritePosition.y)];
        }
    }
    else
    {
        if(currentSpritePosition.x < 24.0f) {
            [self setPosition:ccp(24.0f, currentSpritePosition.y)];
            
        }
        else if(currentSpritePosition.x > 456.0f)
        {
            [self setPosition:ccp(456.0f, currentSpritePosition.y)];
        }
        
    }
}
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


@end
