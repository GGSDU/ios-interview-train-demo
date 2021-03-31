//
//  Son.m
//  ios-interview-train-demo
//
//  Created by story5 on 2021/3/24.
//

#import "Son.h"

@implementation Son

+ (void)load{
    NSLog(@"Son load");
}

+ (void)initialize
{
    [super initialize];
    NSLog(@"%s %@",__func__,[self class]);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%s",__func__);
    }
    return self;
}

@end
