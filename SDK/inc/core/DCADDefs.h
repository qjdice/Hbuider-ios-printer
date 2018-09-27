//
//  DCADDefs.h
//  libPDRCore
//
//  Created by DCloud on 2018/3/2.
//  Copyright © 2018年 DCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef NS_ENUM(NSInteger, DCADReportTag) {
    DCADReportTagAdClick = 1,
    DCADReportTagAdImp,
    DCADReportTagAppDownloadStart,
    DCADReportTagAppDownloadEnd,
    DCADReportTagAppInstall,
    DCADReportTagAppActive,
    DCADReportTagDeeplinkActive,
};

extern const NSString *kDCH5ClickPointKey;

@interface DCH5ClickPoint :NSObject
@property (nonatomic, assign)CGPoint down_xy;//用户点击绝对坐标宏，用户手指按下时的坐标
@property (nonatomic, assign)CGPoint up_xy;//用户点击绝对坐标宏，用户手指离开设备是的横坐标
@property (nonatomic, assign)CGPoint relative_downXY;//用户点击绝对坐标宏，用户手指离开设备是的横坐标
@property (nonatomic, assign)CGPoint relative_upXY;//用户点击绝对坐标宏，用户手指离开设备是的横坐标
@end


#ifdef DEBUG
#define DCADLOG NSLog
#else
#define DCADLOG
#endif

