//
// SessionWrapper.m
// passably-connected
//
//
//  Created by Yvan Scher on 10/7/14.
//  Copyright (c) 2014 Yvan Scher. All rights reserved.
//

#import "SessionWrapper.h"

static NSString* const ServiceName = @"passably-connected-YOURAPPNAME";

@interface SessionWrapper()

@property (nonatomic) MCPeerID *myPeerID;

@end

@implementation SessionWrapper

#pragma mark - Getters/Setters/Initializers/Destroyers

/* - Returns local user's peerID - */

-(MCPeerID*) getMyPeerID{

    return _myPeerID;
}

/* - Returns our app name in "service name" terms
 - important for browsing/advertising on dif. services
 - */

-(NSString*) getServiceName{

    return ServiceName;
}

/* - Returns number of peers in peer array - */

-(NSUInteger) numberConnectedPeers{

    return _session.connectedPeers.count;
}

/* - destroys a session - */

-(void) destroySession{

    [_session disconnect];
}

/* - initializes a sesssion (called from ViewController.m)
 - advertising/browsing are done in respective helpers
 - */

-(instancetype) initSessionWithName: (NSString *)name{

    NSLog(@"%s STARTED SESSION WITH NAME: %@", __PRETTY_FUNCTION__, name);

    _myPeerID = [[MCPeerID alloc] initWithDisplayName:name];
    _session = [[MCSession alloc] initWithPeer: _myPeerID];
    _session.delegate = self;
    return self;
}

/* - get peer at index - */

-(MCPeerID *) getPeerAtIndex:(NSUInteger)index{

    if(index >= _session.connectedPeers.count) return nil;
    return _session.connectedPeers[index];
}

#pragma mark - MCSessionDelegate

/* - REMOTE PEER HAS ALTERED ITS STATE SOMEHOW - */

-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{

    [_sessionDelegate peer:peerID didChangeState:state];
}

/* - STARTED RECEIVING RESOURCE FROM REMOTE PEER - */

-(void) session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)foreignPeerID withProgress:(NSProgress *)progress{

    [_sessionDelegate didStartReceivingResource:session resourceName:resourceName fromPeer:foreignPeerID withProgress:progress];
}

/* - DID FINISH RECEIVEING RESOURCE FROM PEER - */

-(void) session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)foreignPeerID atURL:(NSURL *)localURL withError:(NSError *)error{

    [_sessionDelegate didFinishReceivingResource:session resourceName:resourceName fromPeer:foreignPeerID atURL:localURL withError:error];
}

/* - DID RECEIVE STREAM FROM PEER - */

-(void) session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{

    [_sessionDelegate didReceiveStream:stream withName:streamName fromPeer:peerID];
}

/* - RECEIVED DATA FROM REMOTE PEER - */

-(void) session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{

    [_sessionDelegate didReceiveData:data fromPeer:peerID];
}

/* - I should probably figure out what this method actually does...not in the docs...THANKS OBAMA - */

-(void)session:(MCSession *)session didReceiveCertificate:(NSArray *)cert fromPeer:(MCPeerID *)peerID certificateHandler:(void(^)(BOOL accept))certHandler {

    certHandler(YES);
}

@end
