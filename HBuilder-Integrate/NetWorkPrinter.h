//
//  PluginTest.h
//  HBuilder-Hello
//
//  Created by Mac Pro on 14-9-3.
//  Copyright (c) 2014年 DCloud. All rights reserved.
//

#include "PGPlugin.h"
#include "PGMethod.h"
#import "GCDAsyncSocket.h"
#import <Foundation/Foundation.h>



@interface NetWorkPrinter : PGPlugin

- (void) StartConnect:(PGMethod*)commands;
- (void) GetConnectStatus:(PGMethod *)commands;
- (void) SendData:(PGMethod *)commands;
@property (strong, nonatomic)   NSMutableData            *printerData;
@end
