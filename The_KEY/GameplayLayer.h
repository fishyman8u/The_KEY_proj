//
//  GameplayLayer.h
//  The_KEY
//
//  Created by Nathan Jones on 10/2/11.
//  Copyright 2011 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SneakyJoystick.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystickSkinnedBase.h"
#import "AFC.h"
#import "CommonProtocols.h"
#import "Constants.h"

@interface GameplayLayer : CCLayer {
    CCSprite *af_marine;
    SneakyJoystick *leftJoystick;
    SneakyJoystick *rightJoystick;
    SneakyButton *crouchButton;
    SneakyButton *proneButton;
    //SneakyButton *attackButton;
    CCSpriteBatchNode *sceneSpriteBatchNode;
}

@end
