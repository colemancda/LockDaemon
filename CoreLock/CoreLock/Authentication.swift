//
//  Authentication.swift
//  CoreLock
//
//  Created by Alsey Coleman Miller on 6/22/15.
//  Copyright © 2015 ColemanCDA. All rights reserved.
//


// MARK: - Functions

/// Generates the authorization header used for authenticating HTTP requests.
/// Modeled after [AWS](http://docs.aws.amazon.com/AmazonS3/latest/dev/RESTAuthentication.html#UsingTemporarySecurityCredentials)
///
/// - Parameter identifier: The identifier (e.g. resource ID or username) of the entity trying to authenticate.
/// - Parameter secret: The secret (e.g. password) of the entity trying to authenticate.
/// - Parameter context: The authentication context info.
/// - Returns: The generated authentication token.
public func GenerateAuthenticationToken(identifier: String, secret: String, context: AuthenticationContext) -> String {
    
    return ""
}