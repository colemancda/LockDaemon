//
//  CDALockErrorPrivate.h
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/22/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDALockError.h"

@interface NSError (CDALockErrorPrivate)

/** Creates an @c NSError with the specified error code and additional user info. Internal Method.
 @param errorCode The error code used to generate the error.
 @param userInfo Optional dictionary for additional context. May be nil.
 @returns Generated @c NSError instance.
 */
+(NSError *)CDALockErrorWithErrorCode:(CDALockErrorCode)errorCode userInfo:(NSDictionary *)userInfo;

@end