//
//  HelloWorldLayer.m
//  Cocos2dMusic
//
//  Created by 篠原正樹 on 2014/04/29.
//  Copyright masakishinohara 2014年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
    {
        
//        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"a.mp3"];
        
        static BOOL isBgmStart = NO;
        
        [CCMenuItemFont setFontName:@"Helvetica-BoldOblique"];
        [CCMenuItemFont setFontSize:30];
        CCMenuItemFont *item = [CCMenuItemFont itemWithString:@"BGM" block:^(id sender){
            
            if ([SimpleAudioEngine sharedEngine].isBackgroundMusicPlaying) {
                [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
            }
            else{
                if (isBgmStart) {
                    [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
                }
                else{
                    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"a.mp3" loop:YES];
                    isBgmStart = YES;
                }
            }
            
        }];
        
        CCMenuItemFont * item2 = [CCMenuItemFont itemWithString:@"effect" block:^(id sender){
            [[SimpleAudioEngine sharedEngine] playEffect:@".caf"];
        }];
        
        CCMenu *menu = [CCMenu menuWithItems:item, item2, nil];
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        [menu alignItemsHorizontallyWithPadding:40];
        menu.position = CGPointMake(winSize.width / 2, winSize.height / 2);
        [self addChild:menu];
    }
    
	return self;

}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
