//
//  Scrolling_Tilemap_Gameplay_test.h
//  The_KEY
//
//  Created by Nathan Jones on 10/24/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "CCLayer.h"
#import "Generic_Soldier.h"
#import "AFC.h"
#import "cocos2d.h"
#import "ControlLayer2d.h"
#import "GameManager.h"
#import "bullet.h"

@interface Scrolling_Tilemap_Gameplay_test : CCLayer <GameplayLayerDelegate>
{
    CCSpriteBatchNode *sceneSpriteBatchNode;
    CCTMXTiledMap *tileMapNode;
}
-(void) connectControlsWithRightJoystick:(SneakyJoystick*) rightJoystick 
andLeftJoystick:(SneakyJoystick*)leftJoystick
andProneButton:(SneakyButton*)proneButton
                         andCrouchButton:(SneakyButton*)crouchButton;
@end
