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
#import "CDALockController.h"

int main(int argc, const char * argv[]) {
    
    @autoreleasepool {
        
        // load and print device info
        NSLog(@"Starting Lock Daemon v%@\nModel: %@\nFirmware Build: %@\n", CDALockDaemonVersion, [CDALockDevice currentDevice].model, [CDALockDevice currentDevice].firmwareBuild);
        
        // start lock controller
        [CDALockController sharedController];
    }
    
    [[NSRunLoop currentRunLoop] run];
    
    return 0;
}
