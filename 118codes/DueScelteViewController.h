//
//  DueScelteViewController.h
//  118codes
//
//  Created by Guido Ceresa on 1-8-13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScelteDelegate <NSObject>

- (void)sceltaEffettuata:(NSString *)valoreSelezionato;

@end

@interface DueScelteViewController : UIViewController {
    
    NSString *sceltaDefault1;
    NSString *sceltaDefault2;
    NSString *risposta;
}
//--delegate standard
@property (nonatomic, retain) id delegate;

@property (nonatomic, strong)NSString *domanda;
@property (nonatomic, strong)NSString *scelta1;
@property (nonatomic, strong)NSString *scelta2;


@end
