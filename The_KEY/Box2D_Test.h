//
//  Box2D_Test.h
//  The_KEY
//
//  Created by Nathan Jones on 10/31/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "Constants.h"
#import "CommonProtocols.h"

@interface Box2D_Test : CCLayer
{
    b2World *world;
    GLESDebugDraw *debugDraw;
}
+(id)scene;

@end
