//
//  CDAAuthenticationToken.h
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/20/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CDAAuthenticationContext;

/** Class that generates an authentication token. */
@interface CDAAuthenticationToken : NSObject

#pragma mark - Initialization

/** Creates an authentication token from the specified values. */
-(instancetype)initWithIdentifier:(NSUInteger)identifier secret:(NSString *)secret context:(CDAAuthenticationContext *)context;

#pragma mark - Properties

/** The context of the authentication token. */
@property (nonatomic, readonly) CDAAuthenticationContext *context;

@property (nonatomic, readonly) NSUInteger identifier;

@property (nonatomic, readonly) NSString *secret;

/** The string value of the authentication token. */
@property (nonatomic, readonly) NSString *token;

@end

/** Provides the context for authorization. Public information only. */
@interface CDAAuthenticationContext : NSObject

#pragma mark - Initialization

-(instancetype)initWithVerb:(NSString *)verb path:(NSString *)path dateString:(NSString *)dateString;

-(instancetype)initWithURLRequest:(NSURLRequest *)request;

#pragma mark - Properties

/** The HTTP verb of the request. */
@property (nonatomic, readonly) NSString *verb;

/** The path of the HTTP request. */
@property (nonatomic, readonly) NSString *path;

/** The string of the date of the request. */
@property (nonatomic, readonly) NSString *dateString;

@end