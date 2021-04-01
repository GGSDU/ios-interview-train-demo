//
//  SXHook.h
//  ios-interview-train-demo
//
//  Created by story5 on 2021/4/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXHook : NSObject
+ (void)hookClass:(Class)classObject fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector;
@end

NS_ASSUME_NONNULL_END
