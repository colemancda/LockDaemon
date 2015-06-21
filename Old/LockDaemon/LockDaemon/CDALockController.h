//
//  CDALockController.h
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/22/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDALockSetupManager.h"
#import "CDALockCommandManager.h"

/** Modes for the lock device. */
typedef enum {
    
    /** The lock device is in setup mode. */
    CDALockModeSetup,
    
    /** The lock device is in command reciever mode. */
    CDALockModeCommandReceiver,
    
    /** The lock device is in fatal error mode. */
    CDALockModeFatalError
    
} CDALockMode;

/** Main controller for the lock. */
@interface CDALockController : NSObject <CDALockCommandManagerDelegate, CDALockSetupManagerDelegate>
{
    NSError *_lastError;
}

#pragma mark - Properties

@property (nonatomic, readonly) CDALockSetupManager *setupManager;

@property (nonatomic, readonly) CDALockCommandManager *commandManager;

@property (nonatomic, readonly) CDALockMode lockMode;

#pragma mark - Initialization

+(instancetype)sharedController;

@end
