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

@property (nonatomic) NSString *firmwareVersion;

@property (nonatomic) NSString *lockInfoPath;

@property (nonatomic) NSString *lockAppSupportPath;

@end

@implementation CDALockDevice

#pragma mark - Initialization

- (instancetype)initWithCurrentDevice
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
        
        self.firmwareVersion = lockInfoDictionary[@"FirmwareVersion"];
        
        if (lockInfoDictionary == nil || self.model == nil || self.firmwareVersion == nil) {
            
            [NSException raise:NSInternalInconsistencyException format:@"Could not load lock info from %@", self.lockInfoPath];
            
            return nil;
        }
    }
    return self;
}

- (id)init
{
    [NSException raise:@"Wrong initialization method"
                format:@"You cannot use %@ with %@, you have to use %@",
     NSStringFromSelector(_cmd),
     self,
     NSStringFromSelector(@selector(currentDevice))];
    return nil;
}

+(instancetype)currentDevice
{
    static CDALockDevice *currentDevice = nil;
    @synchronized(self) {
        if (currentDevice == nil)
            currentDevice = [[self alloc] initWithCurrentDevice];
    }
    return currentDevice;
}

#pragma mark - Custom Accessors



@end
