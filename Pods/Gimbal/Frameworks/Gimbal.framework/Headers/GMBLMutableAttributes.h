//
//  GMBLMutableAttributes.h
//  Gimbal-SDK
//
//  Created by Mohammad Kurabi on 7/20/20.
//  Copyright © 2020 Gimbal. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GMBLAttributes.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MutableAttributes)
@interface GMBLMutableAttributes : GMBLAttributes

- (instancetype)init;
- (instancetype)initWithAttributes:(GMBLAttributes *)attributes;

- (void)setString:(NSString *)value forKey:(NSString *)key;
- (void)removeStringForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
