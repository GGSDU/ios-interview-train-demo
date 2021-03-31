//
//  Father+Load.m
//  ios-interview-train-demo
//
//  Created by story5 on 2021/3/24.
//

#import "Father+Load.h"

@implementation Father (Load)

+ (void)load {
    NSLog(@"Father Category Load");
}

+ (void)initialize
{
    [super initialize];
    NSLog(@"Father+Load initialize");
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
