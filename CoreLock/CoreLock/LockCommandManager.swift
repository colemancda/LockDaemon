//
//  LockCommandManager.swift
//  CoreLock
//
//  Created by Alsey Coleman Miller on 6/21/15.
//  Copyright © 2015 ColemanCDA. All rights reserved.
//

public protocol LockCommandManager {
    
    func startRequests(server serverURL: String, secret: String, lockIdentifier: UInt)
    
    func stopRequests()
    
    var polling: Bool { get }
    
    weak var delegate: LockCommandManagerDelegate? { get }
}

public protocol LockCommandManagerDelegate: class {
    
    func commandManager(manager: LockCommandManager, didRecieveCommand: LockCommand?, error: ErrorType?)
}