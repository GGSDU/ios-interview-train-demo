//
//  Person.h
//  ios-interview-train-demo
//
//  Created by story5 on 2021/3/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^myBlock)(void);

@interface Person : NSObject

@property (nonatomic,copy) myBlock blk;

@end

NS_ASSUME_NONNULL_END
