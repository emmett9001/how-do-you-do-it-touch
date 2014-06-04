//
//  PhysicsDoll.m
//  hdydi_touch
//
//  Created by Emmett Butler on 5/31/14.
//  Copyright (c) 2014 Star Maid. All rights reserved.
//

#import "PhysicsDoll.h"

@implementation PhysicsDoll

-(PhysicsDoll *)init:(CCScene *)_scene withWorld:(NSValue *)world andType:(kDollType)_type {
    if (self = [super init]) {
        self->m_world = (b2World *)[world pointerValue];
        self->scene = _scene;
        self->type = _type;
        
        [self setupSprites];
    }
    return self;
}

-(void)setupSprites {
    headSprite = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"barb_head.png"]];
    headSprite.position = ccp(100, 100);
    [self->scene addChild:headSprite];
}

@end
