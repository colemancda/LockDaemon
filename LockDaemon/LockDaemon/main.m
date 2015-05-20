//
//  main.m
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/20/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDALockDefines.h"
#import "CDALockDevice.h"
#import "CDALockCommandManager.h"

int main(int argc, const char * argv[]) {
    
    @autoreleasepool {
        
        // load and print device info
        NSLog(@"Starting Lock Daemon v%@\nModel: %@\nFirmware Version: %@\n", CDALockDaemonVersion, [CDALockDevice currentDevice].model, [CDALockDevice currentDevice].firmwareVersion);
        
        // register defaults
        
        NSDictionary *userDefaults = @{CDALockSettingRequestIntervalKey : [NSNumber numberWithDouble:2.0]};
        
#ifdef TARGET_OS_MAC
      
        userDefaults = @{CDALockSettingRequestIntervalKey: [NSNumber numberWithDouble:1.0],
                         CDALockSettingIdentifierKey: @0,
                         CDALockSettingSecretKey: @"LockSecret1234",
                         CDALockSettingServerURLKey: @"http://localhost:8080"};
        
#endif
        
        [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaults];
        
        // try starting the command manager
        
        NSError *startPollingError;
        
        [[CDALockCommandManager sharedManager] startRequestsWithError:&startPollingError];
        
    }
    
    [[NSRunLoop currentRunLoop] run];
    
    return 0;
}
