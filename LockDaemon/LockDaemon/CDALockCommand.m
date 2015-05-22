//
//  CDALockCommand.m
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/21/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import "CDALockCommand.h"

@interface CDALockCommand ()

@property (nonatomic) BOOL shouldUnlock;

@property (nonatomic) BOOL shouldUpdate;

@end

@implementation CDALockCommand

#pragma mark - Initialization

-(instancetype)initWithJSONObject:(NSDictionary *)jsonObject
{
    if (jsonObject == nil) {
        
        return nil;
    }
    
    self = [super init];
    if (self) {
        
        NSNumber *shouldUpdate = jsonObject[@"update"];
        
        NSNumber *shouldUnlock = jsonObject[@"unlock"];
        
        if (shouldUnlock == nil || shouldUpdate == nil) {
            
            return nil;
        }
        
        self.shouldUnlock = shouldUnlock.boolValue;
        
        self.shouldUpdate = shouldUpdate.boolValue;
        
    }
    return self;
}

@end
