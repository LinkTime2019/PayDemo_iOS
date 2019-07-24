# PayDemo_iOS

# 一、完整支付流程如下图:
<div align=center><img width="598" height="358" src="https://github.com/LinkTime2019/PayDemo_iOS/master/images/OAuth2流程.png"/></div>

# 二、申请对应的appid和appsecret;
前往PandaX注册获取appid和appsecret.

# 三、集成方法:
1、把OAuth2Demo内的PDAth2文件夹整个拖入工程(其包含了网络请求库AFNetworking,如有冲突,可删除文件夹内的AFNetworking并使用原工程的AFNetworking),并在需要调用支付的页面导入头文件:PandaX.h
如下图:
![集成示意图] (https://github.com/LinkTime2019/PayDemo_iOS/master/images/OAuth2流程.png)

# 四、使用方法:
1、如果希望PandaX支付成功之后反馈支付结果,那么需要调用方配置后台回调地址,调起PandaX进行支付的前,需要先使用appid 和 appsecret获取accesstoken,然后在将accesstoken连同其他参数一起传过去,示例如下:

参数说明:
address:收款地址;
token:转账的支付的代币类型;(可通过接口+ (void)tokensWithAccessToken:(NSString *)accessToken finish:(void(^)(NSArray *tokens, NSError *error))completion获取支持的代币列表);
access_token:授权码;
amountMoney:转账的数额;
appName:app名称,该名称用于支付结束返回提示框的显示; URLScheme:URLScheme,用于支付结束返回调用方app;

### - (NSString *)paramsBase64String {
###     NSDictionary *params = @{
###                              @"address":self.receiveAddressTF.text,
###                              @"token":self.tokenTF.text,
###                              @"access_token":self.access_token,
###                              @"amountMoney":self.transferAmountTF.text,
###                              @"appName":self.AppnameTF.text,
###                              @"URLScheme":self.URLSchemeTF.text             
###     					}.mutableCopy;
###     NSError *error;
###     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
###     NSString *jsonString;
###     if (!jsonData) {
###         NSLog(@"%@",error);
###     }else{
###         jsonString = [self base64EncodedStringFrom:jsonData];
###     }
###     return jsonString;
### }

# 2、如果不需要支付成功之后的反馈结果,不需要传accesstoken,示例如下:

### - (NSString *)paramsBase64String {
###     NSDictionary *params = @{
###                              @"address":self.receiveAddressTF.text,
###                              		@"token":self.tokenTF.text,
###                              		@"amountMoney":self.transferAmountTF.text,
###                              		@"appName":self.AppnameTF.text,
###                              		@"URLScheme":self.URLSchemeTF.text
###                              		}.mutableCopy;
###     NSError *error;
###     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
###     NSString *jsonString;
###     if (!jsonData) {
###         NSLog(@"%@",error);
###     }else{
###         jsonString = [self base64EncodedStringFrom:jsonData];
###     }
###     return jsonString;
### }



