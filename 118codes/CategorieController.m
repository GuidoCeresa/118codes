//
//  CategorieController.m
//  118codes
//
//  Created by Alessandro Valbonesi on 12-12-2012.
//  Copyright (c) 2012 Alessandro Valbonesi. All rights reserved.
//

#import "CategorieController.h"
#import "ProtocolliController.h"
#import "AlgosLibPlist.h"
#import "AlgosLibUtil.h"
#import "Lib118codes.h"

@interface CategorieController ()

@end

@implementation CategorieController

#pragma mark - Synthesize Variables

#pragma mark - Constants
//--Nome del file PList da cui recuperare l'elenco delle categorie
//--Nome del campo chiave interno al NSDictionary
static NSString *kCategorie = @"categorie";

//--Nome del campo chiave interno al NSDictionary
static NSString *kVisibile = @"visibile";

//--Nome del file PList da cui recuperare l'elenco dei protocolli (per estrarre le categorie usate)
static NSString *kProtocolli = @"protocolli";

//--Identificatore della prototype cell nello storyboard
static NSString *kCell = @"catCell";

//--Identificatore del segue tra categorie e protocolli nello storyboard
static NSString *kSegue = @"categorieprotocolli";

//--Flag per recuperare le categorie da una lista fissa, oppure dinamicamente quelle usate effettivamente dai protocolli
static BOOL flagCategorieFisse = false;

#pragma mark - Local Variables
//--Valore della riga selezionata
NSString *category;

//--Lista records
NSArray *myData;

#pragma mark - Init

#pragma mark - Init View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //--copy data from plist to array
  //  [self readFromPlist];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // copy data from plist to array
    [self readFromPlist];
}

#pragma mark - Table view data source
// Return the number of sections.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Return the number of rows in the section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return myData.count;
}

//--Insert individual row into the table view--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
        
    @try {
        cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
	}
    @catch (NSException* ex) {
        NSLog(@"Unable to dequeue a cell with identifier categCells! %@", kCell);
    }
    
    // Configure the cell...
    if (cell) {
        cell.textLabel.text = [myData objectAtIndex:indexPath.row];
    }
    
    return cell;
}


#pragma mark - Table Edit
//--Selezionata una riga della tabella--
//--Navigation logic may go here. Create and push another view controller.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    category = [myData objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:kSegue sender:self];
}

#pragma mark - Table view delegate
//--Dopo aver selezionato il segue, passa di qui per eventuali regolazioni--
//--Navigation logic may go here. Set data for new view.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:kSegue]) {
        if (category != nil) {
            if ([category isKindOfClass:[NSString class]]) {
                ProtocolliController *protocolliView = segue.destinationViewController;
                protocolliView.category = category;
            }
        }
    }
}


#pragma mark - Utility methods
//--copy data from plist to array
- (void)readFromPlist {
    if (flagCategorieFisse) {
        [self readFromCategorie];
    } else {
        [self readFromProtocolli];
    }
}

//--Recupera staticamente le categorie da una lista fissa
- (void)readFromCategorie {
    if ([AlgosLibPList isEsistePlistForName:kCategorie]) {
        myData = [AlgosLibPList keysFromPlistName:kCategorie];
    } else {
        NSLog(@"Manca il file PList:categorie. Nel metodo 'readFromCategorie' di 'CategorieController', al suo posto ho trovato %@", kCategorie);
    }
}


//--Recupera dinamicamente le categorie da quelle effettivamente usate nei protocolli
- (void)readFromProtocolli {
    NSMutableArray *arrayTmp = [[NSMutableArray alloc] init];
    NSDictionary *dictRoot;
    NSDictionary *dicProtocollo;
    NSArray *listaCategorie;
    
    if ([AlgosLibPList isEsistePlistForName:kProtocolli]) {
        dictRoot = [AlgosLibPList dictionaryWithString:kProtocolli];
        if (dictRoot != nil) {
            for (NSString *key in dictRoot) {
                dicProtocollo = [dictRoot objectForKey:key];
                if ([AlgosLibUtil boolValueFromDict:dicProtocollo forKey:kVisibile]) {
                    listaCategorie = [Lib118codes listaCategorieFromDizionario:dicProtocollo];
                    for (NSString *cat in listaCategorie) {
                        if (![arrayTmp containsObject:cat]) {
                            [arrayTmp addObject:cat];
                        }
                    }
                }
            }
        } else {            
            NSLog(@"Non sono riuscito a leggere correttamente il file %@.plist nel metodo 'readFromProtocolli' di 'CategorieController'", kProtocolli);
        }
    } else {
        NSLog(@"Manca il file PList:categorie. Nel metodo 'readFromProtocolli' di 'CategorieController', al suo posto ho trovato %@", kProtocolli);
    }
    myData = [arrayTmp sortedArrayUsingSelector:@selector(compare:)];
}


@end
