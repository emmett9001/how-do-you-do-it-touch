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
    
	return self;
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
