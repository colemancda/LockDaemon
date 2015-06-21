//
//  LockSettings.swift
//  CoreLock
//
//  Created by Alsey Coleman Miller on 6/21/15.
//  Copyright © 2015 ColemanCDA. All rights reserved.
//

/** The setting key for the lock. */
public enum LockSettingKey: String {
    
    case ServerURL = "ServerURL"
    
    case LockIdentifier = "LockIdentifier"
    
    case Secret = "Secret"

    case RequestInterval = "RequestInterval"
}