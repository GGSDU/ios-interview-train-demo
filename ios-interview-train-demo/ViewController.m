//
//  ViewController.m
//  ios-interview-train-demo
//
//  Created by story5 on 2021/3/24.
//

#import "ViewController.h"
#import "Father.h"
#import "Son.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Father *father1 = [[Father alloc] init];
    Father *father2 = [[Father alloc] init];
    Son *son1 = [Son new];
    Son *son2 = [Son new];
}


@end
