
#import <UIKit/UIKit.h>

@class LXLoadingView;

void ShowMessage(NSString *statues);

void BeginLoading(void);

void EndLoading(void);

@interface UIView (ShowExtension)

/**
 开始loading
 */
- (void)beginLoading;

/**
 结束loading
 */
- (void)endLoading;

/**
 show提示

 @param message 提示内容
 */
- (void)showHint:(NSString *)message;

/**
 show提示

 @param message 信息
 @param showTime 展示时间
 */
- (void)showHint:(NSString *)message time:(NSTimeInterval)showTime;

/**
 获取基于的控制器

 @return 基于的控制器
 */
- (UIViewController *)_locationController;

@end

//loading加载效果
@interface LXLoadingView : UIView

+ (LXLoadingView *)shareLoading;

@property (nonatomic, strong) UIView *loadingView;

@property (nonatomic, assign) NSTimeInterval delayTime;//延时loading时间

- (void)startAnimating;

- (void)stopAnimating;

@end


