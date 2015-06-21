//
//  AuthenticationContext.swift
//  CoreLock
//
//  Created by Alsey Coleman Miller on 6/21/15.
//  Copyright © 2015 ColemanCDA. All rights reserved.
//

/** Provides the context for authorization. Public information only. */
public struct AuthenticationContext {
    
    // MARK: - Properties
    
    public let verb: String
    
    public let path: String
    
    public let dateString: String
}