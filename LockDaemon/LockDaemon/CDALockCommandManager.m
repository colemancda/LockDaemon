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

@property (atomic) BOOL isPolling;

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

#pragma mark - Methods

-(void)startRequests
{
    if (self.isPolling) {
        
        return;
    }
    
    // missing info
    if (_serverURL == nil || _secret == nil || _lockIdentifier == nil || !_requestInterval) {
        
        [NSException raise:NSInternalInconsistencyException format:@"Must properly configure CDALockCommandManager before calling '%@'", NSStringFromSelector(_cmd)];
        
        return;
    }
    
    // create timer
    
    _requestTimer = [NSTimer scheduledTimerWithTimeInterval:_requestInterval
                                                     target:self
                                                   selector:@selector(performRequest)
                                                   userInfo:nil
                                                    repeats:YES];
        
    self.isPolling = YES;
    
    return;
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
    NSURL *serverURL = self.serverURL;
    
    NSNumber *identifier = self.lockIdentifier;
    
    NSString *secret = self.secret;
    
    NSTimeInterval requestInterval = self.requestInterval;
    
    dispatch_async(_requestQueue, ^{
      
        // cancel request if we arent polling anymore
        if (!self.isPolling) {
            
            return;
        }
        
        NSError *fetchCommandError;
        
        CDALockCommand *command = [self fetchLockCommandWithServerURL:serverURL lockIdentifier:identifier.integerValue secret:secret timeoutInterval:requestInterval error:&fetchCommandError];
        
        if (fetchCommandError != nil) {
            
            [self.delegate lockCommandManager:self errorReceivingLockCommand:fetchCommandError];
            
            return;
        }
        
        
        [self.delegate lockCommandManager:self didRecieveLockCommand:command];
    });
}

-(CDALockCommand *)fetchLockCommandWithServerURL:(NSURL *)serverURL lockIdentifier:(NSUInteger)lockIdentifier secret:(NSString *)secret timeoutInterval:(NSTimeInterval)timeoutInterval error:(NSError **)error
{
    // build request
    
    NSURL *serverLockURL = [serverURL URLByAppendingPathComponent:@"lock"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serverLockURL];
    
    [request addValue:[[self HTTPDateFormatter] stringFromDate:[NSDate date]] forHTTPHeaderField:@"Date"];
    
    CDAAuthenticationContext *authenticationContext = [[CDAAuthenticationContext alloc] initWithURLRequest:request];
    
    CDAAuthenticationToken *authenticationToken = [[CDAAuthenticationToken alloc] initWithIdentifier:lockIdentifier secret:secret context:authenticationContext];
    
    [request addValue:authenticationToken.token forHTTPHeaderField:@"Authentication"];
    
    request.timeoutInterval = timeoutInterval;
    
    // perform request
    
    NSError *requestError;
    
    NSURLResponse *response;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    if (requestError != nil) {
        
        [self.delegate lockCommandManager:self errorReceivingLockCommand:requestError];
        
        return nil;
    }
    
    NSError *parseError;
    
    NSArray *lockCommands = [self parseServerResponse:response data:data error:&parseError];
    
    if (parseError != nil) {
        
        [self.delegate lockCommandManager:self errorReceivingLockCommand:parseError];
        
        return;
    }
    

}

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


