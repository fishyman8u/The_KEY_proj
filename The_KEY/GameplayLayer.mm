//
//  GameplayLayer.m
//  The_KEY
//
//  Created by Nathan Jones on 10/2/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "GameplayLayer.h"


@implementation GameplayLayer
-(void) initJoystickAndButtons {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CGRect joystickBaseDimensions = CGRectMake(0, 0, 128.0f, 128.0f);
    CGRect crouchButtonDimensions = CGRectMake(0, 0, 64.0f, 64.0f);
    CGPoint right_joystick_base_position;
    CGPoint left_joystick_base_position;
    CGPoint crouch_button_position;
    CGPoint prone_button_position;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        CCLOG(@"Positioning Joystick and Buttons for ipad");
        left_joystick_base_position = ccp(screenSize.width * 0.152f, screenSize.height * 0.152f);
        right_joystick_base_position = ccp(screenSize.width * 0.851f, screenSize.height *0.152f);
        crouch_button_position = ccp(screenSize.width * 0.85f, screenSize.height * 0.052f);
        prone_button_position = ccp(screenSize.width * 0.60f, screenSize.height * 0.052f);
        
    }else
    {
        CCLOG(@"Positioning Joystick and Buttons for iphone");
        left_joystick_base_position = ccp(screenSize.width * 0.07f, screenSize.height * 0.11f);
        right_joystick_base_position = ccp(screenSize.width * 0.93f, screenSize.height *0.11f);
        crouch_button_position = ccp(screenSize.width * 0.85f, screenSize.height * 0.11f);
        prone_button_position = ccp(screenSize.width * 0.60f, screenSize.height * 0.011f);
    }
    //right joystick
    SneakyJoystickSkinnedBase *r_joystick_base = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    r_joystick_base.position = right_joystick_base_position;
    r_joystick_base.backgroundSprite = [CCSprite spriteWithFile:@"Joystick_base-01.png"];
    r_joystick_base.thumbSprite = [CCSprite spriteWithFile:@"Joystick_Cross_Hairs-01.png"];
    r_joystick_base.joystick = [[SneakyJoystick alloc] initWithRect:joystickBaseDimensions];
    rightJoystick = [r_joystick_base.joystick retain];
    [self addChild:r_joystick_base];
    //left joystick
    SneakyJoystickSkinnedBase *l_joystick_base = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    l_joystick_base.position = left_joystick_base_position;
    l_joystick_base.backgroundSprite = [CCSprite spriteWithFile:@"Joystick_base-01.png"];
    l_joystick_base.thumbSprite = [CCSprite spriteWithFile:@"Joystick_Cross_Hairs-01.png"];
    l_joystick_base.joystick = [[SneakyJoystick alloc] initWithRect:joystickBaseDimensions];
    leftJoystick = [l_joystick_base.joystick retain];
    [self addChild:l_joystick_base];
    //sneaky button
    SneakyButtonSkinnedBase *crouch_button_base = [[[SneakyButtonSkinnedBase alloc]init]autorelease];
    crouch_button_base.position = crouch_button_position;
    crouch_button_base.defaultSprite = [CCSprite spriteWithFile:@"button_base-01.png"];
    crouch_button_base.activatedSprite = [CCSprite spriteWithFile:@"Button_Pressed-01.png"];
    crouch_button_base.pressSprite = [CCSprite spriteWithFile:@"Button_Pressed-01.png"];
    crouch_button_base.button = [[SneakyButton alloc] initWithRect:crouchButtonDimensions];
    crouchButton = [crouch_button_base.button retain];
    [self addChild:crouch_button_base];
    
    SneakyButtonSkinnedBase *prone_button_base = [[[SneakyButtonSkinnedBase alloc]init]autorelease];
    prone_button_base.position = prone_button_position;
    prone_button_base.defaultSprite = [CCSprite spriteWithFile:@"button_base-01.png"];
    prone_button_base.activatedSprite = [CCSprite spriteWithFile:@"Button_Pressed-01.png"];
    prone_button_base.pressSprite = [CCSprite spriteWithFile:@"Button_Pressed-01.png"];
    prone_button_base.button = [[SneakyButton alloc] initWithRect:crouchButtonDimensions];
    proneButton = [prone_button_base.button retain];
    [self addChild:prone_button_base];
    
}

