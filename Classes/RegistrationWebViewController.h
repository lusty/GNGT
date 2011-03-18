//
//  RegistrationWebViewController.h
//  GNGT
//
//  Created by Richard Clark on 3/14/11.
//  Copyright 2011 Next Question Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RegistrationWebViewController : UIViewController {
    UIWebView *webView;
}

@property (nonatomic, retain) UIWebView *webView;

- (IBAction) done;

@end
