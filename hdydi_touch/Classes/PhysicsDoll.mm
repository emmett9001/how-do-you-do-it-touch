//
//  PhysicsDoll.m
//  hdydi_touch
//
//  Created by Emmett Butler on 5/31/14.
//  Copyright (c) 2014 Star Maid. All rights reserved.
//

#import "PhysicsDoll.h"

@implementation PhysicsDoll

-(PhysicsDoll *)init:(CCScene *)_scene withWorld:(NSValue *)world andType:(kDollType)_type andStartPos:(CGPoint)_startPos {
    if (self = [super init]) {
        self->m_world = (b2World *)[world pointerValue];
        self->scene = _scene;
        self->type = _type;
        self->startPos = _startPos;
        
        [self setupBodies];
        [self setupSprites];
    }
    return self;
}

-(void)update {
    headSprite.position = ccp(headBody->GetPosition().x * PTM_RATIO, headBody->GetPosition().y * PTM_RATIO);
    headSprite.rotation = headBody->GetAngle() * (180 / M_PI);
    
    chestSprite.position = ccp(torsoTopBody->GetPosition().x * PTM_RATIO, torsoTopBody->GetPosition().y * PTM_RATIO);
    chestSprite.rotation = torsoTopBody->GetAngle() * (180 / M_PI);
    
    hipsSprite.position = ccp(torsoBottomBody->GetPosition().x * PTM_RATIO, torsoBottomBody->GetPosition().y * PTM_RATIO);
    hipsSprite.rotation = torsoBottomBody->GetAngle() * (180 / M_PI);
}

-(void)setupBodies {
    float startX = self->startPos.x, startY = self->startPos.y;
    b2CircleShape *circ = new b2CircleShape();
    b2PolygonShape *box = new b2PolygonShape();
    b2BodyDef bodyDef = b2BodyDef();
    b2RevoluteJointDef jointDef = b2RevoluteJointDef();
    b2FixtureDef fixtureDef = b2FixtureDef();
    b2Filter filterData = b2Filter();
    
    bodyDef.type = b2_dynamicBody;
    
    // HEAD
    circ->m_radius = 20 / PTM_RATIO;
    fixtureDef.shape = circ;
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.4;
    fixtureDef.restitution = 0.3;
    fixtureDef.isSensor = YES;
    fixtureDef.userData = (__bridge void *)[NSNumber numberWithInt:kHead];
    float headY = 10;
    if (self->type == kKen) {
        headY = 30;
    }
    bodyDef.position.Set(startX / PTM_RATIO, (startY + headY) / PTM_RATIO);
    headBody = self->m_world->CreateBody(&bodyDef);
    headBody->CreateFixture(&fixtureDef);
    fixtureDef.isSensor = NO;
    
    // TORSO TOP
    box->SetAsBox(30.0f / PTM_RATIO, 30.0f / PTM_RATIO);
    fixtureDef.shape = box;
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.4;
    fixtureDef.restitution = 0.1;
    filterData = b2Filter();
    filterData.maskBits = kTorsoMask;
    filterData.categoryBits = kTorsoCat;
    fixtureDef.filter = filterData;
    bodyDef.position.Set(startX / PTM_RATIO, (startY - 28) / PTM_RATIO);
    torsoTopBody = self->m_world->CreateBody(&bodyDef);
    torsoTopBody->CreateFixture(&fixtureDef);
    
    // TORSO BOTTOM
    box = new b2PolygonShape();
    box->SetAsBox(22.0f / PTM_RATIO, 22.0f / PTM_RATIO);
    fixtureDef.shape = box;
    bodyDef.position.Set(startX / PTM_RATIO, (startY - 85) / PTM_RATIO);
    bodyDef.fixedRotation = true;
    torsoBottomBody = self->m_world->CreateBody(&bodyDef);
    torsoBottomBody->CreateFixture(&fixtureDef);
    bodyDef.fixedRotation = false;
    self->midriff = torsoBottomBody;
    
    // GROIN COLLIDER
    box = new b2PolygonShape();
    box->SetAsBox(15.0f / PTM_RATIO, 10.0f / PTM_RATIO);
    fixtureDef.shape = box;
    bodyDef.position.Set(startX / PTM_RATIO, (startY - 115) / PTM_RATIO);
    groinSensor = self->m_world->CreateBody(&bodyDef);
    fixtureDef.isSensor = true;
    fixtureDef.userData = (__bridge void *)[NSNumber numberWithInt:kGroin];
    groinSensor->CreateFixture(&fixtureDef);
    fixtureDef.isSensor = false;
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
