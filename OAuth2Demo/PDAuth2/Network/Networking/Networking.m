
#import "Networking.h"

@interface Networking ()
@end

@implementation Networking

+ (Networking *)shareInstance{
    static dispatch_once_t pred = 0;
    __strong static Networking *_sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[Networking alloc] init];
        _sharedObject.sharedManager =  [AFHTTPSessionManager manager];
    });
    return _sharedObject;
}

- (void)startNetWork{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                self.isNetWork=NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                self.isNetWork=YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                self.isNetWork=YES;
                break;
        }
    }];
    // 开始监控
    [manager startMonitoring];
}

- (void)setIsNetWork:(BOOL)isNetWork {
    _isNetWork = isNetWork;
//    if (!_isNetWork) [PDProgressHUD showMessage:PD_LOCAL(@"Network_disconnected")];
    NSLog(@"Network_disconnected");
}

+ (void)getWithUrl:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id))success failure:(void (^)(NSError*))failure{
    NSLog(@"url:%@|params:%@",url,parameters);
    AFHTTPSessionManager* manager = [Networking shareInstance].sharedManager;
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    [manager.requestSerializer setValue:QWTokenTemp forHTTPHeaderField:@"authorization"];
    
    [manager GET:url
        parameters:parameters
        progress:^(NSProgress* _Nonnull downloadProgress) {

        }
        success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
            if (responseObject) {
                //[[ZHJson new] saveCompressionJsonDic:responseObject toMac:url];
                success(responseObject);
            }
        }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
            if (error) {
                failure(error);
            }
        }];
}

+ (void)postWithUrl:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id))success failure:(void (^)(NSError*))failure{
    NSLog(@"url:%@|params:%@",url,parameters);
    AFHTTPSessionManager* manager = [Networking shareInstance].sharedManager;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    [manager.requestSerializer setValue:QWTokenTemp forHTTPHeaderField:@"authorization"];
    [manager POST:url
        parameters:parameters
        progress:^(NSProgress* _Nonnull uploadProgress) {

        }
        success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
            if (responseObject) {
                //[[ZHJson new] saveCompressionJsonDic:responseObject toMac:url];
                success(responseObject);
            }
        }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
            if (error) {
                failure(error);
            }
        }];
}


+ (void)postWithUrl:(NSString*)url parameters:(NSDictionary*)parameters useTokenJ:(BOOL)useToken success:(void (^)(id))success failure:(void (^)(NSError*))failure{
    NSLog(@"url:%@|params:%@",url,parameters);
    AFHTTPSessionManager* manager = [Networking shareInstance].sharedManager;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    //    [manager.requestSerializer setValue:QWTokenTemp forHTTPHeaderField:@"authorization"];
    #if UT_USE_TOKEN
    if (useToken) [manager.requestSerializer setValue:UT_GET_TOKEN([UTUserInfo shared].token) forHTTPHeaderField:@"Authorization"];
    #endif
    [manager POST:url
       parameters:parameters
         progress:^(NSProgress* _Nonnull uploadProgress) {
             
         }
          success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
              if (responseObject) {
                  //[[ZHJson new] saveCompressionJsonDic:responseObject toMac:url];
                  success(responseObject);
              }
          }
          failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
              if (error) {
                  failure(error);
              }
          }];
}


+ (void)postWithUrl:(NSString*)url parameters:(NSDictionary*)parameters useToken:(BOOL)useToken success:(void (^)(id json))success failure:(void (^)(NSError* error))failure {
    NSLog(@"url:%@|params:%@",url,parameters);
    AFHTTPSessionManager* manager = [Networking shareInstance].sharedManager;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    #if UT_USE_TOKEN
    if (useToken) [manager.requestSerializer setValue:UT_GET_TOKEN([UTUserInfo shared].token) forHTTPHeaderField:@"Authorization"];
    #endif
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //do nothing
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            //[[ZHJson new] saveCompressionJsonDic:responseObject toMac:url];
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
}

+ (void)deleteWithUrl:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id))success failure:(void (^)(NSError*))failure{
    NSLog(@"url:%@|params:%@",url,parameters);
    AFHTTPSessionManager* manager = [Networking shareInstance].sharedManager;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    [manager.requestSerializer setValue:QWTokenTemp forHTTPHeaderField:@"authorization"];
    [manager DELETE:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            //[[ZHJson new] saveCompressionJsonDic:responseObject toMac:url];
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
}

+ (void)getStringWithUrl:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id))success failure:(void (^)(NSError*))failure{
    NSLog(@"url:%@|params:%@",url,parameters);
    AFHTTPSessionManager* manager = [Networking shareInstance].sharedManager;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url
        parameters:parameters
        progress:^(NSProgress* _Nonnull downloadProgress) {

        }
        success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
            if (responseObject) {
                //[[ZHJson new] saveCompressionJsonDic:responseObject toMac:url];
                success(responseObject);
            }
        }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
            if (error) {
                failure(error);
            }
        }];
}

