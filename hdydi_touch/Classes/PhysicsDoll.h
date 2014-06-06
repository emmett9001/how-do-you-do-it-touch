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

typedef enum _collisionFilters {
    kTorsoCat = 0x0010,
    kTorsoMask = 0xFFFF,
    kArmMask = 0xFFFF,
    kArmCat = 0x0020,
    kBarbLegMask = 0x0002,
    kBarbLegCat = 0x0002,
    kKenLegMask = 0x0004,
    kKenLegCat = 0x0004
} kCollisionFilter;

@interface PhysicsDoll : NSObject
{
    b2World *m_world;
    CCScene *scene;
    kDollType type;
    
    CCSprite *headSprite, *chestSprite, *hipsSprite, *armLSprite, *armRSprite, *legLSprite,
             *legRSprite, *footLSprite, *footRSprite;
    
    b2Body *headBody, *torsoTopBody, *torsoBottomBody, *armLBody, *armRBody, *legLBody, *legRBody, *footLBody, *footRBody, *groinSensor, *handLSensor, *handRSensor;
    b2Body *midriff;
    
    float legSpacing;
    
    CGPoint startPos;
}

- (PhysicsDoll *)init:(CCScene *)scene withWorld:(NSValue *)world andType:(kDollType)type andStartPos:(CGPoint)_startPos;
- (void)setupSprites;
- (void)setupBodies;
- (void)update;

@end
