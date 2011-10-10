//
//  CommonProtocols.h
//  The_KEY
//
//  Created by Nathan Jones on 10/8/11.
//  Copyright 2011 Student. All rights reserved.
//

#ifndef The_KEY_CommonProtocols_h
#define The_KEY_CommonProtocols_h

typedef enum{
    kStateStanding,
    kStateWalking,
    kStateCrouching,
    kStateProne,
    kStateDying,
    kStateAttacked,
    kStateFiring,
    kStateDead,
    kStateTakingDamage,
    kStateNone    
}CharacterStates;

typedef enum {
    
    kStateMovingto,
    kStateDefending,
    kStateAttacking,
    kStateRetreating,
    kStateWaiting,
    kStateRotating,
    kStateSeekCover

}AI_States;

typedef enum {
    kStateDefendPosition,
    kStateAttackPosition,
    kStateAmbushing,
    kStateWithdrawal
    //put other tactics here
}Squad_AI_States;

typedef enum {
    kStateAnalyzingEnemyStrategy,
    kStateDefensiveStrategy,
    KStateAggressiveStrategy
    //put in strategy states here
}Command_AI_States;




typedef enum {
    kAFC,
    kBullet,
    kObjectTypeNone
}GameObjectType;

typedef enum {
    kWeapon_p90,
    kWeapon_Laser
}WeaponType;

typedef enum{
    kFullCoverFront,
    kHalfCoverFront,
    kFullCoverRight,
    kHalfCoverRight,
    kFullCoverLeft,
    kHalfCoverLeft,
    kFullCoverBack,
    kHalfCoverBack,
    kNoCover
    
}CoverState;
typedef enum{
    kNeutral,
    kUSAF,
    kGadi,
    kDusan,
    kTeam1,
    kTeam2,
    kTeam3,
    kTeam4
}TeamStates;
#endif
