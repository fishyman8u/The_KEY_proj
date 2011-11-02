//
//  BackgroundLayer.m
//  The_KEY
//
//  Created by Nathan Jones on 10/2/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "BackgroundLayer.h"


@implementation BackgroundLayer
-(id)init {
    self = [super init];
    if(self != nil)
    {
        CCSprite *backgroundImage;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            //override with iPad specific background
            backgroundImage = [CCSprite spriteWithFile:@"ipad_back_test_portrait-01.png"];
        }
        else
        {
            //override with iPhone Specific Background
          backgroundImage = [CCSprite spriteWithFile:@"rocky_soil 1.png"];  
        }
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
         [self addChild:backgroundImage z:0 tag:0];
    }
         return self;
}
@end