-(id) init
{
    self = [super init];
    if(self != nil)
    {
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
        [self addChild:sceneSpriteBatchNode z:0];
        [self initJoystickAndButtons];
        AFC * marine = [[AFC alloc]initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"AFC1.png"]];
        [marine setLeft_Joystick:leftJoystick];
        [marine setRight_Joystick:rightJoystick];
        [marine setCrouch_Button:crouchButton];
        [marine setProne_Button:proneButton];
        [marine setTeam:kUSAF];
        [marine setIsPlayerControlled:YES];
        [marine setDelegate:self];
        [marine setPosition:ccp(screenSize.width *0.5f,screenSize.height *0.5f)];
        [marine setCharacterHealth:100.0f];
        [marine setMovement_speed:30.0f];
        [marine setIsProne:NO];
        [marine setIsCrouching:NO];
        [crouchButton setIsHoldable:NO];
        [proneButton setIsHoldable:NO];
        //[crouchButton setIsToggleable:YES];
        //[proneButton setIsToggleable:YES];
        [sceneSpriteBatchNode addChild:marine z:kAFC_Player_Z_Value tag:kAFC_Player_TagValue];
        
        
        
        //test enemy
        AFC * marine_opp_for =  [[AFC alloc]initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"AFC1.png"]];
        [marine_opp_for setIsPlayerControlled:NO];
        [marine_opp_for setTeam:kDusan];
        [marine_opp_for setDelegate:self];
        [marine_opp_for setPosition:ccp(screenSize.width *0.60f,screenSize.height *0.60f)];
        [marine_opp_for setCharacterHealth:100.0f];
        [marine_opp_for setMovement_speed:30.0f];
        [marine_opp_for setSight_distance:400.0f];
        [sceneSpriteBatchNode addChild:marine_opp_for z:99];
        
        CCLabelTTF *beginLabel = [CCLabelTTF labelWithString:@"Game Start!" fontName:@"Helvetica" fontSize:64];
        [beginLabel setPosition:ccp(screenSize.width/2,screenSize.height/2)];
        [self addChild:beginLabel];
        id label_action = [CCSpawn actions:[CCScaleBy actionWithDuration:2.0f scale:4], [CCFadeOut actionWithDuration:2.0f],nil];
        [beginLabel runAction:label_action];
        [self scheduleUpdate];
    }
    return self;
}
-(void) applyJoystick:(SneakyJoystick*)aJoystick toNode:(CCNode*)tempNode forTimeDelta:(float)deltaTime
{
    CGPoint scaledVelocity = ccpMult(aJoystick.velocity, 1024.0f);
    
    CGPoint newPosition = ccp(tempNode.position.x + scaledVelocity.x * deltaTime, tempNode.position.y + scaledVelocity.y * deltaTime);
    
    [tempNode setPosition:newPosition];
    
    if(crouchButton.active == YES)
    {
        CCLOG(@"Crouch button is ACTIVE");
    }
}
-(void)update:(ccTime)deltaTime
{
    CCArray *listOfGameObjects = [sceneSpriteBatchNode children];
    for (GameCharacter *tempChar in listOfGameObjects) {
        [tempChar updateStateWithDeltaTime:deltaTime andListofGameObjects:listOfGameObjects];
    //[self applyJoystick:leftJoystick toNode:af_marine forTimeDelta:deltaTime];
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
    [Bullet changeState:kStateSpawning];
    [Bullet setRotation:rotation];
    [sceneSpriteBatchNode addChild:Bullet];
    [Bullet release];
}
@end
