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
        self->legSpacing = 18;
        
        [self setupBodies];
        [self setupSprites];
    }
    return self;
}

-(void)update {
    headSprite.position = ccp((headBody->GetPosition().x * PTM_RATIO / 2) - headSprite.contentSize.width/2,
                              (headBody->GetPosition().y * PTM_RATIO / 2) + headSprite.contentSize.height/2);
    headSprite.rotation = headBody->GetAngle() * (180 / M_PI);
    
    chestSprite.position = ccp((torsoTopBody->GetPosition().x * PTM_RATIO / 2) - chestSprite.contentSize.width/2,
                               (torsoTopBody->GetPosition().y * PTM_RATIO / 2) + chestSprite.contentSize.height/2);
    chestSprite.rotation = torsoTopBody->GetAngle() * (180 / M_PI);
    
    hipsSprite.position = ccp((torsoBottomBody->GetPosition().x * PTM_RATIO / 2) - hipsSprite.contentSize.width/2,
                              (torsoBottomBody->GetPosition().y * PTM_RATIO / 2) + hipsSprite.contentSize.height/2);
    hipsSprite.rotation = torsoBottomBody->GetAngle() * (180 / M_PI);
    
    armLSprite.position = ccp((armLBody->GetPosition().x * PTM_RATIO / 2) - armLSprite.contentSize.width/2,
                              (armLBody->GetPosition().y * PTM_RATIO / 2) + armLSprite.contentSize.height/2);
    armLSprite.rotation = armLBody->GetAngle() * (180 / M_PI);
    
    armRSprite.position = ccp((armRBody->GetPosition().x * PTM_RATIO / 2) - armRSprite.contentSize.width/2,
                              (armRBody->GetPosition().y * PTM_RATIO / 2) + armRSprite.contentSize.height/2);
    armRSprite.rotation = armRBody->GetAngle() * (180 / M_PI);
    
    legLSprite.position = ccp((legLBody->GetPosition().x * PTM_RATIO / 2) - legLSprite.contentSize.width/2,
                              (legLBody->GetPosition().y * PTM_RATIO / 2) + legLSprite.contentSize.height/2);
    legLSprite.rotation = legLBody->GetAngle() * (180 / M_PI);
    
    legRSprite.position = ccp((legRBody->GetPosition().x * PTM_RATIO / 2) - legRSprite.contentSize.width/2,
                              (legRBody->GetPosition().y * PTM_RATIO / 2) + legRSprite.contentSize.height/2);
    legRSprite.rotation = legRBody->GetAngle() * (180 / M_PI);
    
    footLSprite.position = ccp((footLBody->GetPosition().x * PTM_RATIO / 2) - footLSprite.contentSize.width/2,
                              (footLBody->GetPosition().y * PTM_RATIO / 2) + footLSprite.contentSize.height/2);
    footLSprite.rotation = footLBody->GetAngle() * (180 / M_PI);
    
    footRSprite.position = ccp((footRBody->GetPosition().x * PTM_RATIO / 2) - footRSprite.contentSize.width/2,
                              (footRBody->GetPosition().y * PTM_RATIO / 2) + footRSprite.contentSize.height/2);
    footRSprite.rotation = footRBody->GetAngle() * (180 / M_PI);
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
    
    // ARMS
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.4;
    fixtureDef.restitution = 0.1;
    filterData = b2Filter();
    filterData.maskBits = kArmMask;
    filterData.categoryBits = kArmCat;
    fixtureDef.filter = filterData;
    
    float armSpace = 90;
    float armHeight = 10;
    if (self->type == kBarbie) {
        armSpace = 70;
        armHeight = 15;
    }
    
    // LEFT ARM
    box = new b2PolygonShape();
    box->SetAsBox(56.0f / PTM_RATIO, 6.5f / PTM_RATIO);
    fixtureDef.shape = box;
    bodyDef.position.Set((startX - armSpace) / PTM_RATIO, (startY - armHeight) / PTM_RATIO);
    armLBody = self->m_world->CreateBody(&bodyDef);
    armLBody->CreateFixture(&fixtureDef);
    
    // LEFT HAND SENSOR
    box = new b2PolygonShape();
    box->SetAsBox(10.0f / PTM_RATIO, 10.0f / PTM_RATIO);
    fixtureDef.shape = box;
    bodyDef.position.Set((startX - 150) / PTM_RATIO, (startY - armHeight) / PTM_RATIO);
    handLSensor = self->m_world->CreateBody(&bodyDef);
    fixtureDef.isSensor = true;
    fixtureDef.userData = (__bridge void *)[NSNumber numberWithInt:kHandL];
    handLSensor->CreateFixture(&fixtureDef);
    fixtureDef.isSensor = false;
    
    // RIGHT ARM
    box = new b2PolygonShape();
    box->SetAsBox(56.0f / PTM_RATIO, 6.5f / PTM_RATIO);
    fixtureDef.shape = box;
    bodyDef.position.Set((startX + armSpace) / PTM_RATIO, (startY - armHeight) / PTM_RATIO);
    armRBody = self->m_world->CreateBody(&bodyDef);
    armRBody->CreateFixture(&fixtureDef);
    
    // RIGHT HAND SENSOR
    box = new b2PolygonShape();
    box->SetAsBox(10.0f / PTM_RATIO, 10.0f / PTM_RATIO);
    fixtureDef.shape = box;
    bodyDef.position.Set((startX + 150) / PTM_RATIO, (startY - armHeight) / PTM_RATIO);
    handRSensor = self->m_world->CreateBody(&bodyDef);
    fixtureDef.isSensor = true;
    fixtureDef.userData = (__bridge void *)[NSNumber numberWithInt:kHandR];
    handRSensor->CreateFixture(&fixtureDef);
    fixtureDef.isSensor = false;
    
    // LEGS
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.4;
    fixtureDef.restitution = 0.1;
    filterData = b2Filter();
    filterData.maskBits = kBarbLegMask;
    filterData.categoryBits = kBarbLegCat;
    if (self->type == kKen) {
        filterData.maskBits = kKenLegMask;
        filterData.categoryBits = kKenLegCat;
    }
    fixtureDef.filter = filterData;
    
    // LEFT LEG
    box = new b2PolygonShape();
    box->SetAsBox(7.5 / PTM_RATIO, 66 / PTM_RATIO);
    fixtureDef.shape = box;
    bodyDef.position.Set((startX - self->legSpacing) / PTM_RATIO, (startY - 170) / PTM_RATIO);
    legLBody = self->m_world->CreateBody(&bodyDef);
    legLBody->CreateFixture(&fixtureDef);
    
    // RIGHT LEG
    box = new b2PolygonShape();
    box->SetAsBox(7.5 / PTM_RATIO, 66 / PTM_RATIO);
    fixtureDef.shape = box;
    bodyDef.position.Set((startX + self->legSpacing) / PTM_RATIO, (startY - 170) / PTM_RATIO);
    legRBody = self->m_world->CreateBody(&bodyDef);
    legRBody->CreateFixture(&fixtureDef);
    
    // FEET
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.4;
    fixtureDef.restitution = 0.1;
    filterData = b2Filter();
    filterData.maskBits = kFootMask;
    filterData.categoryBits = kFootCat;
    fixtureDef.filter = filterData;
    
    // LEFT FOOT
    box = new b2PolygonShape();
    box->SetAsBox(6.0f / PTM_RATIO, 10.0f / PTM_RATIO);
    fixtureDef.shape = box;
    bodyDef.position.Set((startX - self->legSpacing) / PTM_RATIO, (startY - 247) / PTM_RATIO);
    footLBody = self->m_world->CreateBody(&bodyDef);
    footLBody->CreateFixture(&fixtureDef);
    
    // RIGHT FOOT
    box = new b2PolygonShape();
    box->SetAsBox(6.0f / PTM_RATIO, 10.0f / PTM_RATIO);
    fixtureDef.shape = box;
    bodyDef.position.Set((startX + self->legSpacing) / PTM_RATIO, (startY - 247) / PTM_RATIO);
    footRBody = self->m_world->CreateBody(&bodyDef);
    footRBody->CreateFixture(&fixtureDef);
}

-(void)setupSprites {
    NSString *headImg = @"", *chestImg = @"", *hipsImg = @"", *armLImg = @"", *armRImg = @"",
             *legLImg = @"", *legRImg = @"", *footLImg = @"", *footRImg = @"";
    if (self->type == kBarbie) {
        headImg = @"barb_head.png";
        chestImg = @"barb_chest.png";
        hipsImg = @"barb_hips.png";
        armRImg = @"barb_armL.png";
        armLImg = @"barb_armR.png";
        legRImg = @"barb_legL.png";
        legLImg = @"barb_legR.png";
        footRImg = @"barb_footL.png";
        footLImg = @"barb_footR.png";
    } else if (self->type == kKen) {
        headImg = @"ken_head.png";
        chestImg = @"ken_chest.png";
        hipsImg = @"ken_hips.png";
        armRImg = @"ken_armL.png";
        armLImg = @"ken_armR.png";
        legRImg = @"ken_legL.png";
        legLImg = @"ken_legR.png";
        footRImg = @"ken_footL.png";
        footLImg = @"ken_footR.png";
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
