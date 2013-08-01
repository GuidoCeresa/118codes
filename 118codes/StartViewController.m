//
//  StartViewController.m
//  118codes
//
//  Created by Guido Ceresa on 25-7-13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "StartViewController.h"
#import "DueScelteViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    UIView *subView;
    CGRect frame = CGRectMake(60, 100, 200, 200);
    subView = [[UIView alloc] initWithFrame:frame];
    subView.backgroundColor = [UIColor redColor];
    [self.view addSubview:subView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self primaDomanda];
}

/**
 Parametri interni
 domanda
 numero scelte
 dove va per ogni scleta.
 */
- (void)primaDomanda {
    [self sceltaDomanda:@"Domandina?" andNumeroScelte:2];
    //Vuoi continuare?
    
    //si -> seconda
    //no -> terza
}

- (void)secondaDomanda {

}

- (void)terzaDomanda
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - sclete

- (void)sceltaDomanda:(NSString *)domanda andNumeroScelte:(int)numeroScelte {
    switch (numeroScelte) {
        case 2:
            [self dueScelteConDomanda:domanda];
            break;
            
        default:
            //
            break;
    }
}

- (void)dueScelteConDomanda:(NSString *)domanda {
    DueScelteViewController *dueScelte = [[DueScelteViewController alloc] init];
    dueScelte.domanda = domanda;
    dueScelte.delegate = self;

    [self.navigationController pushViewController:dueScelte animated:YES];

}


//--Ritorno dalla scelta col valore selezionato
//--Regola una variabile per proseguire
- (void)sceltaEffettuata:(NSString *)valoreSelezionato {

//faccio quaklcosa quando ho finito
    int k = 0;
}


@end
