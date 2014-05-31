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
    barbie, ken
} kDollType;

@interface PhysicsDoll : NSObject
{
    b2World *m_world;
}

- (PhysicsDoll *)init:(CCScene *)scene withWorld:(b2World *)world andType:(kDollType)type;

@end
