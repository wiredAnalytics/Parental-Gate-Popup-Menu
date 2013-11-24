//
//  Created by sarfaraz hussain on 01/09/2013.
//  Copyright (c) 2013 Wired Analytics. All rights reserved.
//
/*
 .   Apple require parental gate for applications that are made for childeren, and applications which do not have a parental gate for any external links are rejected by apple. For one of our app we made a popup menu as a parental gate which randomly ask the user to tap and hold a particular shape for 3 seconds, and if the shape is correct the popup will show external links. Our app has been APPROVED by apple and it is available at App Store. We are sharing our code of popup menu which can be used as a parental gate for apps which are made for children. You are free to use this code in your cocos2d-iphone projects but you can support us by purchasing one of our app in App Store here is the link https://itunes.apple.com/us/app/kids-english-letters/id712469154 you can contact us at info@wiredanalytics.com or visit our website https://www.wiredanalytics.com please share us a link to your app in which you use this code and publish at AppStore. You can send us links at info@wiredanalytics.com
 */



#import "PopUp.h"
#import "RandomNumberGenerator.h"

#define ANIM_SPEED .2f
#define TAP_TIME 2.0f
@implementation PopUp

enum tags
{
    tBG = 1,
};

+(id)showPopUp:(id)callbackObj method:(SEL)selector
{
    
    return [[self alloc] initPopup:callbackObj method:selector];
}

- (id)initPopup:(id)callbackObj method:(SEL)selector {
    self = [super init];
    if (self) {
        tapped = false;
        randomShape = [RandomNumberGenerator getUniformRandomIntegerBetween:3 And:1];
        NSMethodSignature *sig = [[callbackObj class] instanceMethodSignatureForSelector:selector];
        callback = [NSInvocation invocationWithMethodSignature:sig];
        [callback setTarget:callbackObj];
        [callback setSelector:selector];
        
        
        CCMenuItemSprite *cross = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"Cross.png"] selectedSprite:NULL target:self selector:@selector(closePopUp)];
        
        star = [CCSprite spriteWithFile:@"Star.png"]; star.position = ccp(110, 100);
        circle = [CCSprite spriteWithFile:@"Circle.png"]; circle.position = ccp(220, 100);
        square = [CCSprite spriteWithFile:@"Square.png"]; square.position = ccp(320, 100);
        CCMenu *crossMenu;
        crossMenu = [CCMenu menuWithItems:cross, nil];
        crossMenu.position = ccp(0, 0);
        cross.position = ccp(380,235);
        
        CCSprite *text = [CCSprite spriteWithFile:[NSString stringWithFormat:@"text%d.png",randomShape]];
        text.position = ccp(210, 180);
        
        
        CGSize s = [[CCDirector sharedDirector] winSize];

        //black background behind popup menu
        bg = [CCSprite node];
        bg.color = ccBLACK;
        bg.opacity = 0;
        [bg setTextureRect:CGRectMake(0, 0, s.width, s.height)];
        bg.anchorPoint = ccp(0,0);
        [self addChild:bg z:-1 tag:tBG];
        
        //popup window
        window = [CCSprite spriteWithFile:@"Popup-Box.png"];
        window.position = ccp(s.width/2, s.height/2);
        window.scale = .9;
        
        [window addChild:crossMenu z:6];
        [window addChild:star];
        [window addChild:square];
        [window addChild:circle];
       
        [window addChild:text];
        [self addChild:window];
        
        //show animation
        [bg runAction:[CCFadeTo actionWithDuration:ANIM_SPEED / 2 opacity:150]];
        [window runAction:[CCSequence actions:
                           [CCScaleTo actionWithDuration:ANIM_SPEED /2 scale:1.1],
                           [CCScaleTo actionWithDuration:ANIM_SPEED /2 scale:1.0],
                           nil]];
        self.TouchEnabled = YES;
    }
    return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCLOG(@"touch began, selected random number:%d",randomShape);
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:[touch view]];
    //if its iphone 5
    if ([[CCDirector sharedDirector]winSize].width == 568 ){
        touchLocation.x = touchLocation.x-44;
    }
    touchLocation = [[CCDirector sharedDirector]convertToGL:touchLocation];
    
    
    if (CGRectContainsPoint([star boundingBox], touchLocation) && randomShape == 1){
        CCLOG(@"star touch detected");
        
        tapped = true;
        [self scheduleOnce:@selector(tappedForThreeSeconds) delay:TAP_TIME];
    }
    
    if (CGRectContainsPoint([circle boundingBox], touchLocation) && randomShape == 2){
        CCLOG(@"circle touch detected");
        
        tapped = true;
        [self scheduleOnce:@selector(tappedForThreeSeconds) delay:TAP_TIME];
    }
    
    if (CGRectContainsPoint([square boundingBox], touchLocation) && randomShape == 3){
        CCLOG(@"square touch detected");
        
        tapped = true;
        [self scheduleOnce:@selector(tappedForThreeSeconds) delay:TAP_TIME];
    }
    
    
}
-(void)ccTouchesEnded:(UITouch *)touches withEvent:(UIEvent *)event
{
    CCLOG(@"touch ended");
    tapped = false;
    [self unschedule:@selector(tappedForThreeSeconds)];
}
-(void)tappedForThreeSeconds{
    if (tapped) {
        CCLOG(@"tapped for 3 seconds");

        [window removeAllChildren];
        
        CCMenuItemSprite *cross = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"Cross.png"] selectedSprite:NULL target:self selector:@selector(closePopUp)];
        CCMenuItemSprite *b1 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"Button1.png"] selectedSprite:NULL target:self selector:@selector(goToFullApp)];
        CCMenuItemSprite *b2 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"Button2.png"] selectedSprite:NULL target:self selector:@selector(rateApp)];
        CCMenuItemSprite *b3 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"Button3.png"] selectedSprite:NULL target:self selector:@selector(moreApps)];
       
        CCMenu *crossMenu2 = [CCMenu menuWithItems:cross, nil];
        
        
        CCMenu *buttons = [CCMenu menuWithItems:b1,b2,b3, nil];
        [buttons alignItemsVerticallyWithPadding:5];
        
        [window addChild:crossMenu2];
        [window addChild:buttons];
        
        crossMenu2.position =ccp(0,0);
        cross.position = ccp(380,235);
        buttons.position = ccp(212, 120);
    }
    
}
-(void) donothing{
    CCLOG(@"do nothing called");
}
-(void)closePopUp
{
    [window runAction:[CCFadeOut actionWithDuration:ANIM_SPEED]];
    [window runAction:[CCSequence actions:
                       [CCScaleTo actionWithDuration:ANIM_SPEED scale:1.1],
                       [CCCallFunc actionWithTarget:self selector:@selector(allDone)],
                       nil]];
    [callback invoke];
    
    
}

//SET YOUR DESIRED LINKS HERE IN THESE 3 METHODS
- (void) goToFullApp
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://itunes.apple.com/us/app/kids-english-letters/id712469154"]];
    
}
- (void) rateApp
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://itunes.apple.com/us/app/kids-english-letters/id712469154"]];
    
}
- (void) moreApps
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://search.itunes.apple.com/WebObjects/MZContentLink.woa/wa/link?path=apps%2fwiredanalytics"]];
    
}

-(void)allDone
{
    [self removeFromParentAndCleanup:YES];
}


@end
