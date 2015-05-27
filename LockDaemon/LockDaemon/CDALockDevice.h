//
//  CDALockDevice.h
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/20/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Class representing the lock device. */
@interface CDALockDevice : NSObject

#pragma mark - Properties

/* String representing the lock device model. */
@property (nonatomic, readonly) NSString *model;

/* String representing the firmware build of the lock. */
@property (nonatomic, readonly) NSNumber *firmwareBuild;

#pragma mark - Initialization

/** The singleton for the current device. */
+(instancetype)currentDevice;

@end
