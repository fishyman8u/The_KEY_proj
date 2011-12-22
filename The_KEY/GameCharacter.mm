//
//  GameCharacter.m
//  The_KEY
//
//  Created by Nathan Jones on 10/8/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "GameCharacter.h"

@implementation GameCharacter
@synthesize body;
@synthesize world;
@synthesize characterState;
@synthesize characterHealth;
@synthesize owner_tag;
@synthesize team;
@synthesize xVelocity;
@synthesize yVelocity;
@synthesize isMovingtoPoint;
@synthesize move_to;
@synthesize movement_speed;
@synthesize angle_adjustment;
@synthesize last_position;
@synthesize X_switch;
@synthesize Y_switch;
@synthesize delegate;
@synthesize isEnemySet;
@synthesize sight_distance;
@synthesize enemy_position;
@synthesize enemy_tag;
@synthesize last_time;
@synthesize frameCount;
@synthesize angular_velocity;

-(void) dealloc
{
    world->DestroyBody(body);
    world = NULL;
    
    
    [super dealloc];
}

//new stuff with BOX2d
//need a delegate
-(void) createBodyAtLocation:(CGPoint)location
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = b2Vec2(location.x/PTM_RATIO, location.y/PTM_RATIO);
    body = world->CreateBody(&bodyDef);
    body->SetUserData(self);
    
    b2FixtureDef fixtureDef;
    b2PolygonShape shape;
    shape.SetAsBox(self.contentSize.width/2/PTM_RATIO, self.contentSize.height/2/PTM_RATIO);
    
    fixtureDef.shape = &shape;
    fixtureDef.restitution = .1;
    fixtureDef.density =1;
    fixtureDef.friction =1;
    
    //b2JointDef test_joint;
   // test_joint.
    body->CreateFixture(&fixtureDef);
    //body->
    
}
-(void) createBodyAtLocation:(CGPoint)location withDensity:(Float32)density withRestitution:(Float32)restitution withFriction:(Float32)friction andSize:(CGSize)size
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = b2Vec2(location.x/PTM_RATIO, location.y/PTM_RATIO);
    body = world->CreateBody(&bodyDef);
    body->SetUserData(self);
    
    b2FixtureDef fixtureDef;
    b2PolygonShape shape;
    shape.SetAsBox(size.width/2/PTM_RATIO, size.height/2/PTM_RATIO);
    
    fixtureDef.shape = &shape;
    fixtureDef.restitution = restitution;
    fixtureDef.density = density;
    fixtureDef.friction = friction;
    
    //b2JointDef test_joint;
    // test_joint.
    body->CreateFixture(&fixtureDef);
    //body->
    
}

