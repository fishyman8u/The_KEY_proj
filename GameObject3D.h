//
//  GameObject3D.h
//  The_KEY
//
//  Created by Nathan Jones on 10/30/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "CC3MeshNode.h"
#import "CC3PODMeshNode.h"
#import "cocos2d.h"
#import "Constants.h"
#import "CommonProtocols.h"
//#import "btBulletDynamicsCommon.h"

@interface GameObject3D : CC3PODMeshNode
{
    BOOL isActive;
    GameObjectType gameObjectType;
}
-(void) changeState:(CharacterStates) newState;
-(void) updateStateWithDeltaTime:(ccTime)deltaTime
            andListofGameObjects:(CCArray*)listOfGameObjects;
@property(readwrite) BOOL isActive;
@property(readwrite) GameObjectType gameObjectType;
//physics
//animation loading

@end
