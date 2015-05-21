//
//  CDAAuthenticationToken.m
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/20/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import "CDAAuthenticationToken.h"
#import <openssl/hmac.h>

@interface CDAAuthenticationToken ()

@property (nonatomic) CDAAuthenticationContext *context;
@property (nonatomic) NSUInteger identifier;
@property (nonatomic) NSString *secret;
@property (nonatomic) NSString *token;

@end

@implementation CDAAuthenticationToken

- (id)init
{
    [NSException raise:@"Wrong initialization method"
                format:@"You cannot use %@ with %@, you have to use %@",
     NSStringFromSelector(_cmd),
     self,
     NSStringFromSelector(@selector(initWithIdentifier:secret:context:))];
    return nil;
}

- (instancetype)initWithIdentifier:(NSUInteger)identifier secret:(NSString *)secret context:(CDAAuthenticationContext *)context;
{
    self = [super init];
    if (self) {
        
        self.identifier = identifier;
        self.secret = secret;
        self.context = context;
        
        // generate token
        
        NSString *stringToSign = [NSString stringWithFormat:@"%@%@%@", context.verb, context.path, context.dateString];
        
        // sign data
        
        unsigned char *result;
        unsigned int resultLength =
        
        HMAC_CTX hmac;
        
        HMAC_CTX_init(&hmac);
        
        HMAC_Init_ex(&hmac, secret.UTF8String, (int)secret.length, EVP_sha512(), NULL);
        
        HMAC_Update(&hmac, (unsigned char*)stringToSign.UTF8String, (int)stringToSign.length);
        
        HMAC_Final(&hmac, <#unsigned char *md#>, <#unsigned int *len#>)
        
        
    }
    return self;
}

@end

@interface CDAAuthenticationContext ()

@property (nonatomic) NSString *verb;

@property (nonatomic) NSString *path;

@property (nonatomic) NSString *dateString;

@end

@implementation CDAAuthenticationContext

-(instancetype)initWithVerb:(NSString *)verb path:(NSString *)path dateString:(NSString *)dateString
{
    self = [super init];
    if (self) {
        
        self.verb = verb;
        self.path = path;
        self.dateString = dateString;
    }
    return self;
}

-(instancetype)initWithURLRequest:(NSURLRequest *)request;
{
    // extract date value...
    
    NSString *dateString = [request valueForHTTPHeaderField:@"Date"];
    
    if (dateString == nil) {
        
        dateString = [[[self class] HTTPDateFormatter] stringFromDate:[NSDate date]];
    }
    
    self = [self initWithVerb:request.HTTPMethod path:request.URL.path dateString:dateString];
    
    return self;
}

#pragma mark - Private Class Methods

+ (NSDateFormatter *)HTTPDateFormatter
{
    static NSDateFormatter *HTTPDateFormatter = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        HTTPDateFormatter = [[NSDateFormatter alloc] init];
        
        HTTPDateFormatter.dateFormat = @"EEE',' dd' 'MMM' 'yyyy HH':'mm':'ss zzz";
        
    });
    
    return HTTPDateFormatter;
}

@end
