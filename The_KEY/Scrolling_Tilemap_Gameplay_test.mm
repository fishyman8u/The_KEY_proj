//
//  Scrolling_Tilemap_Gameplay_test.m
//  The_KEY
//
//  Created by Nathan Jones on 10/24/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "Scrolling_Tilemap_Gameplay_test.h"

@implementation Scrolling_Tilemap_Gameplay_test
/*-(void) addScrollingBackground {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGSize levelSize = [[GameManager sharedGameManager] getDimensionsOfCurrentScene]; 
}*/
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
- (id)init
{
    self = [super init];
    if (self) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        self.isTouchEnabled = YES;
        srandom(time(NULL));
        
        //af_marine = [CCSprite spriteWithFile:@"AF_Commando_1-01.png"];
        //  [af_marine setPosition:CGPointMake(screenSize.width/2, screenSize.height*0.17f)];
        //   [self addChild:af_marine];
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            //[af_marine setScaleX:screenSize.width/1024.0f];
            //[af_marine setScaleY:screenSize.height/768.0f];
            [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"Standins Sheet_default.plist"];
            sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"Standins Sheet_default.png"];
        }
        else
        {
            [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"Standins Sheet_default.plist"];
            sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"Standins Sheet_default.png"];
        }
        [self addChild:sceneSpriteBatchNode z:100];
        //[self initJoystickAndButtons];
        AFC * marine = [[AFC alloc]initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"AFC1.png"]];
        [marine setLeft_Joystick:nil];
        [marine setRight_Joystick:nil];
        [marine setCrouch_Button:nil];
        [marine setProne_Button:nil];
        [marine setTeam:kUSAF];
        [marine setIsPlayerControlled:YES];
        [marine setDelegate:self];
        [marine setPosition:ccp(screenSize.width *0.5f,screenSize.height *0.5f)];
        [marine setCharacterHealth:100.0f];
        [marine setMovement_speed:90.0f];
        [marine setIsProne:NO];
        [marine setIsCrouching:NO];
       
       // [crouchButton setIsHoldable:NO];
        //[proneButton setIsHoldable:NO];
        //[crouchButton setIsToggleable:YES];
        //[proneButton setIsToggleable:YES];
        [sceneSpriteBatchNode addChild:marine z:1000 tag:kAFC_Player_TagValue];
        
        
        
        //test enemy
        AFC * marine_opp_for =  [[AFC alloc]initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"AFC1.png"]];
        [marine_opp_for setIsPlayerControlled:NO];
        [marine_opp_for setTeam:kDusan];
        [marine_opp_for setDelegate:self];
        [marine_opp_for setPosition:ccp(screenSize.width *0.60f,screenSize.height *0.60f)];
        [marine_opp_for setCharacterHealth:100.0f];
        [marine_opp_for setMovement_speed:90.0f];
        [marine_opp_for setSight_distance:400.0f];
        [sceneSpriteBatchNode addChild:marine_opp_for z:999];
        
        CCLabelTTF *beginLabel = [CCLabelTTF labelWithString:@"Game Start!" fontName:@"Helvetica" fontSize:64];
        [beginLabel setPosition:ccp(screenSize.width/2,screenSize.height/2)];
        [self addChild:beginLabel];
        id label_action = [CCSpawn actions:[CCScaleBy actionWithDuration:2.0f scale:4], [CCFadeOut actionWithDuration:2.0f],nil];
        [beginLabel runAction:label_action];
        
        [self addScrollingBackgroundWithTilemap];
        [self scheduleUpdate];

    }
    
    return self;
}
-(void) connectControlsWithRightJoystick:(SneakyJoystick*) rightJoystick 
                         andLeftJoystick:(SneakyJoystick*)leftJoystick
                          andProneButton:(SneakyButton*)proneButton
                         andCrouchButton:(SneakyButton*)crouchButton
{
    AFC * player_afc = (AFC *) [sceneSpriteBatchNode getChildByTag:kAFC_Player_TagValue];
    [player_afc setRight_Joystick:rightJoystick];
    [player_afc setLeft_Joystick:leftJoystick];
    [player_afc setCrouch_Button:crouchButton];
    [player_afc setProne_Button:proneButton];
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
-(void) update:(ccTime)deltaTime
{
    CCArray *listOfGameObjects = [sceneSpriteBatchNode children];
    
    for (GameCharacter *tempChar in listOfGameObjects) {
        [tempChar updateStateWithDeltaTime:deltaTime andListofGameObjects:listOfGameObjects];
    }
    //id follow_action = [CCFollow actionWithTarget:[self getChildByTag:kAFC_Player_TagValue]];
   // [self runAction:follow_action];
    [self adjustLayer];
    //check if player is dead
    GameCharacter * player = (GameCharacter*) [sceneSpriteBatchNode getChildByTag:kAFC_Player_TagValue];
    if(([player characterState] == kStateDead) && ([player numberOfRunningActions] == 0))
    {
        [[GameManager sharedGameManager] setHasPlayerDied:YES];
        [[GameManager sharedGameManager] runSceneWithID:kLevelCompleteScene];
    }
}
-(void) createBulletWithRotation:(float)rotation andVelocity:(float)velocity andPosition:(CGPoint)spawnPosition andtag:(int)tag1
{
    CCLOG(@"Creating bullet");
    bullet *Bullet = [[bullet alloc] initWithSpriteFrameName:@"bullet1.png"];
    [Bullet setPosition:spawnPosition];
    [Bullet setOwner_tag:tag1];
    float x,y, rad_rotation_y, rad_rotation_x;
    rad_rotation_y = (rotation+90) * RadianConvert;
    rad_rotation_x = (rotation-90) * RadianConvert;
    
    y = velocity * sinf(rad_rotation_y);
    x = velocity * cosf(rad_rotation_x);
    [Bullet setXVelocity:x];
    [Bullet setYVelocity:y];
    [Bullet changeState:kStateSpawning];
    [Bullet setRotation:rotation];
    [sceneSpriteBatchNode addChild:Bullet z:100];
    [Bullet release];
}
-(void) createObjectOfType:(GameObjectType)objectType withHealth:(int)initialHealth atLocation:(CGPoint)spawnLocation withZValue:(int)Zvalue
{
    /*if(objectType == kBullet)
     {
     CCLOG(@"Creating bullet object.");
     bullet *aBullet = [[bullet alloc] initWithSpriteFrameName:@"bullet1.png"];
     }*/
    if(objectType == kAFC)
    {
        CCLOG(@"Creating AFC object.");
        AFC *aAFC = [[AFC alloc] initWithSpriteFrameName:@"AFC1.png"];
        [aAFC setCharacterHealth:initialHealth];
        [aAFC setPosition:spawnLocation];
        [sceneSpriteBatchNode addChild:aAFC z:Zvalue];
        [aAFC setDelegate:self];
        [aAFC release];
    }
}


@end
