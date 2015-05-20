//
//  CDALockCommandManager.m
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/20/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import "CDALockCommandManager.h"
#import "CDALockDefines.h"
#import "CDALockError.h"

@interface CDALockCommandManager ()

@property (nonatomic) BOOL isPolling;

@end

@implementation CDALockCommandManager

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        
    }
    return self;
}

+(instancetype)sharedManager
{
    static CDALockCommandManager *sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

#pragma mark - Methods

-(BOOL)startRequestsWithError:(NSError **)error
{
    // load server URL
    
    NSString *serverURLString = [[NSUserDefaults standardUserDefaults] stringForKey:CDALockSettingServerURLKey];
    
    _serverURL = [NSURL URLWithString:serverURLString];
    
    _secret = [[NSUserDefaults standardUserDefaults] stringForKey:CDALockSettingSecretKey];
    
    _lockIdentifier = [[NSUserDefaults standardUserDefaults] stringForKey:CDALockSettingIdentifierKey];
    
    // missing info
    if (_serverURL == nil || _secret == nil || _lockIdentifier == nil) {
        
        *error = [NSError errorWithDomain:CDALockErrorDomain code:CDALockErrorCodeInvalidSettings userInfo:@{NSLocalizedDescriptionKey: @"Invalid or missing settings."}];
        
        return false;
    }
    
    NSLog(@"Polling server for Lock commands...");
    
    self.isPolling = YES;
    
    return true;
}

-(void)stopRequests
{
    [_requestTimer invalidate];
    
    self.isPolling = false;
    
    NSLog(@"Stopped polling server for lock commands");
}

#pragma mark - Private Methods

-(void)performRequest
{
    
    
}

@end
