//
//  CDALockSetupManager.h
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/22/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CDALockSetupManagerDelegate;

/** Manages configuration of the Lock. */
@interface CDALockSetupManager : NSObject

/** Whether setup mode is enabled. */
@property (nonatomic, readonly) BOOL isSetupModeEnabled;

/** Whether the settings have been fully configured. */
@property (nonatomic, readonly) BOOL isConfigured;

/** Manager's delegate. */
@property (nonatomic) id<CDALockSetupManagerDelegate> delegate;

#pragma mark - Methods

/** Enabled setup mode. Turns lock into Wi-Fi access point and runs setup server. Once values are set, setup mode is automatically disabled. */
-(BOOL)enableSetupModeWithError:(NSError **)error;

-(BOOL)disableSetupModeWithError:(NSError **)error;

/** Fetches the value for the setting. */
-(id)valueForSetting:(NSString *)key;

@end

@protocol CDALockSetupManagerDelegate <NSObject>

-(void)setupManager:(CDALockSetupManager *)setupManager didReceiveValidValues:(BOOL)validValues;

@end
