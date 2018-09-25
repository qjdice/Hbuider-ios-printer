//
//  PluginTest.h
//  HBuilder-Hello
//
//  Created by Mac Pro on 14-9-3.
//  Copyright (c) 2014年 DCloud. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface WebViewForImage : UIViewController

@property(nonnull, copy)void(^webCallback)(UIImage * webimg);
@property(nonnull, strong)NSString * htmlString;

@end
