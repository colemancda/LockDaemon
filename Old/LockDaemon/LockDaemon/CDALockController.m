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
#import "CDALockDefines.h"
#import "CDALockCommand.h"

static void *KVOContext = &KVOContext;

@interface CDALockController ()

@property (nonatomic) CDALockSetupManager *setupManager;

@property (nonatomic) CDALockCommandManager *commandManager;

@property (nonatomic) CDALockMode lockMode;

@end

@implementation CDALockController

#pragma mark - Initialization

- (void)dealloc
{
    [self removeObserver:self
              forKeyPath:NSStringFromSelector(@selector(lockMode))
                 context:KVOContext];
}

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

+ (instancetype)sharedController
{
    static CDALockController *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(lockMode))]) {
            
            [self loadLockMode:self.lockMode];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Methods



#pragma mark - Private Methods

-(void)loadController
{
    NSLog(@"Loading Lock Controller...");
    
    // KVO
    
    [self addObserver:self
           forKeyPath:NSStringFromSelector(@selector(lockMode))
              options:NSKeyValueObservingOptionNew
              context:KVOContext];
    
    // start setup mode if lock is configured
    if (!self.setupManager.isConfigured) {
        
        self.lockMode = CDALockModeSetup;
    }
    
    // else, start 
    else {
        
        self.lockMode = CDALockModeCommandReceiver;
    }
    
}

-(void)loadLockMode:(CDALockMode)lockMode
{
    NSString *lockModeName;
    
    switch (lockMode) {
            
        case CDALockModeSetup:
            
            lockModeName = @"Setup";
            
            break;
            
        case CDALockModeCommandReceiver:
            
            lockModeName = @"Command Reciever";
            
            break;
            
        case CDALockModeFatalError:
            
            lockModeName = @"Error";
            
            break;
    }
    
    NSLog(@"Set Lock Mode to %@", lockModeName);
    
    switch (lockMode) {
            
        case CDALockModeFatalError:
            
            [self displayError];
            
            break;
            
        case CDALockModeCommandReceiver:
            
            [self recieveCommands];
            
            break;
            
        case CDALockModeSetup:
            
            [self enableSetupMode];
            
            break;
    }
}

-(void)displayError
{
    NSLog(@"Error occurred, lock needs maintainance.");
    
    NSLog(@"Blinking red LED...");
}

-(void)recieveCommands
{
    // load settings
    
    self.commandManager.requestInterval = [[self.setupManager valueForSetting:CDALockSettingRequestIntervalKey] doubleValue];
    
    NSString *serverURLString = [self.setupManager valueForSetting:CDALockSettingServerURLKey];
    
    self.commandManager.serverURL = [NSURL URLWithString:serverURLString];
    
    self.commandManager.secret = [self.setupManager valueForSetting:CDALockSettingSecretKey];
    
    self.commandManager.lockIdentifier = [self.setupManager valueForSetting:CDALockSettingIdentifierKey];
    
    // start polling server
    
    NSLog(@"Polling server for lock commands every %.1f seconds...", self.commandManager.requestInterval);
    
    [self.commandManager startRequests];
}

-(void)enableSetupMode
{
    
    
}

#pragma mark - CDALockCommandManagerDelegate

-(void)lockCommandManager:(CDALockCommandManager *)lockCommandManager didRecieveLockCommand:(CDALockCommand *)lockCommand
{
    if (_lastError) {
        
        NSLog(@"Reconnected to server");
    }
    
    // clear last error
    _lastError = nil;
    
    if (lockCommand.shouldUpdate) {
        
        // attempt to update
        
        NSLog(@"Will update...");
    }
    
    if (lockCommand.shouldUnlock) {
        
        NSLog(@"Will unlock...");
    }
}

-(void)lockCommandManager:(CDALockCommandManager *)lockCommandManager errorReceivingLockCommand:(NSError *)error
{
    // only print new errors
    if (_lastError == nil || (_lastError.domain != error.domain || _lastError.code != error.code)) {
        
        NSLog(@"Could not fetch lock commands from server. (%@)", error);
    }
    
    _lastError = error;
    
    // set LED to orange
    
    
}

#pragma mark - CDALockSetupManagerDelegate

-(void)setupManager:(CDALockSetupManager *)setupManager didReceiveValidValues:(BOOL)validValues
{
    
}

@end
