//
//  CDALockErrorPrivate.m
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/22/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import "CDALockErrorPrivate.h"

@implementation NSError (CDALockErrorPrivate)

+(NSError *)CDALockErrorWithErrorCode:(CDALockErrorCode)errorCode userInfo:(NSDictionary *)userInfo
{
    // localized description
    
    NSString *description;
    
    switch (errorCode) {
        case CDALockErrorCodeUnkown:
            
            description = @"Unknown error.";
            break;
            
        case CDALockErrorCodeInvalidSettings:
            
            description = @"Invalid or missing settings.";
            break;
            
        case CDALockErrorCodeInvalidServerStatusCode:
            
            description = @"Invalid server status code.";
            break;
            
        case CDALockErrorCodeInvalidServerResponse:
            
            description = @"Invalid server response.";
            break;
            
        default:
            
            [[NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"Unknown error code %ld", errorCode] userInfo:nil] raise];
            
            return nil;
            
            break;
    }
    
    NSMutableDictionary *errorUserInfo = [[NSMutableDictionary alloc] initWithDictionary:@{NSLocalizedDescriptionKey: description}];
    
    if (userInfo) {
        
        [errorUserInfo addEntriesFromDictionary:userInfo];
    }
    
    return [NSError errorWithDomain:CDALockErrorDomain code:errorCode userInfo:errorUserInfo];
}

@end