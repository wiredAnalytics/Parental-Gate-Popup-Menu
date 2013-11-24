//
//  IntroLayer.m
//  Parents PopUp
//
//  Created by sarfaraz hussain on 23/11/2013.
//  Copyright sarfaraz hussain 2013. All rights reserved.
//
/*
 .   Apple require parental gate for applications that are made for childeren, and applications which do not have a parental gate for any external links are rejected by apple. For one of our app we made a popup menu as a parental gate which randomly ask the user to tap and hold a particular shape for 3 seconds, and if the shape is correct the popup will show external links. Our app has been APPROVED by apple and it is available at App Store. We are sharing our code of popup menu which can be used as a parental gate for apps which are made for children. You are free to use this code in your cocos2d-iphone projects but you can support us by purchasing one of our app in App Store here is the link https://itunes.apple.com/us/app/kids-english-letters/id712469154 you can contact us at info@wiredanalytics.com or visit our website https://www.wiredanalytics.com please share us a link to your app in which you use this code and publish at AppStore. You can send us links at info@wiredanalytics.com
 */



// Import the interfaces
#import "IntroLayer.h"
#import "Layer.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the Layer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(id) init
{
	if( (self=[super init])) {

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
			background.rotation = 90;
		} else {
			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		}
		background.position = ccp(size.width/2, size.height/2);

		// add the label as a child to this Layer
		[self addChild: background];
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[Layer scene] ]];
}
@end
