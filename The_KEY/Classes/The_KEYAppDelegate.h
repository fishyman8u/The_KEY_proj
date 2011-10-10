//
//  The_KEYAppDelegate.h
//  The_KEY
//
//  Created by Nathan Jones on 10/2/11.
//  Copyright Student 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCNodeController.h"
#import "CC3World.h"


@interface The_KEYAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow* window;
	CCNodeController* viewController;
}

@property (nonatomic, retain) UIWindow* window;

@end
