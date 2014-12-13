//
// ViewController.h
// passably-connected
//
//
//  Created by Yvan Scher on 10/7/14.
//  Copyright (c) 2014 Yvan Scher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionWrapper.h"
#import "BrowserWrapper.h"
#import "AdvertiserWrapper.h"

@interface ViewController : UIViewController <SessionWrapperDelegate, BrowserWrapperDelegate , AdvertiserWrapperDelegate>{

}

@property (nonatomic, readonly) SessionWrapper *sessionWrapper;
@property (nonatomic, readonly) BrowserWrapper *browserWrapper;
@property (nonatomic, readonly) AdvertiserWrapper *advertiserWrapper;

@end
