//
//  Default_GameplayLayer.m
//  The_KEY
//
//  Created by Nathan Jones on 11/8/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "Default_GameplayLayer.h"
#import "GameManager.h"
@implementation Default_GameplayLayer
@synthesize world;
-(void) loadLevelObjects
{
    //loading level objects goes here
    //should setup a delegate that can get objects from the tilemap layer when it loads
}
-(void) setupWorld
{
    b2Vec2 gravity = b2Vec2(0.0f, 0.0f);
    bool doSleep = true;
    world = new b2World(gravity, doSleep);
}

-(void)setupDebugDraw
{
    debugDraw = new GLESDebugDraw(PTM_RATIO * [[CCDirector sharedDirector]contentScaleFactor]);
    world->SetDebugDraw(debugDraw);
    debugDraw->SetFlags(b2DebugDraw::e_shapeBit);
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setupWorld];
        //[self setupDebugDraw];
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
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        AFC * marine = [[AFC alloc]initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"AFC1.png"]];
       // [marine setTag:kAFC_Player_TagValue];
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
        [sceneSpriteBatchNode addChild:marine z:1000 tag:kAFC_Player_TagValue];
        [self scheduleUpdate];
        self.isTouchEnabled = YES;
        CGSize winsize = [CCDirector sharedDirector].winSize;
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Testing BOX2d system" fontName:@"Helvetica" fontSize:32];
        label.position = ccp(winsize.width/2, winsize.height/2);
        [self addChild:label];
        //[self createGround];
    }
    
    return self;
}

-(void)update:(ccTime)dt{
    static double UPDATE_INTERVAL = 1.0f/60.0f;
    static double MAX_CYCLES_PER_FRAME = 5;
    static double timeAccumulator = 0;
    
    timeAccumulator += dt;    
    if (timeAccumulator > (MAX_CYCLES_PER_FRAME * UPDATE_INTERVAL)) {
        timeAccumulator = UPDATE_INTERVAL;
    }    
    
    int32 velocityIterations = 3;
    int32 positionIterations = 2;
    while (timeAccumulator >= UPDATE_INTERVAL) {        
        timeAccumulator -= UPDATE_INTERVAL;        
        world->Step(UPDATE_INTERVAL, 
                    velocityIterations, positionIterations);        
    }
    for (b2Body *b=world->GetBodyList(); b!=NULL; b=b->GetNext()) {
        if (b->GetUserData() != NULL) {
            GameCharacter *sprite = (GameCharacter *) b->GetUserData();
            sprite.position = ccp(b->GetPosition().x * PTM_RATIO, 
                                  b->GetPosition().y * PTM_RATIO);
            sprite.rotation = 
            CC_RADIANS_TO_DEGREES(b->GetAngle() * -1);
        }
        //update states of objects HERE
        CCArray *listOfGameObjects = [sceneSpriteBatchNode children];
        for (GameCharacter *tempChar in listOfGameObjects) {
            [tempChar updateStateWithDeltaTime:dt andListofGameObjects:listOfGameObjects];
            //[self applyJoystick:leftJoystick toNode:af_marine forTimeDelta:deltaTime];
        }  
        //ai update here
    }
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
    [Bullet setAngular_velocity:b2Vec2(x, y)];
    [Bullet changeState:kStateSpawning];
    [Bullet setRotation:rotation];
    [sceneSpriteBatchNode addChild:Bullet];
    [Bullet release];
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
-(b2World*)getRefToWorld
{
    b2World * pointer;
    pointer = self.world;
    return pointer;
}
@end
