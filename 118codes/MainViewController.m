//
//  MainViewController.m
//  118codes
//
//  Created by Guido Ceresa on 25-7-13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "MainViewController.h"
#import "StartViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action methods

- (IBAction)pressButtonStart:(id)sender {
    StartViewController *startViewController = [[StartViewController alloc] init];
    [self.navigationController pushViewController:startViewController animated:YES];
}

@end
