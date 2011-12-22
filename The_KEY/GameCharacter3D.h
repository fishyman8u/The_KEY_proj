//
//  GameCharacter3D.h
//  The_KEY
//
//  Created by Nathan Jones on 11/6/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "GameObject3D.h"
#import "btBulletDynamicsCommon.h"
#import "CommonProtocols.h"
#import "Constants.h"

@interface GameCharacter3D : GameObject3D
{
    btCollisionShape *collisionShape;
    btCollisionWorld *world;
    
    AI_States characterAIState;
    int owner_tag;
    int team;
    NSString *pod_resource_file_name;
    NSString *plist_info;
}
@end
