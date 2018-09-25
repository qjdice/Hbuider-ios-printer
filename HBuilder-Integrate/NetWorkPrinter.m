//
//  PluginTest.m
//  HBuilder-Hello
//
//  Created by Mac Pro on 14-9-3.
//  Copyright (c) 2014年 DCloud. All rights reserved.
//

#import "NetWorkPrinter.h"
#import "PDRCoreAppFrame.h"
#import "H5WEEngineExport.h"
#import "PDRToolSystemEx.h"
#import "WebViewForImage.h"
#import "Socket/SocketManager.h"
#import "HLPrinter.h"
// 扩展插件中需要引入需要的系统库
#import <LocalAuthentication/LocalAuthentication.h>

@interface NetWorkPrinter() <GCDAsyncSocketDelegate>
@property(strong,nonatomic) GCDAsyncSocket* clientSocket;

@end

@implementation NetWorkPrinter

#pragma mark 这个方法在使用WebApp方式集成时触发，WebView集成方式不触发

// 连接打印机
- (void) StartConnect:(PGMethod*)commands
{
    // 获取cbId
    NSString *cbId = [commands.arguments objectAtIndex:0];
    // 获取连接地址
    NSString *address = [commands.arguments objectAtIndex:1];
    // 获取连接端口
    NSString *port = [commands.arguments objectAtIndex:2];
    
    PDRPluginResult * result;
    
    [self toCallback:cbId withReslut:[result toJSONString]];
    
    
    NSLog(@"连接状态:%d",[self.clientSocket isConnected]);
    // 未连接
    if(![self.clientSocket isConnected]){
        // 初始化对象
        self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        NSError * error = nil;
        // 开始连接
        BOOL status = [self.clientSocket connectToHost:address onPort:[port integerValue] error:&error];
        
        if(status){
            result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsString:@"success"];
        }else{
            result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsString:@"error"];
        }
    }else{
        // 如果已连接 且 地址一致则不重新链接
        NSString *originaddress = [self.clientSocket connectedHost];
        
        // 地址一致并且已连接
        if(originaddress == address){
            result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsString:@"该连接已存在"];
        }else{
            // 地址不一致 重新连接
            // 初始化对象
            self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
            NSError * error = nil;
            // 开始连接
            BOOL status = [self.clientSocket connectToHost:address onPort:[port integerValue] error:&error];
            if(status){
                result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsString:@"success"];
            }else{
                result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsString:@"error"];
            }
        }
    }
    [self toCallback:cbId withReslut:[result toJSONString]];
}
// 获取当前连接状态
- (void) GetConnectStatus:(PGMethod *)commands
{
    // 获取cbid
    NSString *cbId = [commands.arguments objectAtIndex:0];
    
    PDRPluginResult * result;
    
    NSDictionary *message;
    if([self.clientSocket isConnected]){
        NSString *connectedhost = [[NSString alloc] initWithString:[self.clientSocket connectedHost]];
        message = @{@"status":@"success",@"host":connectedhost};
        result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsDictionary:message];
    }else{
        message = @{@"status":@"error",@"host":@""};
        result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsDictionary:message];
    }
    
    
    [self toCallback:cbId withReslut:[result toJSONString]];
}

// 发送打印数据
- (void) SendData:(PGMethod *)commands
{
    // 回调iD
    NSString *cbId = [commands.arguments objectAtIndex:0];
    // 打印数据
    NSString *text = [commands.arguments objectAtIndex:1];
    
    PDRPluginResult * result;
    if(!text){
        result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsString:@"打印数据不能为空"];
        [self toCallback:cbId withReslut:[result toJSONString]];
        return;
    }
    
    if(![self.clientSocket isConnected]){
        result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsString:@"打印机未连接"];
        [self toCallback:cbId withReslut:[result toJSONString]];
        return;
    }
    
    HLPrinter *printer = [[HLPrinter alloc] init];
    [printer appendText:text alignment:HLTextAlignmentCenter];
    NSData *mainData = [printer getFinalData];
    [self.clientSocket writeData:mainData withTimeout:-1 tag:0];
    
    result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsString:@"打印成功"];
    [self toCallback:cbId withReslut:[result toJSONString]];
    
}
@end
