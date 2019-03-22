//
//  PDAuth2.h
//  OAuth2Demo
//
//  Created by ethereum on 2019/2/21.
//  Copyright © 2019年 ethereum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDProgressHUD.h"
#import "PDProgressHUD+Extention.h"


@interface PDAgent : NSObject

/**
 通过appid和appsecret获取accessToken

 @param appid 钱包平台获取的appid
 @param appsecret 钱包平台获取appid时对应的appsecret
 @param completion 请求完成回调方法[需要自行解析返回结果]
 */
+ (void)accessTokenWithAppId:(NSString *)appid Appsecret:(NSString *)appsecret finish:(void(^)(NSDictionary *response, NSError *error))completion;

/**
 通过accesstoken获取支持的代币列表

 @param accessToken 通过appid和appsecret从钱包后台获取accesstoken(获取方法如上)
 @param completion 请求完成回调方法
 */
+ (void)tokensWithAccessToken:(NSString *)accessToken finish:(void(^)(NSArray *tokens, NSError *error))completion;


@end
