//
//  PluginTest.m
//  HBuilder-Hello
//
//  Created by Mac Pro on 14-9-3.
//  Copyright (c) 2014年 DCloud. All rights reserved.
//

#import "BluePrinter.h"
#import "PDRCoreAppFrame.h"
#import "H5WEEngineExport.h"
#import "PDRToolSystemEx.h"
#import "WebViewForImage.h"
// 扩展插件中需要引入需要的系统库
#import <LocalAuthentication/LocalAuthentication.h>

@implementation BluePrinter



#pragma mark 这个方法在使用WebApp方式集成时触发，WebView集成方式不触发

/*
 * WebApp启动时触发
 * 需要在PandoraApi.bundle/feature.plist/注册插件里添加autostart值为true，global项的值设置为true
 */
- (void) onAppStarted:(NSDictionary*)options{
   
    NSLog(@"5+ WebApp启动时触发");
    // 可以在这个方法里向Core注册扩展插件的JS
    
}

// 监听基座事件事件
// 应用退出时触发
- (void) onAppTerminate{
    //
    NSLog(@"APPDelegate applicationWillTerminate 事件触发时触发");
}

// 应用进入后台时触发
- (void) onAppEnterBackground{
    //
    NSLog(@"APPDelegate applicationDidEnterBackground 事件触发时触发");
}

// 应用进入前台时触发
- (void) onAppEnterForeground{
    //
    NSLog(@"APPDelegate applicationWillEnterForeground 事件触发时触发");
}

// 扫描方法 返回对象包含索引 名称 uuid等
- (void)Scanning:(PGMethod*)commands{
    
    if(commands){
        // 回调id
        NSString* cbId = [commands.arguments objectAtIndex:0];
        SEPrinterManager *_manager = [SEPrinterManager sharedInstance];
        [_manager startScanPerpheralTimeout:10 Success:^(NSArray<CBPeripheral *> *perpherals,BOOL isTimeout) {
            @try {
                NSUInteger pcount = [perpherals count];
                NSMutableArray *temp = [NSMutableArray array];
                
                for (NSUInteger i = 0; i < pcount; i++) {
                    // 转化Integer为String
                    NSString *index = [[NSString alloc] initWithFormat:@"%lu",(unsigned long)i];
                    // 转化uuid为String
                    NSString *uuid = [[NSString alloc] initWithFormat:@"%@",perpherals[i].identifier];
                    // 组成字典结构
                    NSDictionary *device = @{@"index":index,@"name":perpherals[i].name,@"uuid":uuid};
                    // 放入数组
                    [temp addObject:device];
                }
                self.deviceArray = perpherals;
                PDRPluginResult * result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsArray:temp];
                result.keepCallback = true;
                NSLog(@"扫描中：");
                [self toCallback:cbId withReslut:[result toJSONString]];
            }
            @catch (NSException *exception) {
                // 异常停止搜索
                [_manager stopScan];
            }
        } failure:^(SEScanError error) {
            NSLog(@"error:%ld",(long)error);
        }];
    }
}
// 实时搜索后连接蓝牙设备，通过索引连接
- (void)ConnectByIndex:(PGMethod*)commands
{
    if(commands){
        // 获取回调ID
        NSString* cbId = [commands.arguments objectAtIndex:0];
        // 获取索引
        int index = [[commands.arguments objectAtIndex:1] intValue];
        // 获取对象
        CBPeripheral *per = [self.deviceArray objectAtIndex:index];
        [[SEPrinterManager sharedInstance] connectPeripheral:per completion:^(CBPeripheral *perpheral, NSError *error) {
            PDRPluginResult * result;
            if (error) {
                NSLog(@"连接：%@",@"连接失败");
                result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsString:@"error"];
            } else {
                NSLog(@"连接：%@",@"连接成功");
                // 停止扫描
                [[SEPrinterManager sharedInstance] stopScan];
                result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsString:@"success"];
            }
            [self toCallback:cbId withReslut:[result toJSONString]];
        }];
    }
}
// 通过uuid搜索蓝牙设备
- (void)ConnectByUuid:(PGMethod*)commands
{
    if(commands){
        // 获取回调id
        NSString *cbId = [commands.arguments objectAtIndex:0];
        // 获取uuid
        NSString *uuid = [commands.arguments objectAtIndex:1];
        // 计数器
        self.uuidstep = 0;
        SEPrinterManager *_manager = [SEPrinterManager sharedInstance];
        [_manager stopScan];
        [_manager startScanPerpheralTimeout:10 Success:^(NSArray<CBPeripheral *> *perpherals,BOOL isTimeout) {
            @try {
                // 由于++的步长是4 暂时未知？ 所以大于等于40次 则是尝试10次 没有则表示无法搜索到 则连接失败
                if(self.uuidstep >= 40){
                    // 停止扫描
                    [_manager stopScan];
                    PDRPluginResult * result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsString:@"error"];
                    [self toCallback:cbId withReslut:[result toJSONString]];
                    return;
                }
                self.uuidstep++;
                // 判断UUID是否存在
                NSUInteger pcount = [perpherals count];
                for(NSUInteger i = 0;i < pcount;i++){
                    NSString *puuid =[[NSString alloc] initWithFormat:@"%@",perpherals[i].identifier];
                    if([uuid isEqualToString:puuid]){
//                        if(_manager.isConnected == NO){
                        CBPeripheral *per = [perpherals objectAtIndex:i];
                        [_manager connectPeripheral:per completion:^(CBPeripheral *perpheral, NSError *error) {
                            PDRPluginResult * result;
                            if (error) {
                                NSLog(@"连接：%@",@"连接失败");
                                result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsString:@"error"];
                                [_manager stopScan];
                            } else {
                                NSLog(@"连接：%@",@"连接成功");
                                // 停止扫描
                                [_manager stopScan];
                                result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsString:@"success"];
                            }
                            [self toCallback:cbId withReslut:[result toJSONString]];
                        }];
//                        }
                    }
                }
                
            }
            @catch (NSException *exception) {
                // 异常停止搜索
                [_manager stopScan];
            }
        } failure:^(SEScanError error) {
            [_manager stopScan];
            PDRPluginResult * result;
            if(error == 5 || error == 4){
                result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsString:@"请开启蓝牙"];
            }else{
                result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsString:@"未知错误"];
            }
            
            [self toCallback:cbId withReslut:[result toJSONString]];
            NSLog(@"连接失败error:%ld",(long)error);
            return;
        }];
    }
}
// 直接发送打印的数据
- (void)SendData:(PGMethod*)commands
{
    // 获取cbid
    NSString *cbId = [commands.arguments objectAtIndex:0];
    // 获取数据
    NSString *data = [commands.arguments objectAtIndex:1];
    // 获取中心设备
    SEPrinterManager *_manager = [SEPrinterManager sharedInstance];
    NSLog(@"是否连接：%d",_manager.isConnected);
    // 判断当前是否连接
    if(_manager.isConnected){
        HLPrinter *printer = [[HLPrinter alloc] init];
        [printer appendText:data alignment:HLTextAlignmentCenter];
        
        NSData *mainData = [printer getFinalData];
        [_manager sendPrintData:mainData completion:^(CBPeripheral *connectPerpheral, BOOL completion, NSString *error) {
            NSLog(@"写入结：%d---错误:%@",completion,error);
            
            NSString *issuccess = [[NSString alloc] initWithFormat:@"%d",completion ? 0 : 1];
            NSDictionary *message = @{@"error":issuccess,@"msg":error};
            PDRPluginResult * result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsDictionary:message];
            [self toCallback:cbId withReslut:[result toJSONString]];
        }];
    }
}
@end
