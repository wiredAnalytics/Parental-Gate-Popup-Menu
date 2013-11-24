//
//  Layer.h
//  Parents PopUp
//
//  Created by sarfaraz hussain on 23/11/2013.
//  Copyright sarfaraz hussain 2013. All rights reserved.
//
/*
 .   Apple require parental gate for applications that are made for childeren, and applications which do not have a parental gate for any external links are rejected by apple. For one of our app we made a popup menu as a parental gate which randomly ask the user to tap and hold a particular shape for 3 seconds, and if the shape is correct the popup will show external links. Our app has been APPROVED by apple and it is available at App Store. We are sharing our code of popup menu which can be used as a parental gate for apps which are made for children. You are free to use this code in your cocos2d-iphone projects but you can support us by purchasing one of our app in App Store here is the link https://itunes.apple.com/us/app/kids-english-letters/id712469154 you can contact us at info@wiredanalytics.com or visit our website https://www.wiredanalytics.com please share us a link to your app in which you use this code and publish at AppStore. You can send us links at info@wiredanalytics.com
 */

#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// Layer
@interface Layer : CCLayer
{
    CCMenu *menu;
}

// returns a CCScene that contains the Layer as the only child
+(CCScene *) scene;

@end
