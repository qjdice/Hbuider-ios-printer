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



@interface BluePrinter : PGPlugin



- (void)ConnectByIndex:(PGMethod*)commands; /*搜索蓝牙通过索引连接*/
- (void)ConnectByUuid:(PGMethod*)commands; /*存储蓝牙后通过uuid连接 若附近未搜索到符合uuid的蓝牙外设则返回错误*/
- (void)Scanning:(PGMethod*)commands; /*扫描蓝牙设备返回数组对象*/
- (void)SendData:(PGMethod*)commands; /*直接发送打印的数据*/
@property (strong, nonatomic)   NSArray<CBPeripheral *> *deviceArray;  /**< 实时搜索后蓝牙设备个数 */
@property (nonatomic)   int *uuidstep;  /** 通过uuid连接的计数器 */
@end
