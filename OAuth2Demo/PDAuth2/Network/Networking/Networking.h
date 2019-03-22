
#import "AFNetworking.h"

@interface Networking : NSObject

@property (nonatomic,assign)  BOOL isNetWork;
@property (nonatomic, strong)AFHTTPSessionManager *sharedManager;

- (void)startNetWork;
+ (Networking *)shareInstance;

+ (void)getWithUrl:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id json))success failure:(void (^)(NSError* error))failure;

+ (void)postWithUrl:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id json))success failure:(void (^)(NSError* error))failure;

+ (void)postWithUrl:(NSString*)url parameters:(NSDictionary*)parameters useToken:(BOOL)useToken success:(void (^)(id json))success failure:(void (^)(NSError* error))failure;

+ (void)postWithUrl:(NSString*)url parameters:(NSDictionary*)parameters useTokenJ:(BOOL)useToken success:(void (^)(id))success failure:(void (^)(NSError*))failure;

+ (void)deleteWithUrl:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id))success failure:(void (^)(NSError*))failure;

/**System Get方法 不进行解析 可以获取html元素*/
+ (void)getStringWithUrl:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id json))success failure:(void (^)(NSError* error))failure;

+ (void)postPhotoUrl:(NSString*)url photoArray:(NSArray<UIImage*>*)photoArray parameters:(NSDictionary*)parameters success:(void (^)(id json))success failure:(void (^)(NSError* error))failure;
+ (void)postPhotoUrl:(NSString*)url photoArray:(NSArray<UIImage*>*)photoArray parameters:(NSDictionary*)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError*))failure;
+ (void)putWithUrl:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id))success failure:(void (^)(NSError*))failure;


/**增加使用离线缓存的方法*/
+ (void)getWithUrl:(NSString*)url parameters:(NSDictionary*)parameters useCache:(BOOL)useCache success:(void (^)(id json))success failure:(void (^)(NSError* error, id dbData))failure;

/**自定义header*/
+ (void)getWithUrl:(NSString*)url parameters:(NSDictionary*)parameters useCache:(BOOL)useCache header:(NSDictionary *)headers success:(void (^)(id json))success failure:(void (^)(NSError* error, id dbData))failure;

@end
