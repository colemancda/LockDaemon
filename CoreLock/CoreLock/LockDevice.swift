//
//  LockDevice.swift
//  CoreLock
//
//  Created by Alsey Coleman Miller on 6/21/15.
//  Copyright © 2015 ColemanCDA. All rights reserved.
//

/** Class representing the lock device. */

public struct LockDevice {
    
    /** The lock's device model. */
    public let model: LockModel
    
    /** Integer representing the firmware build of the lock. */
    public let firmwareBuild: UInt = 1
}