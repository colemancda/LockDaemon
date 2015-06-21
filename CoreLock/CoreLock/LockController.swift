//
//  LockController.swift
//  CoreLock
//
//  Created by Alsey Coleman Miller on 6/21/15.
//  Copyright © 2015 ColemanCDA. All rights reserved.
//

/** Main controller for the lock. */
final public class LockController: LockCommandManagerDelegate {
    
    // MARK: - Properties
    
    /** Lock's current operating mode. */
    public private(set) var mode: LockMode = .Setup
    
    // MARK: Managers
    
    public var commandManager: LockCommandManager
    
    // MARK: - Private Properties
    
    private var lastCommandManagerError: ErrorType?
    
    // MARK: - Initialization
    
    public init(commandManager: LockCommandManager) {
        
        self.commandManager = commandManager
    }
    
    // MARK: - LockCommandManagerDelegate
    
    public func commandManager(manager: LockCommandManager, didRecieveCommand command: LockCommand?, error: ErrorType?) {
        
        
    }
}