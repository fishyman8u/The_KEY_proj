//
//  GameObject3D.h
//  The_KEY
//
//  Created by Nathan Jones on 10/30/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "CC3MeshNode.h"
#import "cocos2d.h"
#import "Constants.h"
#import "CommonProtocols.h"

@interface GameObject3D : CC3MeshNode
{
    BOOL isActive;
    GameObjectType gameObjectType;
}
-(void) changeState:(CharacterStates) newState;
-(void) updateStateWithDeltaTime:(ccTime)deltaTime
            andListofGameObjects:(CCArray*)listOfGameObjects;

//physics
//animation loading

@end
