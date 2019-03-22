#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@protocol PDProgressHUDDelegate;

typedef NS_ENUM(NSInteger, PDProgressHUDMode) {
	/** Progress is shown using an UIActivityIndicatorView. This is the default. */
	PDProgressHUDModeIndeterminate,
	/** Progress is shown using a round, pie-chart like, progress view. */
	PDProgressHUDModeDeterminate,
	/** Progress is shown using a horizontal progress bar */
	PDProgressHUDModeDeterminateHorizontalBar,
	/** Progress is shown using a ring-shaped progress view. */
	PDProgressHUDModeAnnularDeterminate,
	/** Shows a custom view */
	PDProgressHUDModeCustomView,
	/** Shows only labels */
	PDProgressHUDModeText
};

typedef NS_ENUM(NSInteger, PDProgressHUDAnimation) {
	/** Opacity animation */
	PDProgressHUDAnimationFade,
	/** Opacity + scale animation */
	PDProgressHUDAnimationZoom,
	PDProgressHUDAnimationZoomOut = PDProgressHUDAnimationZoom,
	PDProgressHUDAnimationZoomIn
};

#ifndef PD_INSTANCETYPE
#if __has_feature(objc_instancetype)
	#define PD_INSTANCETYPE instancetype
#else
	#define PD_INSTANCETYPE id
#endif
#endif

#ifndef PD_STRONG
#if __has_feature(objc_arc)
	#define PD_STRONG strong
#else
	#define PD_STRONG retain
#endif
#endif

#ifndef PD_WEAK
#if __has_feature(objc_arc_weak)
	#define PD_WEAK weak
#elif __has_feature(objc_arc)
	#define PD_WEAK unsafe_unretained
#else
	#define PD_WEAK assign
#endif
#endif

#if NS_BLOCKS_AVAILABLE_PD
typedef void (^PDProgressHUDCompletionBlock)(void);

#endif

@interface PDProgressHUD : UIView
+ (PD_INSTANCETYPE)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;

+ (NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated;

+ (PD_INSTANCETYPE)HUDForView:(UIView *)view;

+ (NSArray *)allHUDsForView:(UIView *)view;

- (id)initWithWindow:(UIWindow *)window;

- (id)initWithView:(UIView *)view;

- (void)show:(BOOL)animated;

- (void)hide:(BOOL)animated;

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;

- (void)showWhileExecuting:(SEL)method onTarget:(id)target withObject:(id)object animated:(BOOL)animated;

#if NS_BLOCKS_AVAILABLE_PD
- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block;

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block completionBlock:(PDProgressHUDCompletionBlock)completion;

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue;

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue
		  completionBlock:(PDProgressHUDCompletionBlock)completion;

@property (copy) PDProgressHUDCompletionBlock completionBlock;

#endif
@property (assign) PDProgressHUDMode mode;

@property (assign) PDProgressHUDAnimation animationType;

@property (PD_STRONG) UIView *customView;

@property (PD_WEAK) id<PDProgressHUDDelegate> delegate;

@property (copy) NSString *labelText;

@property (copy) NSString *detailsLabelText;

@property (assign) float opacity;

@property (PD_STRONG) UIColor *color;

@property (assign) float xOffset;

@property (assign) float yOffset;

@property (assign) float margin;

@property (assign) float cornerRadius;

@property (assign) BOOL dimBackground;

@property (assign) float graceTime;

@property (assign) float minShowTime;

@property (assign) BOOL taskInProgress;

@property (assign) BOOL removeFromSuperViewOnHide;

@property (PD_STRONG) UIFont* labelFont;

@property (PD_STRONG) UIColor* labelColor;

@property (PD_STRONG) UIFont* detailsLabelFont;

@property (PD_STRONG) UIColor* detailsLabelColor;

@property (PD_STRONG) UIColor *activityIndicatorColor;

@property (assign) float progress;

@property (assign) CGSize minSize;

@property (atomic, assign, readonly) CGSize size;

@property (assign, getter = isSquare) BOOL square;

@end

@protocol PDProgressHUDDelegate <NSObject>

@optional

- (void)hudWasHidden:(PDProgressHUD *)hud;

@end

@interface PDRoundProgressView : UIView 

@property (nonatomic, assign) float progress;

@property (nonatomic, PD_STRONG) UIColor *progressTintColor;

@property (nonatomic, PD_STRONG) UIColor *backgroundTintColor;

@property (nonatomic, assign, getter = isAnnular) BOOL annular;

@end

@interface PDBarProgressView : UIView

@property (nonatomic, assign) float progress;

@property (nonatomic, PD_STRONG) UIColor *lineColor;

@property (nonatomic, PD_STRONG) UIColor *progressRemainingColor;

@property (nonatomic, PD_STRONG) UIColor *progressColor;

@end
