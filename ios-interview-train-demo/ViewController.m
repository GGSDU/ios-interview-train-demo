//
//  ViewController.m
//  ios-interview-train-demo
//
//  Created by story5 on 2021/3/24.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self demo1];
//    [self demo2];
    [self demo3];
}

- (void)demo1 {
    // 1. 创建线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    // 2. 启动线程
    [thread start];    // 线程一启动，就会在线程thread中执行self的run方法
}

- (void)demo2 {
    // 1. 创建线程后自动启动线程
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
}

- (void)demo3 {
    // 1. 隐式创建并启动线程
    [self performSelectorInBackground:@selector(run) withObject:nil];
}

// 新线程调用方法，里边为需要执行的任务
- (void)run {
     NSLog(@"%@", [NSThread currentThread]);
}

@end
