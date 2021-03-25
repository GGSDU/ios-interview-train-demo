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
    [self useBlockInterceptLocalVariables];
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

- (void)retainCycleBlock {
    Person *person = [[Person alloc] init];
    
    __weak typeof(person) weakPerson = person;
    person.blk = ^{
        NSLog(@"%@",weakPerson);
    };
}


@end
