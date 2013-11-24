//
//  RandomNumberGenerator.m
//  Kids Urdu Qaida
//
//  Created by sarfaraz hussain on 01/09/2013.
//  Copyright (c) 2013 Wired Analytics. All rights reserved.
//
/*
.   Apple require parental gate for applications that are made for childeren, and applications which do not have a parental gate for any external links are rejected by apple. For one of our app we made a popup menu as a parental gate which randomly ask the user to tap and hold a particular shape for 3 seconds, and if the shape is correct the popup will show external links. Our app has been APPROVED by apple and it is available at App Store. We are sharing our code of popup menu which can be used as a parental gate for apps which are made for children. You are free to use this code in your cocos2d-iphone projects but you can support us by purchasing one of our app in App Store here is the link https://itunes.apple.com/us/app/kids-english-letters/id712469154 you can contact us at info@wiredanalytics.com or visit our website https://www.wiredanalytics.com please share us a link to your app in which you use this code and publish at AppStore. You can send us links at info@wiredanalytics.com
*/




#import "RandomNumberGenerator.h"

@implementation RandomNumberGenerator

-(id) init{
    if (!(self = [super init])) return nil;
    
    srand(time(NULL));
    
    return self;
}

+(int) getRandomIntegerBetween:(int) high And:(int) low
{
    int randomNumber;
    randomNumber = rand() % (high - low +1) +low;
    return randomNumber;
    
}


+(int) getUniformRandomIntegerBetween:(int) high And:(int) low
{
    int randomNumber;
    u_int32_t unSignedIntRandomNumber = arc4random_uniform(RAND_MAX);
    
    randomNumber = (int)unSignedIntRandomNumber;
    randomNumber = randomNumber < 1 ?
                    (randomNumber * (-1)) % (high-low +1)+low :
                    randomNumber % (high - low + 1) +low;
   
    return randomNumber;
}

@end
