//
//  MRNowPlayingHook.m
//  MediaRemoteInjection
//
//  Created by JH on 2025/4/14.
//

#import "MRDMediaRemoteClientHook.h"
#import <objc/runtime.h>
@class NSMutableDictionary, NSObject, MRDMediaRemoteUIService, MRXPCConnection, NSMutableArray, MRXPCConnectionMonitor, NSString, MRPlaybackQueueClient, MRPlayerPath, MRDPairingHandler, NSOperationQueue, NSArray, NSData, MRDTaskAssertion;
@protocol OS_dispatch_source, OS_dispatch_queue, MRDXPCMessageHandling, MRXPCConnectionMonitorDelegate;

@interface MRDMediaRemoteClient : NSObject {
    NSObject<OS_dispatch_source> *_source; // offset: 8
    NSObject<OS_dispatch_queue> *_serialQueue; // offset: 16
    NSObject<OS_dispatch_queue> *_workerQueue; // offset: 24
    NSArray *_applicationPickedRoutes; // offset: 32
    NSString *_processName; // offset: 48
    NSMutableArray *_assertions; // offset: 56
    NSOperationQueue *_relayingMessages; // offset: 64
    NSMutableDictionary *_pendingPlaybackSessionMigrateEvents; // offset: 80
    NSMutableArray *_subscribedWakingPlayerPaths; // offset: 88
    MRXPCConnectionMonitor *_connectionMonitor; // offset: 96
    BOOL _areNotificationsPaused; // offset: 104
    NSMutableArray *_queuedNotifications; // offset: 112
    NSMutableDictionary *_criticalSectionAssertions; // offset: 120
}

@property (weak, nonatomic) id<MRDXPCMessageHandling> messageHandler;
@property (readonly, nonatomic) MRXPCConnection *connection;
@property (readonly, nonatomic) int pid;
@property (readonly, nonatomic) unsigned int euid;
@property (readonly, nonatomic) struct { unsigned int x0[8]; } realToken;
@property (readonly, nonatomic) NSData *auditToken;
@property (readonly, nonatomic) NSString *bundleIdentifier;
@property (strong, nonatomic) MRDTaskAssertion *currentTaskAssertion;
@property (readonly, nonatomic) NSString *displayName;
@property (readonly, nonatomic) NSString *processName;
@property (nonatomic) unsigned int hardwareRemoteBehavior;
@property (readonly, nonatomic) unsigned long long routeDiscoveryCount;
@property (nonatomic) unsigned int routeDiscoveryMode;
@property (nonatomic) unsigned int outputDeviceDiscoveryMode;
@property (copy, nonatomic) NSArray *applicationPickedRoutes;
@property (strong, nonatomic) MRDMediaRemoteUIService *remoteUIService;
@property (strong, nonatomic) MRDPairingHandler *pairingHandler;
@property (readonly, nonatomic) BOOL isActive;
@property (nonatomic) BOOL keepAlive;
@property (nonatomic) BOOL hasRequestedLegacyNowPlayingInfo;
@property (nonatomic) BOOL hasRequestedSupportedCommands;
@property (nonatomic) BOOL declaringAirplayActive;
@property (strong, nonatomic) MRPlayerPath *nowPlayingAirPlaySession;
@property (readonly, nonatomic) BOOL canBeNowPlaying;
@property (readonly, nonatomic) BOOL isMediaRemoteDaemon;
@property (readonly, nonatomic) unsigned long long entitlements;
@property (readonly, nonatomic) MRPlaybackQueueClient *playbackQueueRequests;
@property (readonly, nonatomic, getter=isInCriticalSection) BOOL inCriticalSection;

- (id)initWithConnection:(id)a0;
- (BOOL)isEntitledFor:(unsigned long long)a0;
- (void)addPendingPlaybackSessionMigrateEvent:(id)a0 playerPath:(id)a1;
- (BOOL)removePendingPlaybackSessionMigrateEvent:(id)a0;
- (void)flushPendingPlaybackSessionMigrateEvents:(id /* block */)a0;
//- (BOOL)_isAllowedAccessToDataFromPlayerPath:(id)a0; Remove from 15.4
- (BOOL)isAllowedAccessToDataFromPlayerPath:(id)a0;
- (void)postNotification:(id)a0;
- (void)pauseNotifications;
- (void)resumeNotifications;
- (BOOL)notificationRequiresTaskAssertionForPlayerPath:(id)a0;
- (void)setWantsAssertionsForNotificationsWithPlayerPath:(id)a0;
- (BOOL)takeAssertion:(long long)a0 forReason:(id)a1 duration:(double)a2;
- (BOOL)takeAssertionAndBlessForReason:(id)a0;
- (void)takeCriticalSectionAssertionForRequestID:(id)a0 completion:(id /* block */)a1;
- (void)invalidateCriticalSectionAssertionForRequestID:(id)a0;
- (void)sendRemoteControlCommand:(id)a0 withCompletionBlock:(id /* block */)a1;
- (void)relayXPCMessage:(id)a0 andReply:(BOOL)a1;
- (void)relayXPCMessage:(id)a0 andReply:(BOOL)a1 resultCallback:(id /* block */)a2;
- (void)_relayXPCMessage:(id)a0 andReply:(BOOL)a1 resultCallback:(id /* block */)a2;
- (id)createNowPlayingClient;
- (void)_handleXPCMessage:(id)a0;
- (void)_invalidate;
- (id)_runAssertionName;
- (void)_resumeConnection;
- (void)_postNotification:(id)a0;

@end

@implementation NSObject (MRDMediaRemoteClientHook)

- (BOOL)mediaRemoteInjection_isAllowedAccessToDataFromPlayerPath:(id)a0 {
    return YES;
}

@end


@implementation MRDMediaRemoteClientHook

+ (instancetype)sharedHook {
    static MRDMediaRemoteClientHook *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)load {
    NSLog(@"MRDMediaRemoteClientHook loaded");
    Class MRDMediaRemoteClientClass = NSClassFromString(@"MRDMediaRemoteClient");
    if (!MRDMediaRemoteClientClass) return;
    Method method1 = class_getInstanceMethod(MRDMediaRemoteClientClass, @selector(isAllowedAccessToDataFromPlayerPath:));
    Method method2 = class_getInstanceMethod(MRDMediaRemoteClientClass, @selector(mediaRemoteInjection_isAllowedAccessToDataFromPlayerPath:));
    if (method1 && method2) {
        method_exchangeImplementations(method1, method2);
        NSLog(@"Swizzled isAllowedAccessToDataFromPlayerPath with mediaRemoteInjection_isAllowedAccessToDataFromPlayerPath");
    }
    
}



@end
