//
//  PhysicsDoll.h
//  hdydi_touch
//
//  Created by Emmett Butler on 5/31/14.
//  Copyright (c) 2014 Star Maid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <Box2D/Box2D.h>

#define PTM_RATIO 32

typedef enum _dollType {
    kBarbie, kKen
} kDollType;

typedef enum _collisionCategory {
    kHead, kHandL, kHandR, kGroin
} kCollisionCategory;

@interface PhysicsDoll : NSObject
{
    b2World *m_world;
    CCScene *scene;
    kDollType type;
    
    CCSprite *headSprite, *chestSprite, *hipsSprite, *armLSprite, *armRSprite, *legLSprite,
             *legRSprite, *footLSprite, *footRSprite;
    
    b2Body *headBody, *torsoBody, *armLBody, *armRBody, *legLBody, *legRBody, *footLBody, *footRBody;
}

- (PhysicsDoll *)init:(CCScene *)scene withWorld:(NSValue *)world andType:(kDollType)type;
- (void)setupSprites;
- (void)setupBodies;
- (void)update;

@end
