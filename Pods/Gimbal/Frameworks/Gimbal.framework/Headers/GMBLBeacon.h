/**
 * Copyright (C) 2015 Gimbal, Inc. All rights reserved.
 *
 * This software is the confidential and proprietary information of Gimbal, Inc.
 *
 * The following sample code illustrates various aspects of the Gimbal SDK.
 *
 * The sample code herein is provided for your convenience, and has not been
 * tested or designed to work on any particular system configuration. It is
 * provided AS IS and your use of this sample code, whether as provided or
 * with any modification, is at your own risk. Neither Gimbal, Inc.
 * nor any affiliate takes any liability nor responsibility with respect
 * to the sample code, and disclaims all warranties, express and
 * implied, including without limitation warranties on merchantability,
 * fitness for a specified purpose, and against infringement.
 */
#import <Foundation/Foundation.h>

/*!
 Defines the battery level of a beacon.
 */
typedef NS_ENUM(NSInteger, GMBLBatteryLevel) {
    /// The battery level on the beacon is low and should be replaced soon.
    GMBLBatteryLevelLow NS_SWIFT_NAME(low) = 0,
    /// The battery level on the beacon is between medium and low.
    GMBLBatteryLevelMediumLow NS_SWIFT_NAME(mediumLow),
    /// The battery level on the beacon is between medium and high.
    GMBLBatteryLevelMediumHigh NS_SWIFT_NAME(mediumHigh),
    /// The battery level on the beacon is high.
    GMBLBatteryLevelHigh NS_SWIFT_NAME(high)
} NS_SWIFT_NAME(BatteryLevel);

NS_ASSUME_NONNULL_BEGIN

/// Represents a physical beacon sighted by the SDK
NS_SWIFT_NAME(Beacon)
@interface GMBLBeacon : NSObject <NSCopying, NSSecureCoding>

/// A unique string identifier (factory id) that represents the beacon
@property (readonly, nonatomic) NSString *identifier;

/// A universally unique identifier (uuid) that represents the beacon
@property (readonly, nonatomic) NSString *uuid;

/// The name for the GMBLBeacon as assigned from Gimbal Manager
@property (readonly, nonatomic) NSString *name;

/// The iconUrl for the GMBLBeacon
@property (readonly, nonatomic, nullable) NSString *iconURL;

/// The battery level for the GMBLBeacon
@property (readonly, nonatomic) GMBLBatteryLevel batteryLevel;

/// The temperature measured by the beacon in degrees Fahrenheit.
/// If no temperature reading is available for this beacon, the value is NSIntegerMax.
@property (readonly, nonatomic) NSInteger temperature;

@end

NS_ASSUME_NONNULL_END