//use angular velocity to set movement
//Old Code
-(void) chooseTarget:(CCArray*) listOfGameObjects 
{
    if(isEnemySet) return;
    CGRect sight_rect = CGRectMake(self.position.x, self.position.y, self.sight_distance * 2, self.sight_distance * 2);
    for (GameCharacter * tempChar in listOfGameObjects)
    {
        CGRect character_box = tempChar.adjustedBoundingBox;
       if( CGRectIntersectsRect(sight_rect, character_box))
       {
           if(self.team != tempChar.team)
           {
               if(gameObjectType == kAFC){
                   [self setTarget:tempChar.tag];
                   self.enemy_position = tempChar.position; 
               }
               
               //future adjustments
               //need an array of potential enemies or a unified target group manager
               
           }
       }
    }
}
-(void) setTarget:(NSInteger) enemyTag
{
    [self setEnemy_tag:enemyTag];
    [self setIsEnemySet:YES];
}
-(void) attackUpdate:(float) deltaTime
{
    self.frameCount++;
    self.last_time = frameCount *deltaTime;
    if(self.last_time < kDefaultFireRate)
    {
        return;
    }
    else
    {
    
        CCNode *enemy = [self.parent getChildByTag:enemy_tag];
        float offsetX = self.position.x - enemy.position.x;
        float offsetY =self.position.y -enemy.position.y;
        
        if((offsetX > self.sight_distance) || (offsetY > self.sight_distance)) {
       
            [self setIsEnemySet:NO];
            
            return;   
        } 
        if(!enemy.visible) return;
        self.enemy_position = enemy.position;
        float rotate = [self findRotation:self.position andTarget:self.enemy_position];
        [self setRotation:rotate];
        [delegate createBulletWithRotation:self.rotation andVelocity:kBulletSpeed andPosition:self.position andtag:self.tag];
    }
}
-(int)getWeaponDamage {
    //default to 0 damage
    CCLOG(@"getWeaponDamage should be overidden");
    return 0;
}
-(float)findRotation:(CGPoint)origin andTarget:(CGPoint)target
{ CCLOG(@"find rotation");
    bool quad1,quad2,quad3,quad4;
    float angle;
    
    //targ = target;
    quad1 = FALSE;
    quad2 = FALSE;
    quad3 = FALSE;
    quad4 = FALSE;
    if((origin.x < target.x) && (origin.y <target.y))
    {
        CCLOG(@"Quad 1");
        quad1 = TRUE;
        quad2 = FALSE;
        quad3 = FALSE;
        quad4 = FALSE;
        
    }
    if((origin.x < target.x) && (origin.y > target.y))
    {
        CCLOG(@"Quad 2");
        quad1 = FALSE;
        quad2 = TRUE;
        quad3 = FALSE;
        quad4 = FALSE;
        
    }
    if((origin.x > target.x) && (origin.y > target.y))
    {
        CCLOG(@"Quad 3");
        quad1 = FALSE;
        quad2 = FALSE;
        quad3 = TRUE;
        quad4 = FALSE;
        
    }
    if((origin.x > target.x) && (origin.y < target.y))
    {
        CCLOG(@"Quad 4");
        quad1 = FALSE;
        quad2 = FALSE;
        quad3 = FALSE;
        quad4 = TRUE;
        
    }
    float diffX = origin.x - target.x;
    float diffY = origin.y - target.y;
    
    if((diffX == 0) && (diffY == 0)) return self.rotation;
    if(diffX == 0)
    {
        if(origin.y < target.y)
        {
            CCLOG(@"Set angle to 0");
            angle = 0;
        }
        if(origin.y > target.y)
        {
            CCLOG(@"Set angle to 180");
            angle = PI;
        }
        // angle = PI /2;
    }
    if(diffY == 0)
    {
        if(origin.x < target.x)
        {
            CCLOG(@"Set angle to 90");
            angle = PI/2;
        }
        if(origin.x > target.x)
        {
            CCLOG(@"Set angle to 270");
            angle = 270 * RadianConvert;
        }
        
    }
    if( quad1 == TRUE)
    {
        angle = atanf(diffY/diffX);
    }
    if((quad2 == TRUE) || (quad3 == TRUE))
    {
        float temp;
        temp = atanf(diffY/diffX);
        angle = PI + temp;
    }
    if(quad4 == TRUE)
    {
        float temp;
        temp = atanf(diffY/diffX);
        angle =( 2 * PI )+ temp;
    }
    float temp = angle * DegreeConvert;
    CCLOG(@"The angle: %f", temp);
    return angle;
}
-(void) moveTo:(CGPoint)location
{
  //  bool y_flag, x_flag;
    CGPoint current_location, move_to_location;
    
    current_location = self.position;
    move_to_location = location;
    
    bool quad1,quad2,quad3,quad4;
    quad1 = FALSE;
    quad2 = FALSE;
    quad3 = FALSE;
    quad4 = FALSE;
    if((self.position.x < location.x) && (self.position.y < location.y))
    {
        CCLOG(@"Quad 1");
        quad1 = TRUE;
        quad2 = FALSE;
        quad3 = FALSE;
        quad4 = FALSE;
        
    }
    if((self.position.x < location.x) && (self.position.y > location.y))
    {
        CCLOG(@"Quad 2");
        quad1 = FALSE;
        quad2 = TRUE;
        quad3 = FALSE;
        quad4 = FALSE;
        
    }
    if((self.position.x > location.x) && (self.position.y > location.y))
    {
        CCLOG(@"Quad 3");
        quad1 = FALSE;
        quad2 = FALSE;
        quad3 = TRUE;
        quad4 = FALSE;
        
    }
    if((self.position.x > location.x) && (self.position.y < location.y))
    {
        CCLOG(@"Quad 4");
        quad1 = FALSE;
        quad2 = FALSE;
        quad3 = FALSE;
        quad4 = TRUE;
        
    }
    
    
    float angle;
    float diffX = current_location.x - move_to_location.x;
   /* if(diffX < 0)
    {
        diffX = diffX * -1;
    }*/
    float diffY = current_location.y - move_to_location.y;
    /*if(diffY < 0)
    {
        diffY = diffY * -1;
    }*/
    
    if((diffX == 0) && (diffY == 0)) return;
    if(diffX == 0)
    {
        if(current_location.y < location.y)
        {
            CCLOG(@"Set angle to 0");
            angle = 0;
        }
        if(current_location.y > location.y)
        {
            CCLOG(@"Set angle to 180");
            angle = PI;
        }
       // angle = PI /2;
    }
    if(diffY == 0)
    {
        if(current_location.x < location.x)
        {
            CCLOG(@"Set angle to 90");
            angle = PI/2;
        }
        if(current_location.x > location.x)
        {
            CCLOG(@"Set angle to 270");
            angle = 270 * RadianConvert;
        }

    }
   if( quad1 == TRUE)
    {
     angle = atanf(diffY/diffX);
    }
    if((quad2 == TRUE) || (quad3 == TRUE))
    {
        float temp;
        temp = atanf(diffY/diffX);
        angle = PI + temp;
    }
    if(quad4 == TRUE)
    {
        float temp;
        temp = atanf(diffY/diffX);
        angle =( 2 * PI )+ temp;
    }
   // float angle = [self findRotation:current_location andTarget:move_to];
    self.xVelocity = self.movement_speed * sinf(angle);
    self.yVelocity = self.movement_speed * cosf(angle);
    self.rotation = (angle * DegreeConvert) - self.angle_adjustment;
    CCLOG(@"Movement angle = %f", self.rotation);
    CCLOG(@"Movement speed x: %f y:%f",self.xVelocity, self.yVelocity);
    [self setIsMovingtoPoint:YES];
    [self setMove_to:move_to_location];   
    if(self.position.x > self.move_to.x)
    {
        CCLOG(@"x switch set to NO");
      [self setX_switch:NO];  
    }
    else
    {
        CCLOG(@"x switch set to YES");
        [self setX_switch:YES];
    }
    if(self.position.y > self.move_to.y){
        CCLOG(@"y switch set to NO");
         [self setY_switch:NO];
    }
   else
   {
        CCLOG(@"y switch set to YES");
       [self setY_switch:YES];
   }
    //calc rotation and x,y velocity to target
    //need bools to control frame to frame flow
}
-(void) movementUpdate:(float)deltaTime
{
    //CCLOG(@"Move to pos x: %f y: %f and current pos x: %f y: %f and velocity x: %f y: %f", self.position.x, self.position.y, self.move_to.x, self.move_to.y, self.xVelocity, self.yVelocity);
   if(self.Y_switch)
   {
       if(self.position.y > self.move_to.y)
       {
          
           [self setYVelocity:0.0f];
           
           
       }
   }
  else
  {
      if(self.position.y < self.move_to.y)
      {
          
          [self setYVelocity:0.0f];
          
          
      }

  }
    if(self.X_switch)
    {
        if(self.position.x > self.move_to.x)
        {
            
            [self setXVelocity:0.0f];
            
            
        }
    }
    else
    {
        if(self.position.x < self.move_to.x)
        {
            
            [self setXVelocity:0.0f];
            
            
        }
        
    }
    if((X_switch) && ( xVelocity < 0.0005))
    {
        [self setXVelocity:0];
    }
    if((X_switch == FALSE) && (xVelocity > -0.0005))
    {
        [self setXVelocity:0];
    }
    if((Y_switch) && (yVelocity < 0.0005))
    {
        [self setYVelocity:0];
    }
    if((Y_switch == FALSE) && (yVelocity > -0.0005))
    {
        [self setYVelocity:0];
    }
    if((xVelocity == 0) && (yVelocity == 0))
    {
       // CCLOG(@"Stopping");
        [self setIsMovingtoPoint:NO];
        
        return;
    }

    
    //if(close_high && close_low)
    if(self.position.x == self.move_to.x)
    {
        if(self.position.y == self.move_to.y){
        //CCLOG(@"At new pos.");
        [self setXVelocity:0.0f];
        [self setYVelocity:0.0f];
        [self setIsMovingtoPoint:NO];
        return;
        }
    }
    //CCLOG(@"updating position!");
    //CGPoint old_position = self.position;
    CGPoint new_position = ccp(self.position.x + xVelocity * deltaTime, self.position.y + yVelocity * deltaTime);
    [self setPosition:new_position];
}
//use only if necessary, needs to be adjusted for plan view use as well
-(void) checkAndClampSpritePosition {
    CGPoint currentSpritePosition = [self position];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if(currentSpritePosition.x < 30.0f) {
            [self setPosition:ccp(30.0f, currentSpritePosition.y)];
            
        }
        else if(currentSpritePosition.x > 1000.0f)
        {
            [self setPosition:ccp(1000.0f, currentSpritePosition.y)];
        }
    }
    else
    {
        if(currentSpritePosition.x < 24.0f) {
            [self setPosition:ccp(24.0f, currentSpritePosition.y)];
            
        }
        else if(currentSpritePosition.x > 456.0f)
        {
            [self setPosition:ccp(456.0f, currentSpritePosition.y)];
        }
        
    }
}
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        world = [delegate getRefToWorld];
        owner_tag = 0;
        angle_adjustment =0;
        isEnemySet = NO;
        [self createBodyAtLocation:self.position withDensity:1.0f withRestitution:0.2f withFriction:1.0f andSize:self.contentSize];
    }
    
    return self;
}
-(void) checkCollisions: (CCArray *) listOfGameObjects
{
    CCLOG(@"Game character, check collisions needs to be overriden!");
}
-(void)changeAIState:(AI_States)ai_state
{
    CCLOG(@"Game character, ai state change should be overriden!!");
}
@end
