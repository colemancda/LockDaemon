//
//  CDALockSetupManager.h
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/22/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Manages configuration of the Lock. */
@interface CDALockSetupManager : NSObject

/**  */
@property (atomic, readonly) BOOL setupModeEnabled;

#pragma mark - Methods

-(BOOL)enableSetupModeWithError:(NSError *)error;

-(void)disableSetupModeWithError:(NSError *)error;

/** Fetches the value for the setting. */
-(id)valueForSetting:(NSString *)key;

@end
