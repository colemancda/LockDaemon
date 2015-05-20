//
//  CDALockCommandManager.h
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/20/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Manages the communication with the server. */
@interface CDALockCommandManager : NSObject
{
    NSTimer *_requestTimer;
    
    dispatch_queue_t _requestQueue;
    
    // Cache
    
    NSURL *_serverURL;
    
    NSString *_secret;
    
    NSNumber *_lockIdentifier;
}

#pragma mark - Properties

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
