//
//  Default_Tile_Layer.m
//  The_KEY
//
//  Created by Nathan Jones on 11/8/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "Default_Tile_Layer.h"
#import "GameManager.h"
@implementation Default_Tile_Layer
@synthesize delegate;
//add a way to load a specific tilemap to a level
-(void)addScrollingBackgroundWithTilemap
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        tileMapNode = [CCTMXTiledMap 
                       tiledMapWithTMXFile:@"test_tileset_2.tmx"];
    } else {
        tileMapNode = [CCTMXTiledMap 
                       tiledMapWithTMXFile:@"test_tileset_2.tmx"];
    }
    
    [self addChild:tileMapNode z:0];
    
}

-(void) adjustLayer
{
    AFC * player_afc = (AFC *) [sceneSpriteBatchNode getChildByTag:kAFC_Player_TagValue];
    float player_Xposition = player_afc.position.x;
    float player_Yposition = player_afc.position.y;
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    float halfOfScreenX = screenSize.width /2;
    float halfOfScreenY = screenSize.height /2;
    CGSize levelSize = [[GameManager sharedGameManager] getDimensionsOfCurrentScene];
    float newXPosition, newYPosition;
    if((player_Xposition > halfOfScreenX) && (player_Xposition < (levelSize.width -halfOfScreenX))) {
        newXPosition = halfOfScreenX - player_Xposition;
    }
    else 
    {
        newXPosition = self.position.x;
    }
    if((player_Yposition > halfOfScreenY) && (player_Yposition < (levelSize.height -halfOfScreenY))) {
        newYPosition = halfOfScreenY - player_Yposition;
    }
    else
    {
        newYPosition = self.position.y;
    }
    [self setPosition:ccp(newXPosition, newYPosition)];
    
}
-(void)update:(ccTime)deltaTime
{
    [self adjustLayer];
}

-(id) init
{
    if ([super init] !=nil)
    {
        [self addScrollingBackgroundWithTilemap];
        [self scheduleUpdate];
        
    }
    return self;
}
@end
