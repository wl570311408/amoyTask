//
//  LoginAction.m
//  RegisterAndLogin
//
//  Created by wuliang on 13-4-15.
//  Copyright (c) 2013年 wuliang. All rights reserved.
//

#import "LoginAction.h"

#import <CommonCrypto/CommonDigest.h>

@implementation LoginAction

- (NSString *)loginActionWithAgent: (NSString *)agent  withKey: (NSString *)key    withUsername: (NSString *)username withPassword: (NSString *)password withServer: (NSString *) server{
    
    //--------------------------------形成urlString
    NSString *game = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    NSString *sign = [self md5:[NSString stringWithFormat:@"%@%@%@%@%@%@", username, password, agent, game, server, key]];
    //NSLog(@"sign:%@",[NSString stringWithFormat:@"%@%@%@%@%@%@", username, password, agent, game, server, key]);
    
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.1.181:84/login.php?agent=%@&username=%@&password=%@&game=%@&server=%@&sign=%@", agent, username, password, game, server, sign];
    //NSLog(@"urlString:%@",urlString);
    
    //--------------------------------请求url
    NSURL * url = [NSURL URLWithString:urlString];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    //加请求头文件
    [urlRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //设置请求方式
    [urlRequest setHTTPMethod:@"POST"];
    NSURLResponse *reponse;
    NSError * error = nil;
    //接受返回数据
    NSData  * responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&reponse error:&error];
    NSMutableString *
    result = [[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    return result;
}

- (NSString *) md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15] ];
}

@end
