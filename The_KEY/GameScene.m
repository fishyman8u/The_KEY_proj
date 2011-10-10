//
//  GameScene.m
//  The_KEY
//
//  Created by Nathan Jones on 10/2/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene
-(id) init
{
    self = [super init];
    if(self != nil)
    {
        BackgroundLayer * backgroundLayer = [BackgroundLayer node];
        [self addChild:backgroundLayer z:0];
        GameplayLayer * gameplayLayer = [GameplayLayer node];
        [self addChild:gameplayLayer z:5];
       
        
    }
    return self;
}
@end
