//
//  RegistrationWebViewController.m
//  GNGT
//
//  Created by Richard Clark on 3/14/11.
//  Copyright 2011 Next Question Consulting. All rights reserved.
//

#import "RegistrationWebViewController.h"


@implementation RegistrationWebViewController
@synthesize webView;

- (id)init
{
    self = [super init];
    if (self) {
        webView = nil;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 411.0)];
    self.view = webView;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self.webView release];
    self.webView = nil;
}

- (IBAction) done
{
    // TODO dismiss this
}

@end
