//
//  DCADLaunch.h
//  libPDRCore
//
//  Created by X on 2018/2/6.
//  Copyright © 2018年 DCloud. All rights reserved.
//
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, DCADLaunchProvider) {
    DCADLaunchProviderUnkown,
    DCADLaunchProviderDCloud = 1
};

@interface DCADLaunch : NSObject<NSSecureCoding>
@property (nonatomic, assign) DCADLaunchProvider provider;
@property (nonatomic) int16_t idx;
@property (nonatomic) BOOL isShow;
@property (nullable, nonatomic, copy) NSDate *expires;
@property (nullable, nonatomic, copy) NSString *adid;
@property (nullable, nonatomic, retain) NSDictionary *content;
@end

@interface DCADLaunchTransform :NSObject
+(DCADLaunch*)dcloud_launch:(NSDictionary*)dict;
@end

NS_ASSUME_NONNULL_END

