//
//  GameObject.h
//  The_KEY
//
//  Created by Nathan Jones on 10/8/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"

#import "Constants.h"
#import "CommonProtocols.h"

@interface GameObject : CCSprite
{
    BOOL isActive;
    BOOL reactsToScreenBoundaries;
    CGSize screenSize;
    GameObjectType gameObjectType;
}
@property (readwrite) BOOL isActive;
@property (readwrite) BOOL reactsToScreenBoundaries;
@property (readwrite) CGSize screenSize;
@property (readwrite) GameObjectType gameObjectType;

-(void) changeState:(CharacterStates)newState;
-(void) updateStateWithDeltaTime:(ccTime)deltaTime
            andListofGameObjects:(CCArray*)listOfGameObjects;
-(CGRect)adjustedBoundingBox;
-(CCAnimation*)loadPlistForAnimationWithName:(NSString*)animationName
                                andClassName:(NSString *)className;
//-(float) getXvelocity;
//-(float) getYVelocity;


@end
