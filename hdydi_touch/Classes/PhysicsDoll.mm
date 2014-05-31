//
//  PhysicsDoll.m
//  hdydi_touch
//
//  Created by Emmett Butler on 5/31/14.
//  Copyright (c) 2014 Star Maid. All rights reserved.
//

#import "PhysicsDoll.h"

@implementation PhysicsDoll

-(PhysicsDoll *)init:(CCScene *)scene withWorld:(NSValue *)world andType:(kDollType)type {
    self->m_world = (b2World *)[world pointerValue];
}

@end
