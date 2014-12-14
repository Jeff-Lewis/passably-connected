//
// ViewController.m
// passably-connected
//
//
//  Created by Yvan Scher on 10/7/14.
//  Copyright (c) 2014 Yvan Scher. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>


@interface ViewController ()

@property (nonatomic) SessionWrapper *sessionWrapper;
@property (nonatomic) BrowserWrapper *browserWrapper;
@property (nonatomic) AdvertiserWrapper *advertiserWrapper;

@end

@implementation ViewController

/* - initialize the session, start advertising yourself, then
   - search for other peers.
   - */

- (void)viewDidLoad {

    [super viewDidLoad];
    _sessionWrapper = [[SessionWrapper alloc] initSessionWithName:@"passably-connected-session"];
    _advertiserWrapper = [[AdvertiserWrapper alloc] startAdvertising:_sessionWrapper.myPeerID];
    _browserWrapper = [[BrowserWrapper alloc] startBrowsing:_sessionWrapper.myPeerID];
    _sessionWrapper.sessionDelegate = self;
    _advertiserWrapper.advertiserDelegate = self;
    _browserWrapper.browserDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - BrowserWrapperDelegate

-(void) inviteFoundPeer:(MCPeerID *)foreignPeerID{

    NSLog(@"%s INVITED FOREIGN PEER: %@", __PRETTY_FUNCTION__, foreignPeerID);
    [_browserHelper.autobrowser invitePeer:foreignPeerID toSession:_sessionHelper.session withContext:nil timeout:5.0];
}

-(void) alertToLostPeer:(MCPeerID *)lostForeignPeerID{

    NSLog(@"%s LOST CONNECTION TO FOREIGN PEER: %@", __PRETTY_FUNCTION__, lostForeignPeerID);
}

-(void) failedToBrowse:(NSError *)error{

    NSLog(@"%s FAILED TO START BROWSING ALL TOGETHER WITH ERROR: %@", __PRETTY_FUNCTION__, error);
}

#pragma mark - AdvertiserWrapperDelegate

/* - method gets triggered from AdvertiserHelper-didreceiveInvitaiton
   - */

-(void) acceptInvitationFromPeer:(MCPeerID *)foreignPeerID
               invitationHandler:(void (^)(BOOL, MCSession *))invitationHandler{

    invitationHandler(YES, _sessionWrapper.session);

    NSLog(@"%s INVITATION FROM PEER %@ ACCEPTED", __PRETTY_FUNCTION__, foreignPeerID);
    // - [_advertiserWrapper stopAdvertising]; // - uncomment if that's your jam - //
}

-(void) failedToAdvertise:(NSError *)error{

    NSLog(@"%s FAILED TO START ADVERTISING ALL TOGETHER WITH ERROR: %@", __PRETTY_FUNCTION__, error);
}

#pragma mark - SessionWrapperDelegate

-(void) peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{

    NSLog(@"%s PEER CHANGED STATE: %ld, FROM PEER: %@", __PRETTY_FUNCTION__, state, peerID);
}

-(void) didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{

    NSLog(@"%s RECEIVED DATA: %@, FROM PEER: %@", __PRETTY_FUNCTION__, data, peerID);
}

-(void) didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{

    NSLog(@"%s RECEIVED RESOURCE: %@, FROM PEER: %@", __PRETTY_FUNCTION__, streamName, peerID);
}

-(void)didStartReceivingResource:(MCSession *)session resourceName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress{

    NSLog(@"%s STARTED RECEIVEING RESOURCE: %@, FROM PEER: %@", __PRETTY_FUNCTION__, resourceName, peerID);
}

-(void) didFinishReceivingResource:(MCSession *)session resourceName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error{

    NSLog(@"%s FINISHED RECEIVEING RESOURCE: %@, FROM PEER: %@", __PRETTY_FUNCTION__, resourceName, peerID);
    if (error) {NSLog(@"Error %@", [error localizedDescription]);}
}

@end
