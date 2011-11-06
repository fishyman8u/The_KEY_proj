//
//  Box2D_Test.m
//  The_KEY
//
//  Created by Nathan Jones on 10/31/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "Box2D_Test.h"
#import "Box2D.h"
@implementation Box2D_Test

+(id) scene
{
    CCScene *scene = [CCScene node];
    Box2D_Test * box2dTest = [self node];
    [scene addChild:box2dTest];
    return scene;
}
-(void) setupWorld
{
    b2Vec2 gravity = b2Vec2(0.0f, -10.0f);
    bool doSleep = true;
    world = new b2World(gravity, doSleep);
}

-(void)createBoxAtLocation:(CGPoint) location withSize:(CGSize) size
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = b2Vec2(location.x/PTM_RATIO, location.y / PTM_RATIO);
    //bodyDef.position = b2Vec2(location.x/PTM_RATIO, location.y / PTM_RATIO);
    b2Body *body= world->CreateBody(&bodyDef);
    
    b2PolygonShape shape;
    shape.SetAsBox(size.width/2/PTM_RATIO, size.height/2/PTM_RATIO);
    
    b2FixtureDef fixturedef;
    fixturedef.shape = &shape;
    fixturedef.density = 1.0;
    body->CreateFixture(&fixturedef);
    
}
-(void)setupDebugDraw
{
    debugDraw = new GLESDebugDraw(PTM_RATIO * [[CCDirector sharedDirector]contentScaleFactor]);
    world->SetDebugDraw(debugDraw);
    debugDraw->SetFlags(b2DebugDraw::e_shapeBit);
}
-(void)draw
{
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_COLOR_ARRAY);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    world->DrawDebugData();
    glEnable(GL_TEXTURE_2D);
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
}
-(void)createGround
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    float32 margin = 10.0f;
    b2Vec2 lowerLeft = b2Vec2(margin/ PTM_RATIO, margin/PTM_RATIO);
    b2Vec2 lowerRight = b2Vec2((winSize.width-margin)/PTM_RATIO, margin/PTM_RATIO);
    b2Vec2 upperRight = b2Vec2((winSize.width-margin)/PTM_RATIO, (winSize.height-margin)/PTM_RATIO);
     b2Vec2 upperLeft = b2Vec2(margin/PTM_RATIO, (winSize.height-margin)/PTM_RATIO);
    b2BodyDef groundBodydef;
    groundBodydef.type = b2_staticBody;
    groundBodydef.position.Set(0, 0);
    groundBody = world->CreateBody(&groundBodydef);
    b2PolygonShape groundShape;
    b2FixtureDef groundFixtureDef;
    groundFixtureDef.shape =&groundShape;
    groundFixtureDef.density = 0.0;
    groundShape.SetAsEdge(lowerLeft, lowerRight);
    groundBody->CreateFixture(&groundFixtureDef);
    groundShape.SetAsEdge(lowerRight, upperRight);
    groundBody->CreateFixture(&groundFixtureDef);
    groundShape.SetAsEdge(upperLeft, upperRight);
    groundBody->CreateFixture(&groundFixtureDef);
    groundShape.SetAsEdge(lowerLeft, upperLeft);
    groundBody->CreateFixture(&groundFixtureDef);
}
-(void) dealloc
{
    if(world){
        delete world;
        world = NULL;
        
        
    }
    if(debugDraw){
    delete debugDraw;
    debugDraw = nil;
    }
    [super dealloc];
}
- (id)init
{
    self = [super init];
    if (self) {
        [self setupWorld];
        [self setupDebugDraw];
        [self scheduleUpdate];
        self.isTouchEnabled = YES;
        CGSize winsize = [CCDirector sharedDirector].winSize;
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Testing BOX2d system" fontName:@"Helvetica" fontSize:32];
        label.position = ccp(winsize.width/2, winsize.height/2);
        [self addChild:label];
        [self createGround];
    }
    
    return self;
}
-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}
-(void)update:(ccTime)dt{
    int32 velocityIterations = 3;
    int32 postionInterations = 2;
    world->Step(dt, velocityIterations, postionInterations);
}
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView:[touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    b2Vec2 locationWorld = b2Vec2(touchLocation.x/PTM_RATIO, touchLocation.y/PTM_RATIO);
    [self createBoxAtLocation:touchLocation withSize:CGSizeMake(50, 50)];
    return TRUE;
}
@end
