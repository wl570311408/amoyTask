//
//  LoginAction.h
//  RegisterAndLogin
//
//  Created by wuliang on 13-4-15.
//  Copyright (c) 2013年 wuliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginAction : NSObject

- (NSString *)loginActionWithAgent: (NSString *)agent  withKey: (NSString *)key    withUsername: (NSString *)username withPassword: (NSString *)password withServer: (NSString *) server;

@end
