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
//    [self testNSString];
    [self testArray];
}

// 容器类
- (void)testArray {
    NSLog(@"%s",__func__);
    NSArray *array = @[@[@"123"]];
    NSArray *array1 = [array copy];
    NSMutableArray *array2 = [array mutableCopy];
    NSLog(@"class:%@---%p---%p",[array class],array,array[0]);
    NSLog(@"class:%@---%p---%p",[array1 class],array1,array1[0]);
    NSLog(@"class:%@---%p---%p",[array2 class],array2,array2[0]);
    
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithObjects:@[@"123"], nil];
    NSArray *mArray1 = [mArray copy];
    NSMutableArray *mArray2 = [mArray mutableCopy];
    NSLog(@"class:%@---%p---%p",[mArray class],mArray,mArray[0]);
    NSLog(@"class:%@---%p---%p",[mArray1 class],mArray1,mArray1[0]);
    NSLog(@"class:%@---%p---%p",[mArray2 class],mArray2,mArray2[0]);

}

// 非容器类
- (void)testNSString {
    NSLog(@"%s",__func__);
    NSString *str = @"123";
    NSLog(@"class:%@---%p---%@",[str class],str,str);
    NSMutableString *mStr = [[NSMutableString alloc] initWithString:@"123"];
    NSLog(@"class:%@---%p---%@",[mStr class],mStr,mStr);
    NSString *str1 = [str copy];
    NSMutableString *str2 = [str mutableCopy];
    NSString *str3 = [mStr copy];
    NSMutableString *str4 = [mStr mutableCopy];
    str = @"456";
    [mStr setString:@"456"];
    NSLog(@"class:%@---%p---%@",[str class],str,str);
    NSLog(@"class:%@---%p---%@",[mStr class],mStr,mStr);
    NSLog(@"class:%@---%p---%@",[str1 class],str1,str1);
    NSLog(@"class:%@---%p---%@",[str2 class],str2,str2);
    NSLog(@"class:%@---%p---%@",[str3 class],str3,str3);
    NSLog(@"class:%@---%p---%@",[str4 class],str4,str4);
}


@end
