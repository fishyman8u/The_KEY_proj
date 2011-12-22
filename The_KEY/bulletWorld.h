//
//  bulletWorld.h
//  The_KEY
//
//  Created by Nathan Jones on 11/5/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "CC3World.h"
#import "GameObject3D.h"
#import "btBulletDynamicsCommon.h"
#import "CC3Light.h"
#import "CC3Layer.h"
#import "CC3Foundation.h"
#import "CC3MeshNode.h"

@interface bulletWorld : CC3World
{
    btDiscreteDynamicsWorld * dynamicsWorld;
    //create a controllable camera for space flight
    //attach a collision body to the camera to similate ship
    //attach controls to the camera
    //add other ships with collision bodies
    CC3Camera *camera;
    CC3MeshNode *hellfire;
    
    bool reset;
    int steps;
}

@end
