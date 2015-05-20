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
        
        NSLog(@"Starting Lock Daemon v%@\nModel: %@\nFirmware Version: %@\n", CDALockDaemonVersion, [CDALockDevice currentDevice].model, [CDALockDevice currentDevice].firmwareVersion);
        
        // try starting the command manager
        
        
        
    }
    
    [[NSRunLoop currentRunLoop] run];
    
    return 0;
}
