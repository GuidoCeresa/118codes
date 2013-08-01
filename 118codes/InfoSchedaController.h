//
//  InfoSchedaController.h
//  118codes
//
//  Created by Guido Ceresa on 16-12-12.
//  Copyright (c) 2012 Alessandro Valbonesi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoSchedaController : UIViewController <UIWebViewDelegate> {
    NSString *nomeInfoFile;
    NSString *nomeSegue;
	IBOutlet UIWebView* web;
	IBOutlet UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) IBOutlet UIWebView* web;
@property (nonatomic, retain) NSString *nomeInfoFile;
@property (nonatomic, retain) NSString *nomeSegue;
@property(nonatomic,retain) UIActivityIndicatorView *activityIndicator;

- (IBAction)setInfo:(id)sender;

@end
