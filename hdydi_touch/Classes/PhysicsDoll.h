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

typedef enum _dollType {
    kBarbie, kKen
} kDollType;

@interface PhysicsDoll : NSObject
{
    b2World *m_world;
    CCScene *scene;
    kDollType type;
    
    CCSprite *headSprite, *chestSprite, *hipsSprite, *armLSprite, *armRSprite, *legLSprite,
             *legRSprite, *footLSprite, *footRSprite;
}

- (PhysicsDoll *)init:(CCScene *)scene withWorld:(NSValue *)world andType:(kDollType)type;
- (void)setupSprites;

@end
