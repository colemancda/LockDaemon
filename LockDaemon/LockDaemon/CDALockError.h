//
//  CDALockError.h
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/20/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Error domain for Lock Daemon. */
FOUNDATION_EXPORT NSString *const CDALockErrorDomain;

/** Error codes for Lock Daemon. */
typedef enum : NSUInteger {
    
    /** Unkown error. */
    CDALockErrorCodeUnkown,
    
    /** Settings is missing values or the values stored are invalid. */
    CDALockErrorCodeInvalidSettings
    
} CDALockErrorCode;