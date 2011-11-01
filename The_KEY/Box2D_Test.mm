//
//  Box2D_Test.m
//  The_KEY
//
//  Created by Nathan Jones on 10/31/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "Box2D_Test.h"

@implementation Box2D_Test

+(id) scene
{
    CCScene *scene = [CCScene node];
    Box2D_Test * box2dTest = [self node];
    [scene addChild:box2dTest];
    return scene;
}
- (id)init
{
    self = [super init];
    if (self) {
        CGSize winsize = [CCDirector sharedDirector].winSize;
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Testing BOX2d system" fontName:@"Helvetica" fontSize:32];
        label.position = ccp(winsize.width/2, winsize.height/2);
        [self addChild:label];
    }
    
    return self;
}

@end
