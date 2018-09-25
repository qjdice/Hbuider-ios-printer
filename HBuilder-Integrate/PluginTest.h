//
//  PluginTest.h
//  HBuilder-Hello
//
//  Created by Mac Pro on 14-9-3.
//  Copyright (c) 2014年 DCloud. All rights reserved.
//

#include "PGPlugin.h"
#include "PGMethod.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BLETableViewController.h"
#import "SEPrinterManager.h"
#import <Foundation/Foundation.h>



@interface PGPluginTest : PGPlugin


- (void)PluginTestFunction:(PGMethod*)command;
- (void)PluginTestFunctionArrayArgu:(PGMethod*)command;
- (void)MyPluginTest:(PGMethod*)command;

- (NSData*)PluginTestFunctionSync:(PGMethod*)command;
- (NSData*)PluginTestFunctionSyncArrayArgu:(PGMethod*)command;
@property(nonatomic, copy)NSString* cbId;
- (void)callbackToJs:(CBPeripheral *)barcodestring;
@property (strong, nonatomic)   NSArray<CBPeripheral *>              *deviceArray;  /**< 蓝牙设备个数 */
@end
