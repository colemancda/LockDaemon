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
#import "CDALockErrorPrivate.h"

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
        
        _requestQueue = dispatch_queue_create("CDALockCommandManager Request Queue", DISPATCH_QUEUE_CONCURRENT);
        
        self.HTTPDateFormatter = [[NSDateFormatter alloc] init];
        
        self.HTTPDateFormatter.dateFormat = @"EEE',' dd' 'MMM' 'yyyy HH':'mm':'ss zzz";
        
        
    }
    return self;
}

+(instancetype)sharedManager
{
    static CDALockCommandManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

#pragma mark - Methods

-(BOOL)startRequestsWithError:(NSError *__autoreleasing *)error
{
    if (self.isPolling) {
        
        return true;
    }
    
    // missing info
    if (_serverURL == nil || _secret == nil || _lockIdentifier == nil || !_requestInterval) {
        
        *error = [NSError CDALockErrorWithErrorCode:CDALockErrorCodeInvalidSettings userInfo:nil];
        
        return false;
    }
    
    // create timer
    
    _requestTimer = [NSTimer scheduledTimerWithTimeInterval:_requestInterval
                                                     target:self
                                                   selector:@selector(performRequest)
                                                   userInfo:nil
                                                    repeats:YES];
    
    NSLog(@"Polling server for lock commands every %.1f seconds...", _requestInterval);
    
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
        
        request.timeoutInterval = _requestInterval;
        
        // perform request
        
        // NSLog(@"Authentication Token: %@", authenticationToken.token);
        
        NSError *requestError;
        
        NSURLResponse *response;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
        
        if (requestError != nil) {
            
            NSLog(@"Could not fetch lock commands from server. (%@)", requestError);
            
            return;
        }
        
        NSError *parseError;
        
        NSArray *lockCommands = [self parseServerResponse:response data:data error:&parseError];
        
        if (parseError != nil) {
            
            NSLog(@"Could not fetch lock commands from server. (%@)", parseError);
            
            return;
        }
        
        
        
    });
}

-(CDALockCommand *)fetchLockCommandWithServerURL:(NSURL *)serverURL

-(NSArray *)parseServerResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError **)error
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
        
        
        
        return nil;
    }
    
    if (httpResponse.statusCode != 200) {
        
        *error = [NSError errorWithDomain:CDALockErrorDomain code:CDALockErrorCodeInvalidServerStatusCode userInfo:@{NSLocalizedDescriptionKey: @"Invalid status code returned from server.", CDALockServerStatusCodeKey: [NSNumber numberWithInteger:httpResponse.statusCode]}];
        
        return nil;
    }
    
    
    
}

#pragma mark - Error Generators

-(NSError *)invalidStatusCode

@end


