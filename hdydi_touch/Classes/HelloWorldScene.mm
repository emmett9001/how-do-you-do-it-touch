//
//  HelloWorldScene.m
//  hdydi_touch
//
//  Created by Emmett Butler on 5/20/14.
//  Copyright Star Maid 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "HelloWorldScene.h"
#import "IntroScene.h"
#import <Box2D/Box2D.h>

// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation HelloWorldScene
{
    CCSprite *background, *girlBody, *girlFace;
    CCSpriteBatchNode *spriteSheet;
    
    b2World *_world;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    self.userInteractionEnabled = YES;
    
    [self setupWorld];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"sprites_default.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"sprites_default.png"];
    [self addChild:spriteSheet];
    
    background = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"mainbg.png"]];
    background.position = ccp(self.contentSize.width/2, self.contentSize.height - 100);
    [self addChild:background];
    
    girlBody = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"girl_body.png"]];
    girlBody.position = ccp(girlBody.contentSize.width / 2, girlBody.contentSize.height / 2);
    [self addChild:girlBody];

    girlFace = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"faces_3.png"]];
    girlFace.position = ccp(girlBody.position.x + 20, girlBody.position.y + 120);
    [self addChild:girlFace];
    
    self->barbie = [[PhysicsDoll alloc] init:self withWorld:[NSValue valueWithPointer:self->_world] andType:kBarbie andStartPos:CGPointMake(100, 100)];
    self->ken = [[PhysicsDoll alloc] init:self withWorld:[NSValue valueWithPointer:self->_world] andType:kKen andStartPos:CGPointMake(200, 100)];
    
    [self schedule:@selector(tick:) interval:.03f];
    
	return self;
}

-(void) tick:(float)dt {
    self->_world->Step(1.0f/60.0f, 10, 8);
    
    [self->barbie update];
    [self->ken update];
}

-(void) draw {
    _world->DrawDebugData();
}

- (void)setupWorld {
    b2Vec2 gravity = b2Vec2(0, -9.8);
    _world = new b2World(gravity, true);
    
    /*GLESDraw *m_debugDraw = new GLESDraw( PTM_RATIO );
    uint32 flags = 0;
    flags += b2DebugDraw::e_shapeBit;
    flags += b2DebugDraw::e_jointBit;
    flags += b2DebugDraw::e_aabbBit;
    flags += b2DebugDraw::e_pairBit;
    flags += b2DebugDraw::e_centerOfMassBit;
    m_debugDraw->SetFlags(flags);
    
    _world->SetDebugDraw(m_debugDraw);*/
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLoc = [touch locationInNode:self];
    
    
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// -----------------------------------------------------------------------
@end
