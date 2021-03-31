//
//  Father.m
//  ios-interview-train-demo
//
//  Created by story5 on 2021/3/24.
//

#import "Father.h"

@implementation Father


+ (void)load {
    NSLog(@"Father load");
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
