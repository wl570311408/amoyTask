//
//  RegisterAction.m
//  RegisterAndLogin
//
//  Created by wuliang on 13-4-15.
//  Copyright (c) 2013年 wuliang. All rights reserved.
//

#import "RegisterAction.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import <CommonCrypto/CommonDigest.h>

@implementation RegisterAction


- (NSString *)registerActionWithAgent: (NSString *)agent  withKey: (NSString *)key    withUsername: (NSString *)username withPassword: (NSString *)password withRepassword: (NSString *) repassword withServer: (NSString *) server{
    
    //--------------------------------形成urlString
    NSString *game = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *mac = [self macaddress];
    
    NSString *sign = [self md5:[NSString stringWithFormat:@"%@%@%@%@%@", agent, username, password, repassword, key]];
    NSLog(@"sign:%@", [NSString stringWithFormat:@"%@%@%@%@%@", agent, username, password, repassword, key]);
    
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.1.181:84/reg_new.php?agent=%@&username=%@&password=%@&rpassword=%@&game=%@&server=%@&mac=%@&sign=%@", agent, username, password, repassword, game, server, mac, sign];
    
    NSLog(@"urlString:%@",urlString);
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



- (NSString *) macaddress
{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            msgBuffer =(char*) malloc(length) ;
            if ((msgBuffer) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        //  DLog(@"Error: %@", errorFlag);
        return errorFlag;
    }
    
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}


@end
