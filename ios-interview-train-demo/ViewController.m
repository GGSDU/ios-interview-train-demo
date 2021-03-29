//
//  ViewController.m
//  ios-interview-train-demo
//
//  Created by story5 on 2021/3/24.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self useBlockInterceptLocalVariables];
    [self nestBlock];
}

// 使用 Blocks 截获局部变量值
- (void)useBlockInterceptLocalVariables {
    __block int a = 10, b = 20;
    void (^myLocalBlock)(void) = ^{
        a = 20;
        b = 30;
        printf("in block a = %d, b= %d\n",a,b);
    };
    myLocalBlock();
    printf("out block a = %d, b= %d\n",a,b);
    a = 40;
    b = 50;
    myLocalBlock();
}


// 循环引用
- (void)retainCycleBlock {
    Person *person = [[Person alloc] init];
        
    __weak typeof(person) weakPerson = person;
    person.blk = ^{
        NSLog(@"%@",weakPerson);
    };
    person.blk();
}

// 嵌套block
-(void)nestBlock {
    Person *person = [[Person alloc] init];
    __weak typeof(person) weakPerson = person;
    person.blk = ^{
        NSLog(@"%@",weakPerson);
        __strong typeof(person) strongPerson = weakPerson;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)2.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            NSLog(@"%@",strongPerson);
        });
    };
    person.blk();
}


@end
