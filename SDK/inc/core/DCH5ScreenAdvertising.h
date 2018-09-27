//
//  DCH5ScreenAdvertising.h
//  libPDRCore
//
//  Created by EICAPITAN on 18/2/6.
//  Copyright © 2018年 DCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DCADLaunch.h"

typedef enum {
    EDCH5ADVType_url,
    EDCH5ADVType_App,
    EDCH5ADVType_Browser
}EDCH5ADVType;

typedef enum{
    EDCH5ADVCloseType_skip,
    EDCH5ADVCloseType_timeout,
    EDCH5ADVCloseType_adClick,
    EDCH5ADVCloseType_browserClose
}EDCH5ADVCloseType;

@protocol DCH5ScreenAdvertisingDelegate <NSObject>

- (void)advScreenCanShow;
- (BOOL)advScreenWillClose:(EDCH5ADVCloseType)type;
- (void)clickedAdverType:(EDCH5ADVType)type EventData:(NSString*)actData ExtData:(NSDictionary*)extData ADLaunch:(DCADLaunch*)adLaunch;

@end

@interface DCH5ScreenAdvertising : UIViewController
@property (nonatomic, assign)id <DCH5ScreenAdvertisingDelegate> delegate;

@property (nonatomic, retain)NSString* copyRightSummary;
@property (nonatomic, retain)NSString* copyRightIcon;


- (void)setAdvData:(DCADLaunch*)advData SplashData:(NSDictionary*)splashData;

- (void)showSikeButton;
@end
