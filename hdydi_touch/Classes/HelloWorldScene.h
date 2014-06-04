//
//  HelloWorldScene.h
//  hdydi_touch
//
//  Created by Emmett Butler on 5/20/14.
//  Copyright Star Maid 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using Cocos2D v3
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "PhysicsDoll.h"

// -----------------------------------------------------------------------

/**
 *  The main scene
 */
@interface HelloWorldScene : CCScene
{
    PhysicsDoll *barbie, *ken;
}

// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene;
- (id)init;
- (void)setupWorld;
- (void)draw;
- (void)tick;

// -----------------------------------------------------------------------
@end