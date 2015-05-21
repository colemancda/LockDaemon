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
#import "CDAAuthenticationToken.h"

@interface CDALockCommandManager ()

@property BOOL isPolling;

@property (nonatomic) NSDateFormatter *HTTPDateFormatter;

@end

@implementation CDALockCommandManager

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _requestQueue = dispatch_queue_create("CDALockCommandManager Request Queue", DISPATCH_QUEUE_SERIAL);
        
        self.HTTPDateFormatter = [[NSDateFormatter alloc] init];
        
        self.HTTPDateFormatter.dateFormat = @"EEE',' dd' 'MMM' 'yyyy HH':'mm':'ss zzz";
        
        
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
    if (self.isPolling) {
        
        return true;
    }
    
    // load server URL
    
    NSString *serverURLString = [[NSUserDefaults standardUserDefaults] stringForKey:CDALockSettingServerURLKey];
    
    _serverURL = [NSURL URLWithString:serverURLString];
    
    _secret = [[NSUserDefaults standardUserDefaults] stringForKey:CDALockSettingSecretKey];
    
    _lockIdentifier = @([[NSUserDefaults standardUserDefaults] integerForKey:CDALockSettingIdentifierKey]);
    
    NSTimeInterval requestInterval = [[NSUserDefaults standardUserDefaults] doubleForKey:CDALockSettingRequestIntervalKey];
    
    // missing info
    if (_serverURL == nil || _secret == nil || _lockIdentifier == nil || !requestInterval) {
        
        *error = [NSError errorWithDomain:CDALockErrorDomain code:CDALockErrorCodeInvalidSettings
                                 userInfo:@{NSLocalizedDescriptionKey: @"Invalid or missing settings."}];
        
        return false;
    }
    
    // create timer
    
    _requestTimer = [NSTimer scheduledTimerWithTimeInterval:requestInterval
                                                     target:self
                                                   selector:@selector(performRequest)
                                                   userInfo:nil
                                                    repeats:YES];
    
    NSLog(@"Polling server for lock commands every %.1f seconds...", requestInterval);
    
    self.isPolling = YES;
    
    return true;
}

-(void)stopRequests
{
    if (!self.isPolling) {
        
        return;
    }
    
    [_requestTimer invalidate];
    
    _requestTimer = nil;
    
    self.isPolling = false;
    
    NSLog(@"Stopped polling server for lock commands");
}

#pragma mark - Private Methods

-(void)performRequest
{
    NSURL *serverURL = _serverURL;
    
    NSNumber *identifier = _lockIdentifier;
    
    NSString *secret = _secret;
    
    dispatch_async(_requestQueue, ^{
      
        // cancel request if we arent polling anymore
        if (!self.isPolling) {
            
            return;
        }
        
        // build request
        
        NSURL *serverLockURL = [serverURL URLByAppendingPathComponent:@"lock"];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serverLockURL];
        
        [request addValue:[[self HTTPDateFormatter] stringFromDate:[NSDate date]] forHTTPHeaderField:@"Date"];
        
        CDAAuthenticationContext *authenticationContext = [[CDAAuthenticationContext alloc] initWithURLRequest:request];
        
        CDAAuthenticationToken *authenticationToken = [[CDAAuthenticationToken alloc] initWithIdentifier:identifier.integerValue secret:secret context:authenticationContext];
        
        [request addValue:authenticationToken.token forHTTPHeaderField:@"Authentication"];
        
        // perform request
        
        // NSLog(@"Authentication Token: %@", authenticationToken.token);
        
    });
}

@end
