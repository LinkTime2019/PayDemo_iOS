//
//  PDAuth2.h
//  OAuth2Demo
//
//  Created by ethereum on 2019/2/21.
//  Copyright © 2019年 ethereum. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PDAgent : NSObject


+ (void)accessTokenWithAppId:(NSString *)appid configAddress:(NSString *)configAddr finish:(void(^)(NSDictionary *response, NSError *error))completion;
+ (void)accessTokenWithAppId:(NSString *)appid Appsecret:(NSString *)appsecret finish:(void(^)(NSDictionary *response, NSError *error))completion;


+ (void)tokensWithAccessToken:(NSString *)accessToken finish:(void(^)(NSArray *tokens, NSError *error))completion;
+ (void)tokensWithAppId:(NSString *)appid Appsecret:(NSString *)appsecret finish:(void(^)(NSArray *tokens, NSError *error))completion;

@end
