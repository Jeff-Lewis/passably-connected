//
// SessionWrapper.h
// passably-connected
//
//
//  Created by Yvan Scher on 10/7/14.
//  Copyright (c) 2014 Yvan Scher. All rights reserved.
//

#import <MultipeerConnectivity/MultipeerConnectivity.h>

@protocol SessionWrapperDelegate <NSObject>

-(void) didFinishReceivingResource:(MCSession *)session resourceName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error;

-(void)didStartReceivingResource:(MCSession *)session resourceName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress;

-(void) didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID;

-(void) didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID;

-(void) peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state;

@end

@interface SessionWrapper : NSObject <MCSessionDelegate>{

}

@property (nonatomic) MCSession *session;
@property (nonatomic, readonly) MCPeerID *myPeerID;
@property (nonatomic) id <SessionWrapperDelegate> sessionDelegate;

-(void) destroySession;
-(MCPeerID*) getMyPeerID;
-(NSString*) getServiceName;
-(NSUInteger) numberConnectedPeers;
-(MCPeerID *) getPeerAtIndex:(NSUInteger)index;
-(instancetype) initSessionWithName: (NSString *)name;

@end
