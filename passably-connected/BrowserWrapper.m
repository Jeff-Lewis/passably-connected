//
// BrowserWrapper.m
// passably-connected
//
//
//  Created by Yvan Scher on 10/7/14.
//  Copyright (c) 2014 Yvan Scher. All rights reserved.
//

#import "BrowserWrapper.h"

@interface BrowserWrapper ()

@property (nonatomic) MCNearbyServiceBrowser *autobrowser;
@property (nonatomic) BOOL browsing;

@end

@implementation BrowserWrapper

#pragma mark - Getters/Setters/Initializers/Destroyers

/* - creates a browser, starts browsing - */

-(instancetype) startBrowsing:(MCPeerID *)myPeerID{

    NSLog(@"%s STARTED ADVERTISING WITH MY PEERID: %@", __PRETTY_FUNCTION__, myPeerID);
    _autobrowser = [[MCNearbyServiceBrowser alloc] initWithPeer:myPeerID serviceType:@"AirDoc"];
    _autobrowser.delegate = self;
    [_autobrowser startBrowsingForPeers];
    return self;
}

/* - stops the browser from browsing - */
-(void) stopBrowsing{

    [_autobrowser stopBrowsingForPeers];
}

/* - restarts a stopped browser - */

-(void) restartBrowsing{

    [_autobrowser startBrowsingForPeers];
}

#pragma mark - MCBrowserDelegate

/* - FOUND A FOREIGN PEER NOW INVITE THAT SUCKER - */

-(void) browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)foreignPeerID withDiscoveryInfo:(NSDictionary *)info{

    [_browserDelegate inviteFoundPeer:foreignPeerID];
}

/* - LOST A PEER, ALERT THE VIEW CONTROLLER - */

-(void) browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)foreignPeerID {

    [_browserDelegate alertToLostPeer:foreignPeerID];
}
/* - FOR SOME REASON WE FAILED TO START BROWSING, ALERT THE VIEW CONTROLLER- */

-(void) browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error{

    [_browserDelegate failedToBrowse:error];
}

@end
