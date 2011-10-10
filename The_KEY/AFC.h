//
//  AFC.h
//  The_KEY
//
//  Created by Nathan Jones on 10/8/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "Generic_Soldier.h"

@interface AFC : Generic_Soldier
{
    //anims
        //standing
    CCAnimation *Standing_Anim;
    
        //walking
    CCAnimation *Walking_Anim;
        //Crouching
    CCAnimation *Crouching_Anim;
        //Prone
    CCAnimation *Prone_Anim;
    //other info 
       //weapon type
    WeaponType weapon;
    
}

@property(nonatomic, retain) CCAnimation *Standing_Anim;
@property(nonatomic, retain) CCAnimation *Walking_Anim;
@property(nonatomic, retain) CCAnimation *Crouching_Anim;
@property(nonatomic, retain) CCAnimation *Prone_Anim;
@property(readwrite) WeaponType weapon;
@end