+ (void)postPhotoUrl:(NSString*)url photoArray:(NSArray<UIImage*>*)photoArray parameters:(NSDictionary*)parameters success:(void (^)(id))success failure:(void (^)(NSError*))failure{

    if (photoArray.count == 0) {
        return;
    }
    NSLog(@"url:%@|params:%@",url,parameters);
    // 向服务器提交图片
    //1.创建管理者对象
    AFHTTPSessionManager* manager = [Networking shareInstance].sharedManager;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    //2.上传文件
    [manager POST:url
        parameters:parameters
        constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
            for (int i = 0; i < photoArray.count; i++) {
                //压缩
                NSData* imageDtata = UIImagePNGRepresentation(photoArray[i]);
                NSDate* currentDate = [NSDate date]; //获取当前时间，日期
                NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:[NSString stringWithFormat:@"yyyyMMddHHmmss%d", i]];
                NSString* uploadImage = [NSString stringWithFormat:@"%@.png", [dateFormatter stringFromDate:currentDate]];
                //上传文件参数
                [formData appendPartWithFileData:imageDtata name:@"file" fileName:uploadImage mimeType:@"image/jpeg"];
            }
        }
        progress:^(NSProgress* _Nonnull uploadProgress) {
            //打印上传进度
        }
        success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
            if (responseObject) {
                success(responseObject);
            }
        }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
            if (error) {
                failure(error);
            }
        }];
}

+ (void)postPhotoUrl:(NSString*)url photoArray:(NSArray<UIImage*>*)photoArray parameters:(NSDictionary*)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError*))failure{
    
    if (photoArray.count == 0) return;
    
    // 向服务器提交图片
    //1.创建管理者对象
    AFHTTPSessionManager* manager = [Networking shareInstance].sharedManager;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    //2.上传文件
    [manager POST:url
       parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
    for (int i = 0; i < photoArray.count; i++) {
        //压缩
        NSData* imageDtata = UIImagePNGRepresentation(photoArray[i]);
        NSDate* currentDate = [NSDate date]; //获取当前时间，日期
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:[NSString stringWithFormat:@"yyyyMMddHHmmss%d", i]];
        NSString* uploadImage = [NSString stringWithFormat:@"%@.png", [dateFormatter stringFromDate:currentDate]];
        //上传文件参数
        [formData appendPartWithFileData:imageDtata name:@"file" fileName:uploadImage mimeType:@"image/jpeg"];
    }
}
         progress:^(NSProgress* _Nonnull uploadProgress) {
             progress(uploadProgress);
         }
          success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
              if (responseObject) {
                  success(responseObject);
              }
          }
          failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
              if (error) {
                  failure(error);
              }
          }];
}


+ (void)putWithUrl:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id))success failure:(void (^)(NSError*))failure{
    NSLog(@"url:%@|params:%@",url,parameters);
    AFHTTPSessionManager* manager = [Networking shareInstance].sharedManager;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    //    [manager.requestSerializer setValue:QWTokenTemp forHTTPHeaderField:@"authorization"];
    [manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            //[[ZHJson new] saveCompressionJsonDic:responseObject toMac:url];
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
}

+ (void)getWithUrl:(NSString *)url parameters:(NSDictionary *)parameters useCache:(BOOL)useCache success:(void (^)(id))success failure:(void (^)(NSError *, id))failure {
    //do nothing
}

+ (void)getWithUrl:(NSString*)url parameters:(NSDictionary*)parameters useCache:(BOOL)useCache header:(NSDictionary *)headers success:(void (^)(id json))success failure:(void (^)(NSError* error, id dbData))failure {
    NSLog(@"url:%@|params:%@",url,parameters);
    AFHTTPSessionManager* manager = [Networking shareInstance].sharedManager;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    for (NSString *key in headers.allKeys) {
        [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
    }
    [manager GET:url
      parameters:parameters
        progress:^(NSProgress* _Nonnull downloadProgress) {
            
        }
         success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
             if (responseObject) {
                 //[[ZHJson new] saveCompressionJsonDic:responseObject toMac:url];
                 success(responseObject);
             }
         }
         failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
             if (error) {
                 failure(error,nil);
             }
         }];

}
@end

