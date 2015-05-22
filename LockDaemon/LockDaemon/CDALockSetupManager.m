//
//  CDALockSetupManager.m
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/22/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import "CDALockSetupManager.h"

@interface CDALockSetupManager ()

@property (atomic) BOOL setupModeEnabled;

@end

@implementation CDALockSetupManager

#pragma mark - Setting Values

-(id)valueForSetting:(NSString *)key
{
    id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    return value;
}

#pragma mark - Setup Mode



@end
