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

/**
 Defines the status of location services .
 */
typedef NS_ENUM(NSInteger, GMBLLocationStatus) {
    /// User has given the application the necessary location permissions for Gimbal
    /// to operate correctly.
    GMBLLocationStatusOK NS_SWIFT_NAME(ok),
    /// The user is unable to provide the application with the necessary location permissions
    /// for Gimbal to operate correctly and the current permissions are insufficent.
    GMBLLocationStatusAdminRestricted NS_SWIFT_NAME(adminRestricted),
    /// The user has denied the application necessary location permissions for Gimbal to operate
    /// correctly
    GMBLLocationStatusNotAuthorizedAlways NS_SWIFT_NAME(authorizedAlways),
} NS_SWIFT_NAME(LocationStatus);

/**
 Defines the state of Bluetooth.
 */
typedef NS_ENUM(NSInteger, GMBLBluetoothStatus) {
    /// User has given the application the necessary bluetooth permissions for Gimbal
    /// to operate correctly.
    GMBLBluetoothStatusOK NS_SWIFT_NAME(ok),
    /// The user is unable to provide the application with the necessary bluetooth permissions
    /// for Gimbal to operate correctly and the current permissions are insufficent.
    GMBLBluetoothStatusAdminRestricted NS_SWIFT_NAME(adminRestricted),
    /// The user has denied the application necessary bluetooth permissions for Gimbal to operate
    /// correctly
    GMBLBluetoothStatusPoweredOff NS_SWIFT_NAME(poweredOff),
    
    /// The app has not provided an NSBluetoothAlwaysUsageDescription keyed permission description in it's info.plist
    GMBLBluetoothStatusNoBluetoothAlwaysPermissionDescription NS_SWIFT_NAME(noBluetoothAlwaysPermissionDescription),
    /// Bluetooth usage has been disabled for this app in the Gimbal Manager configuration
    GMBLBluetoothStatusBluetoothDisabledByConfig NS_SWIFT_NAME(bluetoothDisabledByConfig),
    /// The APIKey hasn't been set yet
    GMBLBluetoothStatusNotRegisteredYet NS_SWIFT_NAME(notRegisteredYet),
    /// The app hasn't started monitoring Places or Beacons
    GMBLBluetoothStatusNotMonitoring NS_SWIFT_NAME(notMonitoring),

    /// Unknown status
    GMBLBluetoothStatusUnknown
} NS_SWIFT_NAME(BluetoothStatus);

@protocol GMBLApplicationStatusDelegate;

NS_ASSUME_NONNULL_BEGIN

/*!
 The GMBLServicesState class is designed to find out if services required by
 Gimbal are available from iOS.
 */
NS_SWIFT_NAME(ApplicationStatus)
@interface GMBLApplicationStatus : NSObject

/// Delegate receiving notifications on iOS service state changes
@property (nonatomic, weak) id<GMBLApplicationStatusDelegate> delegate;

/// Retrieves the current authorization state for location
+ (GMBLLocationStatus)locationStatus;

/// Retrieves the current state for Bluetooth
+ (GMBLBluetoothStatus)bluetoothStatus;

/// Returns string containing a problem statement for services required by Gimbal
+ (nullable NSString *)statusDescription;

@end

NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN
/*!
 The GMBLServicesStateDelegate protocol defines the methods used to receive events for the
 GMBLServicesState object.
 */
NS_SWIFT_NAME(ApplicationStatusDelegate)
@protocol GMBLApplicationStatusDelegate <NSObject>

@optional

/*!
 Tells the delegate that location status has changed.
 @param applicationStatus The services state object reporting the event.
 @param locationStatus The new location authorization status.
 */
- (void)applicationStatus:(GMBLApplicationStatus *)applicationStatus didChangeLocationStatus:(GMBLLocationStatus)locationStatus;

/*!
 Tells the delegate that bluetooth state has changed.
 @param applicationStatus The services state object reporting the event.
 @param bluetoothStatus The new bluetooth state.
 */
- (void)applicationStatus:(GMBLApplicationStatus *)applicationStatus didChangeBluetoothStatus:(GMBLBluetoothStatus)bluetoothStatus;

@end

NS_ASSUME_NONNULL_END
