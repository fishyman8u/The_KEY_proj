//
//  Level_3D_Layer.m
//  The_KEY
//
//  Created by Nathan Jones on 11/6/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "Level_3D_Layer.h"

@implementation Level_3D_Layer
-(id) initwithWorld:(CC3World*)world
{
    [super init];
    if(self != nil)
    {
        self.cc3World = world;
        
    }
    return self;
}
@end
