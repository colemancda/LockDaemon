//
//  LockDevice.swift
//  CoreLock
//
//  Created by Alsey Coleman Miller on 6/21/15.
//  Copyright © 2015 ColemanCDA. All rights reserved.
//

/** Encapsulates information about the lock. */
public struct LockDevice {
    
    /** The lock's device model. */
    public let model: LockModel = .Simulator
    
    /** Integer representing the firmware build of the lock. */
    public let firmwareBuild: UInt = 1
}