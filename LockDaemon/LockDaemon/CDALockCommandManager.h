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
}

#pragma mark - Properties

/** Manager's delegate. */
@property (nonatomic) id<CDALockCommandManagerDelegate> delegate;

/** Whether the manager is communicating with the server. */
@property (atomic, readonly) BOOL isPolling;

/** The interval between requests from the server. */
@property (nonatomic) NSTimeInterval requestInterval;

/** The URL that will be used to fetch commands from the server. */
@property (nonatomic) NSURL *serverURL;

/** The lock's secret. Used for authentication. */
@property (nonatomic) NSString *secret;

/** The lock's resourceID. Used for authentication. */
@property (nonatomic) NSNumber *lockIdentifier;

#pragma mark - Methods

/** Asks the manager to start to connecting to the server. Make sure the lock command manager is properly configured or this will raise an exception. */
-(void)startRequests;

/** Stops communication with the server. */
-(void)stopRequests;

@end

@protocol CDALockCommandManagerDelegate <NSObject>

-(void)lockCommandManager:(CDALockCommandManager *)lockCommandManager didRecieveLockCommand:(CDALockCommand *)lockCommand;

-(void)lockCommandManager:(CDALockCommandManager *)lockCommandManager errorReceivingLockCommand:(NSError *)error;

@end
