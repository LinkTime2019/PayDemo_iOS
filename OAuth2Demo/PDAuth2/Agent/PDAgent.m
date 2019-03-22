//
//  PDAuth2.m
//  OAuth2Demo
//
//  Created by ethereum on 2019/2/21.
//  Copyright © 2019年 ethereum. All rights reserved.
//

#import "PDAgent.h"
#import "Networking.h"

#define PD_API_AUTH2  @"http://open.pandax.tech/oauth/token"
#define PD_API_TOKENS   @"http://120.79.161.66:9088/payment/tokens"
#define StringNoNull(value) value?value:@""

@implementation PDAgent

+ (void)accessTokenWithAppId:(NSString *)appid Appsecret:(NSString *)appsecret finish:(void (^)(NSDictionary *, NSError *))completion {
    NSDictionary *params = @{
                             @"grant_type":@"client_credentials",
                             @"client_id":StringNoNull(appid),
                             @"client_secret":StringNoNull(appsecret),
                             @"scope":@"basic",
                                 };
    [Networking postWithUrl:PD_API_AUTH2 parameters:params useToken:NO success:^(id json) {
        completion(json,nil);
    } failure:^(NSError *error) {
        completion(nil,error);
    }];
}

+ (void)tokensWithAccessToken:(NSString *)accessToken finish:(void (^)(NSArray *, NSError *))completion {
    [Networking getWithUrl:PD_API_TOKENS parameters:nil useCache:NO header:@{@"access_token":StringNoNull(accessToken)} success:^(id json) {
        NSLog(@"json:%@",json);
        completion(json[@"data"],nil);
    } failure:^(NSError *error, id dbData) {
        NSLog(@"error:%@",error);
        completion(nil,error);
    }];
}

+(void)tokensWithAppId:(NSString *)appid Appsecret:(NSString *)appsecret finish:(void (^)(NSArray *, NSError *))completion {
    [self accessTokenWithAppId:appid Appsecret:appsecret finish:^(NSDictionary *response, NSError *error) {
        if (!error && response[@"access_token"]) {
            NSString *accessToken = response[@"access_token"];
            [self tokensWithAccessToken:accessToken finish:^(NSArray *tokens, NSError *error) {
                completion(tokens,error);
            }];
        }else completion(nil,error);
    }];
}

@end
