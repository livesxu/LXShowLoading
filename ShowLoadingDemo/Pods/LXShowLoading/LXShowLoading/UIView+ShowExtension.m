
#import "UIView+ShowExtension.h"

#import "MBProgressHUD.h"

void ShowMessage(NSString *statues){
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    [keyWindow showHint:statues];
}

void BeginLoading(void){
    
    [[LXLoadingView shareLoading] startAnimating];
}

void EndLoading(void){
    
    [[LXLoadingView shareLoading] stopAnimating];
}

@implementation UIView (ShowExtension)

- (void)beginLoading{
    
    [[LXLoadingView shareLoading] startAnimating];
}

- (void)endLoading{
    
    [[LXLoadingView shareLoading] stopAnimating];
}

/**
 show提示
 
 @param msg 提示内容
 */
- (void)showHint:(NSString *)msg;{
    
    if (msg == nil || [msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return;
    }
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!self.window && self != [UIApplication sharedApplication].keyWindow) return;
            [self hudShowHintWithMsg:msg baseView:self time:1.0f];
        });
    } else {
        if (!self.window && self != [UIApplication sharedApplication].keyWindow) return;
        [self hudShowHintWithMsg:msg baseView:self time:1.0f];
    }
}

- (void)showHint:(NSString *)message time:(NSTimeInterval)showTime {
    
    [self hudShowHintWithMsg:message baseView:self time:showTime];
}

- (void)hudShowHintWithMsg:(NSString *)msg baseView:(UIView *)view time:(NSTimeInterval)showTime {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabel.text = msg;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14.0f];
    hud.margin = 10.0f;
    [hud hideAnimated:YES afterDelay:showTime];
}

/**
 获取基于的控制器
 
 @return 基于的控制器
 */
- (UIViewController *)_locationController;{
    
    id next = [self nextResponder];
    while(![next isKindOfClass:[UIViewController class]] && next)
    {
        next = [next nextResponder];
    }
    UIViewController *vc= (UIViewController *)next;
    
    return vc;
}

@end


@interface LXLoadingView ()

@property (nonatomic, assign) NSInteger loadingCount;//loading计数

@property (assign, nonatomic) BOOL isLoading;

@end

@implementation LXLoadingView

+ (LXLoadingView *)shareLoading {
    
    static LXLoadingView *loading = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        loading = [[LXLoadingView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    });
    return loading;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.1f];
        
        self.loadingCount = 0;
        self.delayTime = 0;
    }
    return self;
}

- (void)setLoadingView:(UIView *)loadingView {
    _loadingView = loadingView;
    
    CGSize loadingSize = _loadingView.frame.size;
    
    _loadingView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - loadingSize.width)/2,([UIScreen mainScreen].bounds.size.height - loadingSize.height)/2, loadingSize.width, loadingSize.height);
    
    [self addSubview:_loadingView];
}

- (void)startAnimating{
    
    self.loadingCount += 1;
}

- (void)stopAnimating{
    
    self.loadingCount -= 1;
}

- (void)setLoadingCount:(NSInteger)loadingCount{
    _loadingCount = loadingCount;
    
    if (_loadingCount > 0) {
        if (self.isLoading) {
            return;
        }
        self.isLoading = YES;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self performSelector:@selector(show) withObject:nil afterDelay:self.delayTime];
        });
        
    } else {
        _loadingCount = 0;
        if (!self.isLoading) {
            return;
        }
        self.isLoading = NO;
        [self dismiss];
    }
}

- (void)show {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (!self.isLoading) {
            return;
        }
        UIWindow *window = ((UIWindow *)[UIApplication sharedApplication].keyWindow);
        [window addSubview:self];
        [window endEditing:YES];
    });
}

- (void)dismiss {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(show) object:nil];
        [self removeFromSuperview];
    });
}

@end
