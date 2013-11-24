//
//  Layer.m
//  Parents PopUp
//
//  Created by sarfaraz hussain on 23/11/2013.
//  Copyright sarfaraz hussain 2013. All rights reserved.
//
/*
  .   Apple require parental gate for applications that are made for childeren, and applications which do not have a parental gate for any external links are rejected by apple. For one of our app we made a popup menu as a parental gate which randomly ask the user to tap and hold a particular shape for 3 seconds, and if the shape is correct the popup will show external links. Our app has been APPROVED by apple and it is available at App Store. We are sharing our code of popup menu which can be used as a parental gate for apps which are made for children. You are free to use this code in your cocos2d-iphone projects but you can support us by purchasing one of our app in App Store here is the link https://itunes.apple.com/us/app/kids-english-letters/id712469154 you can contact us at info@wiredanalytics.com or visit our website https://www.wiredanalytics.com please share us a link to your app in which you use this code and publish at AppStore. You can send us links at info@wiredanalytics.com
 */





// Import the interfaces
#import "Layer.h"
#import "PopUp.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

@implementation Layer

// Helper class method that creates a Scene with the Layer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Layer *layer = [Layer node];
	
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
	if( (self=[super init]) ) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Popup Menu" fontName:@"Marker Felt" fontSize:64];

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
        //positioning factor to adjust positioning depending on screen width (3.5 inch or 4 inch)
        int positioningFactor = 0;
        if ([[CCDirector sharedDirector]winSize].width == 568) {
            positioningFactor = 44; //to move half way only on x axis
        }
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];

		CCMenuItemImage *ParentSection = [CCMenuItemImage itemWithNormalImage:@"Info.png"
                                                                selectedImage: @"Info.png"
                                                                       target:self
                                                                     selector:@selector(parentSectionPopup)];
        
        ParentSection.position = ccp(450+positioningFactor+positioningFactor,300);
        
		menu = [CCMenu menuWithItems:nil];
        menu.position = ccp(0, 0);
		
        [menu addChild:ParentSection];
        
		// Add the menu to the layer
		[self addChild:menu];

	}
	return self;
}
-(void)disableTouch{
    CCLOG(@"touch Disabled");
    menu.TouchEnabled = NO;
}
-(void)enableTouch{
    
    CCLOG(@"touch Enabled");
    menu.touchEnabled = YES;
}
-(void)parentSectionPopup
{
    [self disableTouch];
    PopUp *pop = [PopUp showPopUp:self method:@selector(enableTouch)];
    [self addChild:pop z:1000];
}

@end
