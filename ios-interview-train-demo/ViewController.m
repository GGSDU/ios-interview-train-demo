//
//  ViewController.m
//  ios-interview-train-demo
//
//  Created by story5 on 2021/3/24.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self showDemo1];
//    [self showDemo2];
//    [self showDemo3];
    [self showDemo4];
}

- (void)showDemo1 {
    // 定义一个定时器,约定两秒后调用run方法
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    // 将定时器添加到当前RunLoop的NSDefaultRunLoopMode下
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)run {
    NSLog(@"---run");
}

- (void)showDemo2 {
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    // 相当于以下两句代码
//    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (IBAction)btnClick:(id)sender {
    NSLog(@"btnClick...");
}

- (void)showDemo3 {
    // 创建观察者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"监听到RunLoop发生改变---%zd",activity);
    });

    // 添加观察者到当前RunLoop中
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);

    // 释放observer，最后添加完需要释放掉
    CFRelease(observer);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"icon.png"] afterDelay:2.0 inModes:@[NSDefaultRunLoopMode]];
    
    // 利用
    [self performSelector:@selector(run42) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)showDemo4 {
    // 创建线程,并调用run4方法执行任务
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(run41) object:nil];
    // 开启线程
    [self.thread start];
}

- (void)run41 {
    // 这里写任务
    NSLog(@"---run41---");
    
    // 添加以下两句代码,就可以开启RunLoop,之后self.thread就变成了常驻线程,可以随时添加任务,并交于RunLoop处理
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    
    // 测试是否开启了RunLoop,如果开启了RunLoop,则来不了这里,因为RunLoop开启了循环
    NSLog(@"未开启RunLoop");
}

- (void)run42 {
    NSLog(@"---run42---");
}

@end
