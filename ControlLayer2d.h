//
//  ControlLayer2d.h
//  The_KEY
//
//  Created by Nathan Jones on 10/24/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "CCLayer.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"

@interface ControlLayer2d : CCLayer
{
    SneakyJoystick *leftJoystick;
    SneakyJoystick *rightJoystick;
    SneakyButton *crouchButton;
    SneakyButton *proneButton;
}
@property (nonatomic, readonly) SneakyJoystick * leftJoystick;
@property (nonatomic, readonly) SneakyJoystick * rightJoystick;
@property (nonatomic, readonly) SneakyButton * crouchButton;
@property (nonatomic, readonly) SneakyButton * proneButton;

@end
