//
//  SXOperation.m
//  ios-interview-train-demo
//
//  Created by story5 on 2021/4/1.
//

#import "SXOperation.h"

@implementation SXOperation

- (void)main {
    if (!self.isCancelled) {
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    }
}

@end
