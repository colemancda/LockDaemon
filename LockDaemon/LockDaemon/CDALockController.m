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

#pragma mark - KVO



#pragma mark - Methods



#pragma mark - Private Methods

-(void)loadController
{
    NSLog(@"Loading Lock Controller...");
    
    // load settings
    
    // start setup mode if
    if (!self.setupManager.isConfigured) {
        
        NSLog(@"Settings not configured, enabling setup mode");
        
        NSError *enableSetupError;
        
        if (![self.setupManager enableSetupModeWithError:&enableSetupError]) {
            
            NSLog(@"Error enabling setup mode (%@)", enableSetupError);
            
            return;
        }
        
        NSLog(@"Setup mode enabled");
        
        return;
    }
    
}

-(void)displayError
{
    NSLog(@"Error occurred, lock needs maintainance.");
    
    NSLog(@"Blinking red LED...");
}

#pragma mark - CDALockCommandManagerDelegate

-(void)lockCommandManager:(CDALockCommandManager *)lockCommandManager didRecieveLockCommand:(CDALockCommand *)lockCommand
{
    NSLog(@"Recieved lock command: %@", lockCommand);
}

-(void)lockCommandManager:(CDALockCommandManager *)lockCommandManager errorReceivingLockCommand:(NSError *)error
{
    NSLog(@"Could not fetch lock commands from server. (%@)", error);
}

#pragma mark - CDALockSetupManagerDelegate



@end
