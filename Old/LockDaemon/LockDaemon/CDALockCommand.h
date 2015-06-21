//
//  CDALockCommand.h
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/21/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Model object representing a lock command. */
@interface CDALockCommand : NSObject

#pragma mark - Properties

@property (nonatomic, readonly) BOOL shouldUnlock;

@property (nonatomic, readonly) BOOL shouldUpdate;

#pragma mark - Initialization

-(instancetype)initWithJSONObject:(NSDictionary *)jsonObject;

@end