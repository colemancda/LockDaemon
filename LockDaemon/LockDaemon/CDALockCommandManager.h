//
//  CDALockCommandManager.h
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/20/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CDALockCommand;
@protocol CDALockCommandManagerDelegate;

/** Manages the communication with the server. */
@interface CDALockCommandManager : NSObject
{
    NSTimer *_requestTimer;
    
    dispatch_queue_t _requestQueue;
    
    // Cache
    
    NSURL *_serverURL;
    
    NSString *_secret;
    
    NSNumber *_lockIdentifier;
    
    NSTimeInterval _requestInterval;
}

#pragma mark - Properties

/** Manager's delegate. */
@property (nonatomic) id<CDALockCommandManagerDelegate> delegate;

/** Whether the manager is communicating with the server. */
@property (atomic, readonly) BOOL isPolling;

#pragma mark - Initialization

/** The singleton manager. */
+(instancetype)sharedManager;

#pragma mark - Methods

/** Asks the manager to start to connecting to the server. */
-(BOOL)startRequestsWithError:(NSError **)error;

/** Stops communication with the server. */
-(void)stopRequests;

@end

@protocol CDALockCommandManagerDelegate <NSObject>

-(void)lockCommandManager:(CDALockCommandManager *)lockCommandManager didRecieveLockCommand:(CDALockCommand *)lockCommand;

-(void)lockCommandManager:(CDALockCommandManager *)lockCommandManager didEncounterError:(NSError *)error;

@end
