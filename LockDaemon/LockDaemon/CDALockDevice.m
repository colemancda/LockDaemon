//
//  CDALockDevice.m
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/20/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import "CDALockDevice.h"

@interface CDALockDevice ()

@property (nonatomic) NSString *model;

@property (nonatomic) NSNumber *firmwareBuild;

@property (nonatomic) NSString *lockInfoPath;

@property (nonatomic) NSString *lockAppSupportPath;

@end

@implementation CDALockDevice

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        
#ifdef GNUSTEP
        
        self.lockAppSupportPath = @"/LockDaemon"
        
#else
        NSArray *appSupportDirectories = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSLocalDomainMask, NO);
        
        self.lockAppSupportPath = [appSupportDirectories[0] stringByAppendingPathComponent:@"CDALockDaemon"];
#endif
        
        self.lockInfoPath = [self.lockAppSupportPath stringByAppendingPathComponent:@"LockInfo.plist"];
        
        NSDictionary *lockInfoDictionary = [NSDictionary dictionaryWithContentsOfFile:self.lockInfoPath];
        
        self.model = lockInfoDictionary[@"LockModel"];
        
        self.firmwareBuild = lockInfoDictionary[@"FirmwareBuild"];
        
        if (lockInfoDictionary == nil || self.model == nil || self.firmwareBuild == nil) {
            
            [NSException raise:NSInternalInconsistencyException format:@"Could not load lock info from %@", self.lockInfoPath];
            
            return nil;
        }
    }
    return self;
}

+(instancetype)currentDevice
{
    static CDALockDevice *currentDevice = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        currentDevice = [[self alloc] init];
    });
    
    return currentDevice;
}

@end
