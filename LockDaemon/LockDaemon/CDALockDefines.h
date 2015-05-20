//
//  CDALockDefines.h
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/20/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>

/** The version of the Lock Daemon. */
FOUNDATION_EXPORT NSString *const CDALockDaemonVersion;

// Setting Keys

/* Setting key for The URL of the server. */
FOUNDATION_EXPORT NSString *const CDALockSettingServerURLKey;

/** Settings key for the resource ID of the lock on the server. */
FOUNDATION_EXPORT NSString *const CDALockSettingIdentifierKey;

/** Settings key for the lock's secret. */
FOUNDATION_EXPORT NSString *const CDALockSettingSecretKey;
