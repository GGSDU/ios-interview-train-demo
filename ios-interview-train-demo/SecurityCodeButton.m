//
//  GetSecurityCodeButton.m
//  YDTX
//
//  Created by RookieHua on 2017/3/21.
//  Copyright © 2017年 RookieHua. All rights reserved.
//

#import "SecurityCodeButton.h"

@implementation SecurityCodeButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark - UI
- (void)createUI{
    [self setNormalStatus];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.layer.cornerRadius = 10 ;
    self.layer.masksToBounds = YES;
    
}
//正常态
- (void)setNormalStatus{
    self.enabled = YES;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor blueColor]];
    [self addTarget:self action:@selector(openCountdown) forControlEvents:UIControlEventTouchUpInside];
}
//倒计时态
- (void)setDisableStatusWithSec:(int)sec{
    self.enabled = NO;
    [self setTitle:[NSString stringWithFormat:@"重新发送(%d)",sec] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [self setBackgroundColor:[UIColor grayColor]];
}

//开启倒计时
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    //dispatch_source_set_timer 中第二个参数，当我们使用dispatch_time 或者 DISPATCH_TIME_NOW 时，系统会使用默认时钟来进行计时。然而当系统休眠的时候，默认时钟是不走的，也就会导致计时器停止。使用 dispatch_walltime 可以让计时器按照真实时间间隔进行计时。
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        NSLog(@"test1");
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setNormalStatus];
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [self setDisableStatusWithSec:seconds];
                
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
@end
