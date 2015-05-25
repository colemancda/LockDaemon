//
//  CDALockSetupManager.m
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/22/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import "CDALockSetupManager.h"
#import "CDALockDefines.h"

@interface CDALockSetupManager ()

@property (atomic) BOOL isSetupModeEnabled;

@property (atomic) BOOL isConfigured;

@end

@implementation CDALockSetupManager

#pragma mark - Initialization

+ (void)initialize
{
    if (self == [CDALockSetupManager class]) {
        
        // register defaults
        
#ifdef TARGET_OS_MAC
        
        NSDictionary *userDefaults = @{CDALockSettingRequestIntervalKey: @1.0,
                                       CDALockSettingIdentifierKey: @0,
                                       CDALockSettingSecretKey: @"LockSecret1234",
                                       CDALockSettingServerURLKey: @"http://localhost:8080"};
        
        [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaults];
#endif
        
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.isConfigured = [self settingsConfigured];
        
        
        
    }
    return self;
}

#pragma mark - Setting Values

-(id)valueForSetting:(NSString *)key
{
    id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    return value;
}

#pragma mark - Setup Mode

-(BOOL)enableSetupModeWithError:(NSError **)error
{
#ifdef TARGET_OS_MAC
    
    NSLog(@"Simulating enabling Setup mode.");
    
    return YES;
    
#endif
    
    
    
    return YES;
}

-(BOOL)disableSetupModeWithError:(NSError **)error
{
#ifdef TARGET_OS_MAC
    
    NSLog(@"Simulating disabling Setup mode.");
    
    return YES;
    
#endif
    
    
    
    return YES;
}

#pragma mark - Private Methods

/** Whether all of the required settings are loaded. */
-(BOOL)settingsConfigured
{
    // load settings
    
    NSArray *settings = @[CDALockSettingIdentifierKey,
                          CDALockSettingSecretKey,
                          CDALockSettingRequestIntervalKey,
                          CDALockSettingServerURLKey];
    
    for (NSString *settingKey in settings) {
        
        if (![self valueForSetting:settingKey]) {
            
            return NO;
        }
    }
    
    return YES;
}

-(NSError *)enableAccessPointMode
{
    
    
    return nil;
}

@end
