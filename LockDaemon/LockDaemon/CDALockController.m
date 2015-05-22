//
//  CDALockController.m
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/22/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import "CDALockController.h"
#import "CDALockCommandManager.h"
#import "CDALockSetupManager.h"

@implementation CDALockController

#pragma mark - Initialization

+ (instancetype)sharedStore
{
    static CDALockController *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - 

@end
