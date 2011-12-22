//
//  GameObject3D.m
//  The_KEY
//
//  Created by Nathan Jones on 10/30/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "GameObject3D.h"

@implementation GameObject3D
@synthesize isActive;
@synthesize gameObjectType;

- (id)init
{
    self = [super init];
    if (self) {
      // CC3PODResource *resource = [CC3PODResource resourceFromFile:<#(NSString *)#> // Initialization code here.
    }
    
    return self;
}
-(void) changeState:(CharacterStates)newState
{
    CCLOG(@"GameObject3D-> need to override changestate function!");
}
-(void) updateStateWithDeltaTime:(ccTime)deltaTime andListofGameObjects:(CCArray *)listOfGameObjects
{
    CCLOG(@"GameObject3D-> need to override updatestate function!");
}
@end
