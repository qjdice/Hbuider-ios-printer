//
//  DCSplashObserver.h
//  HBuilder
//
//  Created by Lin xinzheng on 2018/3/7.
//  Copyright © 2018年 DCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCH5ScreenAdvertising.h"
#import "DCH5ScreenAdvertisingBrowser.h"

#define  kDCSplashScreenCloseEvent @"kDCSplashScreenCloseEvent"

@interface DCSplashAdObserver : NSObject
+ (DCH5ScreenAdvertising*)splashAdViewController;
@end
