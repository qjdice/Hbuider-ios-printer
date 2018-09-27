//
//  DCH5ScreenAdvertisingBrowser.h
//  libPDRCore
//
//  Created by EICAPITAN on 18/2/7.
//  Copyright © 2018年 DCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class DCH5ScreenAdvertisingBrowser;

@protocol DCH5ScreenAdvertisingBrowserDelegate <NSObject>

- (void)webviewWillClosed:(DCH5ScreenAdvertisingBrowser*)browserHandle;

@end

@interface DCH5ScreenAdvertisingBrowser : UIViewController
@property(nonatomic, assign)id <DCH5ScreenAdvertisingBrowserDelegate> delegate;
@property(nonatomic, assign)BOOL bneedHideNavBar;
-(void) loadURL:(NSURL*)pURL;
@end
