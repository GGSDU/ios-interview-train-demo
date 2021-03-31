//
//  ViewController.m
//  ios-interview-train-demo
//
//  Created by story5 on 2021/3/24.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,assign) NSInteger ticketSurplusCount;
@property (nonatomic,strong) NSThread *ticketSaleWindow1;
@property (nonatomic,strong) NSThread *ticketSaleWindow2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self demo1];
//    [self demo2];
//    [self demo3];
//    [self threadMethods];
//    [self threadStautsControl];
//    [self initTicketStatusNotSave];
    [self initTicketStatusSave];
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

// 线程相关方法
- (void)threadMethods {
    // 获得主线程
    NSThread *thread = [NSThread mainThread];
    // 判断是否为主线程(对象方法)
    [thread isMainThread];
    // 判断是否为主线程(类方法)
    [NSThread isMainThread];
    // 获得当前线程
    NSThread *current = [NSThread currentThread];
    // 线程的名字——setter方法
    [current setName:@"testThreadName"];
    // 线程的名字——getter方法
    NSLog(@"%@",current.name);
}

// 线程状态控制方法
- (void)threadStautsControl {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(runWithParam:) object:@"threadStautsControl test param"];
    // 启动线程方法
    [thread start];
    // 强制停止线程
//    [NSThread exit];
    
    // 阻塞（暂停）线程方法
//    + (void)sleepUntilDate:(NSDate *)date;
//    + (void)sleepForTimeInterval:(NSTimeInterval)ti;
    // 线程进入阻塞状态
}

- (void)runWithParam:(NSString *)param {
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"param:%@",param);
}

/**
 * 初始化火车票数量、卖票窗口(非线程安全)、并开始卖票
 */
- (void)initTicketStatusNotSave {
    // 1. 设置剩余火车票为 50
    self.ticketSurplusCount = 50;
    
    // 2. 设置北京火车票售卖窗口的线程
    self.ticketSaleWindow1 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicketNotSafe) object:nil];
    self.ticketSaleWindow1.name = @"北京火车票售票窗口";
    
    // 3. 设置上海火车票售卖窗口的线程
    self.ticketSaleWindow2 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicketNotSafe) object:nil];
    self.ticketSaleWindow2.name = @"上海火车票售票窗口";
    
    // 4. 开始售卖火车票
    [self.ticketSaleWindow1 start];
    [self.ticketSaleWindow2 start];

}

/**
 * 初始化火车票数量、卖票窗口(线程安全)、并开始卖票
 */
- (void)initTicketStatusSave {
    // 1. 设置剩余火车票为 50
    self.ticketSurplusCount = 50;
    
    // 2. 设置北京火车票售卖窗口的线程
    self.ticketSaleWindow1 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicketSafe) object:nil];
    self.ticketSaleWindow1.name = @"北京火车票售票窗口";
    
    // 3. 设置上海火车票售卖窗口的线程
    self.ticketSaleWindow2 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicketSafe) object:nil];
    self.ticketSaleWindow2.name = @"上海火车票售票窗口";
    
    // 4. 开始售卖火车票
    [self.ticketSaleWindow1 start];
    [self.ticketSaleWindow2 start];
    
}

/**
 * 售卖火车票(非线程安全)
 */
- (void)saleTicketNotSafe {
    while (1) {
        //如果还有票，继续售卖
        if (self.ticketSurplusCount > 0) {
            self.ticketSurplusCount --;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", self.ticketSurplusCount, [NSThread currentThread].name]);
            [NSThread sleepForTimeInterval:0.2];
        }
        //如果已卖完，关闭售票窗口
        else {
            NSLog(@"所有火车票均已售完");
            break;
        }
    }
}



/**
 * 售卖火车票(线程安全)
 */
- (void)saleTicketSafe {
    while (1) {
        // 互斥锁
        @synchronized (self) {
            //如果还有票，继续售卖
            if (self.ticketSurplusCount > 0) {
                self.ticketSurplusCount --;
                NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", self.ticketSurplusCount, [NSThread currentThread].name]);
                [NSThread sleepForTimeInterval:0.2];
            }
            //如果已卖完，关闭售票窗口
            else {
                NSLog(@"所有火车票均已售完");
                break;
            }
        }
    }
}

@end
