
#import "MBProgressHUD+Extention.h"
#import "MBProgressHUD.h"

@implementation MBProgressHUD (Extention)

+ (void)showMessageM:(NSString*)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showMessage:message];
    });
}

+ (instancetype)showMessage:(NSString*)message{
    return [self showMessage:message toView:nil];
}

+ (instancetype)showMessage:(NSString*)message toView:(UIView*)view{
    return  [self showMessage:message toView:view autoHide:YES];
}


+ (instancetype)showMessage:(NSString*)message toView:(UIView*)view autoHide:(BOOL)autoHide{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    NSArray* subView = [view subviews];
    UIView* target;
    for (UIView* tempView in subView) {
        if ([tempView isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD* hud = (MBProgressHUD*)tempView;
            if (hud.labelText.length > 0) {
                target = tempView;
                break;
            }
        }
    }
    if (target) {
        [(MBProgressHUD*)target hide:NO];
    }
    
    // 快速显示一个提示信息
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    //    hud.labelText = StringNoNull(message);
    hud.detailsLabelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.labelFont = [UIFont systemFontOfSize:16];
    hud.margin = 20.0f;
    
    //一秒消失
    if (autoHide) [hud hide:YES afterDelay:1.5];
    return hud;
}


+ (void)hideHUDForView:(UIView*)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideHUDForView:view animated:YES];
    });
}



@end

