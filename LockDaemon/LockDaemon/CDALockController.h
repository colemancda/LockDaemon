//
//  CDALockController.h
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/22/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDALockCommandManager.h"

/** Main controller for the lock. */
@interface CDALockController : NSObject <CDALockCommandManagerDelegate>

@property (nonatomic) CDALockSetupManager *setupManager;

@property (nonatomic) CDALockCommandManager *commandManager;

#pragma mark - Initialization

+(instancetype)sharedController;

@end
