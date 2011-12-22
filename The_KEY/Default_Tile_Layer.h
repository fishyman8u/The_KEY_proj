//
//  Default_Tile_Layer.h
//  The_KEY
//
//  Created by Nathan Jones on 11/8/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "AFC.h"
#import "CommonProtocols.h"
#import "Constants.h"

@interface Default_Tile_Layer : CCLayer
{
    CCSpriteBatchNode *sceneSpriteBatchNode;
    CCTMXTiledMap *tileMapNode;

}
@property(nonatomic, assign) id <GameplayLayerDelegate> delegate;
@end
