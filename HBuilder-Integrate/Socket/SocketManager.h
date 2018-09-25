//
//  SocketManager.h
//  TCPSocketServer-Demo
//
//  Copyright © 2016年 Steven. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCDAsyncSocket;
@interface SocketManager : NSObject

@property (strong, nonatomic)GCDAsyncSocket * mySocket;
+ (SocketManager *)sharedSocketManager;
@end
