//
//  CDALockController.m
//  LockDaemon
//
//  Created by Alsey Coleman Miller on 5/22/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

#import "CDALockController.h"
#import "CDALockCommandManager.h"
#import "CDALockSetupManager.h"

static void *KVOContext = &KVOContext;

@interface CDALockController ()

@property (nonatomic) CDALockSetupManager *setupManager;

@property (nonatomic) CDALockCommandManager *commandManager;

@end

@implementation CDALockController

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.setupManager = [[CDALockSetupManager alloc] init];
        
        self.setupManager.delegate = self;
        
        self.commandManager = [[CDALockCommandManager alloc] init];
        
        self.commandManager.delegate = self;
        
        // load the controller
        [self loadController];
    }
    return self;
}

+ (instancetype)sharedStore
{
    static CDALockController *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Private Methods

-(void)loadController
{
    // load settings
    
    [self observeValueForKeyPath:NSStringFromSelector(@selector(<#selector#>))
                        ofObject:<#(id)#>
                          change:@{NSKeyValueObservingOptionInitial, }
                         context:KVOContext];
    
    if (!self.setupManager.isConfigured) {
        
        NSError *enableSetupError;
        
        if (![self.setupManager enableSetupModeWithError:&enableSetupError]) {
            
            
        }
    }
    
}

-(void)

@end
