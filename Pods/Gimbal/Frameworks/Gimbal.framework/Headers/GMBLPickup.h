//
//  GMBLPickup.h
//  Gimbal-SDK
//
//  Created by Andrew Tran on 6/8/20.
//  Copyright © 2020 Gimbal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GMBLPlace;
@class GMBLAttributes;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Pickup)
@interface GMBLPickup : NSObject<NSCopying, NSSecureCoding>

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSString *placeIdentifier;
@property (nonatomic, readonly) GMBLAttributes *attributes;

- (instancetype)initWithIdentifier:(NSString *)identifier
                   placeIdentifier:(NSString *)placeIdentifier
                        attributes:(nullable GMBLAttributes *)attributes;

@end

NS_ASSUME_NONNULL_END
