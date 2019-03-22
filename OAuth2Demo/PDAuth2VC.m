//
//  PDAuth2VC.m
//  OAuth2Demo
//
//  Created by ethereum on 2019/2/21.
//  Copyright © 2019年 ethereum. All rights reserved.
//

#import "PDAuth2VC.h"
#import "PandaX.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Extention.h"


static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@interface PDAuth2VC ()
@property (nonatomic, copy)NSString *access_token;
@property (weak, nonatomic) IBOutlet UITextField *receiveAddressTF;
@property (weak, nonatomic) IBOutlet UITextField *transferAmountTF;
@property (weak, nonatomic) IBOutlet UITextField *tokenTF;
@property (weak, nonatomic) IBOutlet UITextField *AppnameTF;
@property (weak, nonatomic) IBOutlet UITextField *URLSchemeTF;
@property (weak, nonatomic) IBOutlet UITextView *requesResultTF;
@end

@implementation PDAuth2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"三方授权";
}


/**
 获取accesstoken
 */
- (IBAction)fetchAccessTokenAction:(id)sender {
    self.requesResultTF.text = @"";
    [PDAgent accessTokenWithAppId:@"unitimes" Appsecret:@"123456" finish:^(NSDictionary *response, NSError *error) {
        NSLog(@"error:%@|response:%@",error,response);
        self.access_token = response[@"access_token"];
        [self updateRequestResultTF:[NSString stringWithFormat:@"access_token:%@",self.access_token]];
    }];
}


/**
 获取支持的代币列表
 */
- (IBAction)fetchTokensAction:(id)sender {
    if (self.access_token.length == 0) {
        [MBProgressHUD showMessage:@"请先获取access_token!"];
        return;
    }
    [PDAgent tokensWithAccessToken:self.access_token finish:^(NSArray *tokens, NSError *error) {
        NSLog(@"tokens:%@|error:%@",tokens,error);
        [self updateRequestResultTF:[NSString stringWithFormat:@"tokens:%@",tokens]];
    }];
}


/**
 调用钱包客户端
 */
- (IBAction)openPandaX:(id)sender {
    if (self.receiveAddressTF.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入转账地址!"];
        return;
    }
    if (self.transferAmountTF.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入转账金额!"];
        return;
    }
    if (self.tokenTF.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入转账的Token!"];
        return;
    }
    if (self.AppnameTF.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入应用名称!"];
        return;
    }
    if (self.URLSchemeTF.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入URLScheme!"];
        return;
    }
    
    if (self.access_token.length == 0) {
        [MBProgressHUD showMessage:@"请先获取access_token!"];
        return;
    }
    

    NSString *paramsBase64Str = [self paramsBase64String];
    NSString *urlStr = [NSString stringWithFormat:@"PandaX://%@",paramsBase64Str];
    NSURL* urlLocal = [NSURL URLWithString:urlStr];
    
    // 判断是否可以启动该 url
    if([[UIApplication sharedApplication] canOpenURL:urlLocal])
    {
        [[UIApplication sharedApplication] openURL:urlLocal];
        NSLog(@"launch AppDemo2 success!");
    }
    else
    {
        NSLog(@"No such url.");
        /// 跳到 appStore
        NSURL* urlAppStore = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/tie-lu12306/id1367025446?mt=8"];
        [[UIApplication sharedApplication] openURL: urlAppStore];
    }
}

- (void)updateRequestResultTF:(NSString *)result {
    dispatch_async(dispatch_get_main_queue(), ^{
       self.requesResultTF.text = result;
    });
}

- (NSString *)paramsBase64String {
    NSDictionary *params = @{
                             @"address":self.receiveAddressTF.text,
                             @"token":self.tokenTF.text,
                             @"access_token":self.access_token,
                             @"amountMoney":self.transferAmountTF.text,
                             @"appName":self.AppnameTF.text,
                             @"URLScheme":self.URLSchemeTF.text
                             }.mutableCopy;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [self base64EncodedStringFrom:jsonData];
    }
    return jsonString;
}

- (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
    return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
    return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
        buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
        characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
        characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
