//
//  bulletWorld.m
//  The_KEY
//
//  Created by Nathan Jones on 11/5/11.
//  Copyright (c) 2011 Student. All rights reserved.
//
extern "C" {
#import "CC3Foundation.h"
};
#import "bulletWorld.h"
#import "CC3PODResourceNode.h"
#import "CC3ActionInterval.h"
#import "CC3MeshNode.h"
#import "CC3Camera.h"
#import "CC3Light.h"

@implementation bulletWorld
-(void) initializeWorld
{
    //cc3v
    self.isTouchEnabled = NO;
    camera = [CC3Camera nodeWithName:@"Camera"];
    camera.location = CC3VectorMake(0, 0, 0);
    [self addChild:camera];
    
    CC3Light * light = [CC3Light nodeWithName:@"Light"];
    [light setLocation:CC3VectorMake(0, 0, 0)];
    
    light.isDirectionalOnly = NO;
    [camera addChild:light];
    //initialize bullet
   btBroadphaseInterface * broadPhase = new btDbvtBroadphase();
    btDefaultCollisionConfiguration* collisionConfiguration = new btDefaultCollisionConfiguration();
    btCollisionDispatcher *dispatcher = new btCollisionDispatcher(collisionConfiguration);
    btSequentialImpulseConstraintSolver * solver = new btSequentialImpulseConstraintSolver();
    dynamicsWorld = new btDiscreteDynamicsWorld(dispatcher,broadPhase,solver, collisionConfiguration);
    dynamicsWorld->setGravity(btVector3(0, -10.0, 0));
    
    [self createGLBuffers];
    [self releaseRedundantData];
    //add content below here
    
    //Phase 1: manual test adding
    //Phase 2: Plist object adding
    //Phase 3: level Plist loading
    
    
    //schedule update
    
    //set default variable values
    reset = NO;
    steps = 0;
    
}
-(void) update:(ccTime)deltaTime
{
    
}
-(void) updatePhysics:(ccTime)deltaTime
{
    
}
@end
