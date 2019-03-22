
#import "MBProgressHUD.h"

@interface MBProgressHUD (Extention)

+ (instancetype)showMessage:(NSString*)message;

+ (void)showMessageM:(NSString*)message;

+ (instancetype)showMessage:(NSString*)message toView:(UIView*)view;

+ (instancetype)showMessage:(NSString*)message toView:(UIView*)view autoHide:(BOOL)autoHide;

+ (void)hideHUDForView:(UIView*)view;

@end
