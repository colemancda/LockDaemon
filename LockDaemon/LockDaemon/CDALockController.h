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

typedef NS_ENUM(NSInteger, CDALockMode) {
    
    CDALockModeSetup,
    CDALockModeCommandReceiver,
    CDALockModeError
};

/** Main controller for the lock. */
@interface CDALockController : NSObject <CDALockCommandManagerDelegate, CDALockSetupManagerDelegate>

#pragma mark - Properties

@property (nonatomic, readonly) CDALockSetupManager *setupManager;

@property (nonatomic, readonly) CDALockCommandManager *commandManager;

@property (nonatomic) CDALockMode lockMode;

#pragma mark - Initialization

+(instancetype)sharedController;

#pragma mark - Methods

-(void)loadController;

@end
