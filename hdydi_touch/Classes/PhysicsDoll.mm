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
    NSString *headImg = @"", *chestImg = @"", *hipsImg = @"", *armLImg = @"", *armRImg = @"",
             *legLImg = @"", *legRImg = @"", *footLImg = @"", *footRImg = @"";
    if (self->type == kBarbie) {
        headImg = @"barb_head.png";
        chestImg = @"barb_chest.png";
        hipsImg = @"barb_hips.png";
        armLImg = @"barb_armL.png";
        armRImg = @"barb_armR.png";
        legLImg = @"barb_legL.png";
        legRImg = @"barb_legR.png";
        footLImg = @"barb_footL.png";
        footRImg = @"barb_footR.png";
    } else if (self->type == kKen) {
        headImg = @"ken_head.png";
        chestImg = @"ken_chest.png";
        hipsImg = @"ken_hips.png";
        armLImg = @"ken_armL.png";
        armRImg = @"ken_armR.png";
        legLImg = @"ken_legL.png";
        legRImg = @"ken_legR.png";
        footLImg = @"ken_footL.png";
        footRImg = @"ken_footR.png";
    }
    
    headSprite = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:headImg]];
    headSprite.position = ccp(0, 0);
    [self->scene addChild:headSprite];
    
    chestSprite = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:chestImg]];
    chestSprite.position = ccp(0, 0);
    [self->scene addChild:chestSprite];
    
    hipsSprite = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:hipsImg]];
    hipsSprite.position = ccp(0, 0);
    [self->scene addChild:hipsSprite];
    
    armLSprite = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:armLImg]];
    armLSprite.position = ccp(0, 0);
    [self->scene addChild:armLSprite];
    
    armRSprite = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:armRImg]];
    armRSprite.position = ccp(0, 0);
    [self->scene addChild:armRSprite];
    
    legLSprite = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:legLImg]];
    legLSprite.position = ccp(0, 0);
    [self->scene addChild:legLSprite];
    
    legRSprite = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:legRImg]];
    legRSprite.position = ccp(0, 0);
    [self->scene addChild:legRSprite];
    
    footLSprite = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:footLImg]];
    footLSprite.position = ccp(0, 0);
    [self->scene addChild:footLSprite];
    
    footRSprite = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:footRImg]];
    footRSprite.position = ccp(0, 0);
    [self->scene addChild:footRSprite];
}

@end
