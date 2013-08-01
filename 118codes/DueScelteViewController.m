//
//  DueScelteViewController.m
//  118codes
//
//  Created by Guido Ceresa on 1-8-13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "DueScelteViewController.h"

@interface DueScelteViewController ()

@end

@implementation DueScelteViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    sceltaDefault1 = @"Scelta 1";
    sceltaDefault2 = @"Scelta 2";

	// Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated {
    [self checkVariabili];
    [self impostazioniView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - check variabili.

- (void)checkVariabili {
    if (self.scelta1 == NULL) {
        self.scelta1 = sceltaDefault1;
    }
    if (!self.scelta2) {
        self.scelta2 = sceltaDefault2;
    }
}

#pragma mark - Impostazioni View.

- (void)impostazioniView {
    UILabel *labelDomanda = [self setLabelDomanda];
    [self.view addSubview:labelDomanda];
    
    UIButton *buttonRisposta1 = [self setButtonRisposta1];
    [self.view addSubview:buttonRisposta1];
    
    UIButton *buttonRisposta2 = [self setButtonRisposta2];
    [self.view addSubview:buttonRisposta2];

}

- (UILabel *)setLabelDomanda {
    UILabel *labelDomanda = [[UILabel alloc] init];
    [labelDomanda setFrame:CGRectMake(100, 20, 100, 100)];
    [labelDomanda setText:self.domanda];
    
    return labelDomanda;
}

- (UIButton *)setButtonRisposta1 {
    UIButton *buttonRisposta1 = [[UIButton alloc] init];
    [buttonRisposta1 setFrame:CGRectMake(20, 200, 100, 50)];
    [buttonRisposta1 setTitle:self.scelta1 forState:UIControlStateNormal];
    [buttonRisposta1 setTag:1];
    [buttonRisposta1 addTarget:self action:@selector(pressRisposta:) forControlEvents:UIControlEventTouchUpInside];
    
    return buttonRisposta1;
}

- (UIButton *)setButtonRisposta2 {
    UIButton *buttonRisposta2 = [[UIButton alloc] init];
    [buttonRisposta2 setFrame:CGRectMake(200, 200, 100, 50)];
    [buttonRisposta2 setTitle:self.scelta2 forState:UIControlStateNormal];
    [buttonRisposta2 setTag:2];
    [buttonRisposta2 addTarget:self action:@selector(pressRisposta:) forControlEvents:UIControlEventTouchUpInside];

    return buttonRisposta2;
}

#pragma mark - Action

- (IBAction)pressRisposta:(id)sender {
  
    [self.delegate sceltaEffettuata:@"risposta"];

    
}

@end
