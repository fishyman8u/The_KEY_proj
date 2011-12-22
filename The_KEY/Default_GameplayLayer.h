//
//  Default_GameplayLayer.h
//  The_KEY
//
//  Created by Nathan Jones on 11/8/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "CCLayer.h"
#import "CCLayer.h"
#import "CommonProtocols.h"
#import "Constants.h"
#import "SneakyJoystick.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystickSkinnedBase.h"
#import "cocos2d.h"
#import "AFC.h"
#import "bullet.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "GameManager.h"

@interface Default_GameplayLayer : CCLayer <GameplayLayerDelegate>
{
    b2World *world;
    GLESDebugDraw *debugDraw;
    b2Body *groundBody;
    CCSpriteBatchNode *sceneSpriteBatchNode;
}
@property(assign, readwrite) b2World *world;
-(void) connectControlsWithRightJoystick:(SneakyJoystick*) rightJoystick 
                         andLeftJoystick:(SneakyJoystick*)leftJoystick
                          andProneButton:(SneakyButton*)proneButton
                         andCrouchButton:(SneakyButton*)crouchButton;
@end
