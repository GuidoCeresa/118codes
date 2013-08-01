//
//  ProtocolsController.m
//  118codes
//
//  Created by Alessandro Valbonesi on 12-12-2012.
//  Copyright (c) 2012 Alessandro Valbonesi. All rights reserved.
//

#import "ProtocolliController.h"
#import "AlgosLibPlist.h"
#import "AlgosLibUtil.h"
#import "Lib118codes.h"
#import "ATableLabelController.h"
#import "ATableOpzioniController.h"
#import "ColorataController.h"

@interface ProtocolliController ()

@end

@implementation ProtocolliController

#pragma mark - Synthesize Variables
@synthesize category;

#pragma mark - Constants
//--Nome del file PList da cui recuperare l'elenco dei protocolli (per estrarre le categorie usate)
static NSString *kProtocolli = @"protocolli";

//--Titolo della finestra mancante
static NSString *kMancaTitolo = @"Manca titolo";

//--Nome del campo chiave interno al NSDictionary
static NSString *kTitolo = @"titoloLista";

//--Nome del campo chiave interno al NSDictionary
static NSString *kTitoloFinestra = @"titoloFinestra";

//--Nome del campo chiave interno al NSDictionary
static NSString *kSottoTitolo = @"sottoTitolo";

//--Nome del campo chiave interno al NSDictionary
static NSString *kChiave = @"chiave";

//--Identificatore della prototype cell nello storyboard
static NSString *kCell = @"protoCell";

//--Nome del campo chiave interno al NSDictionary
static NSString *kSegue = @"segue";

//--Identificatore del segue tra protocolli e la tavola specializzata, nello storyboard
static NSString *kSegueLabel = @"segueLabel";

//--Identificatore del segue tra protocolli e la tavola specializzata, nello storyboard
static NSString *kSegueOpzioni = @"segueOpzioni";

//--Identificatore del segue tra protocolli e la tavola specializzata, nello storyboard
static NSString *kSegueColorata = @"segueColorata";

#pragma mark - Local Variables
//--Lista records
NSArray *myData;

#pragma mark - Init

#pragma mark - Init View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //--regolazioni varie iniziali--
    [self regolazioniIniziali];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // copy data from plist to array
    [self readFromPlist];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    myData = nil;
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
    NSInteger riga = indexPath.row;

    @try {
        cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
	}
    @catch (NSException* ex) {
        NSLog(@"Unable to dequeue a cell with identifier categCells! %@", kCell);
    }
    
    // Configure the cell...
    if (cell) {
        cell.textLabel.text=[[myData objectAtIndex:riga] objectForKey:kTitolo];
        cell.detailTextLabel.text=[[myData objectAtIndex:riga] objectForKey:kSottoTitolo];
    }
    
    return cell;
}


#pragma mark - Table Edit
//--Selezionata una riga della tabella--
//--Navigation logic may go here. Create and push another view controller.
//--Recupera dai dati della riga il nome del segue (quindi del tipo di Table) da utilizzare
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict;
    NSString *segue;
    
    dict = [myData objectAtIndex:indexPath.row];
    segue = [dict objectForKey:kSegue];
    if ([segue length] > 0) {
        if ([segue isEqualToString:kSegueLabel]) {
            [self performSegueWithIdentifier:segue sender:self];
        }
        if ([segue isEqualToString:kSegueOpzioni]) {
            [self performSegueWithIdentifier:segue sender:self];
        }

        if ([segue isEqualToString:kSegueColorata]) {
            [self performSegueWithIdentifier:segue sender:self];
        }
}
}


#pragma mark - Table view delegate
//--Dopo aver selezionato il segue, passa di qui per eventuali regolazioni--
//--Navigation logic may go here. Set data for new view.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *segueId = [segue identifier];
    
    if ([segueId isEqualToString:kSegueLabel]) {
        ATableLabelController *destTableLabel = segue.destinationViewController;
        destTableLabel.titoloFinestra = [self getTitoloFinestraRigaSelezionata];
        destTableLabel.nomeFilePList = [self getChiaveRigaSelezionata];;
    }

    if ([segueId isEqualToString:kSegueOpzioni]) {
        ATableOpzioniController *destTableOpzioni = segue.destinationViewController;
        destTableOpzioni.titoloFinestra = [self getTitoloFinestraRigaSelezionata];
        destTableOpzioni.nomeFilePList = [self getChiaveRigaSelezionata];;
    }

    if ([segueId isEqualToString:kSegueColorata]) {
        ColorataController *destTableOpzioni = segue.destinationViewController;
        destTableOpzioni.titoloFinestra = [self getTitoloFinestraRigaSelezionata];
        destTableOpzioni.nomeFilePList = [self getChiaveRigaSelezionata];;
    }
}


#pragma mark - Utility methods
//--regolazioni varie iniziali--
- (void)regolazioniIniziali {
    //--titolo della finestra--
    if (category) {
        [self setTitle:category];
    } else {
        [self setTitle:kMancaTitolo];
    }
}

// copy data from plist to array
- (void)readFromPlist {
    NSDictionary *dictRoot;
    NSArray *array;

    if ([AlgosLibPList isEsistePlistForName:kProtocolli]) {
        dictRoot = [AlgosLibPList dictionaryWithString:kProtocolli];
        array = [Lib118codes listaDizionariVisibiliFromDizionario:dictRoot withCategorie:category];
        myData = [AlgosLibUtil ordinaListaDizionari:array];
    }
}

- (NSString *)getTitoloRigaSelezionata {
    NSString *titolo;
    NSInteger riga = [self.tableView indexPathForSelectedRow].row;
    NSDictionary *dict;
    
    if (myData) {
        dict = [myData objectAtIndex:riga];
        titolo = [dict objectForKey:kTitolo];
    }
    
    return titolo;
}

- (NSString *)getSottoTitoloRigaSelezionata {
    NSString *sottoTitolo;
    NSInteger riga = [self.tableView indexPathForSelectedRow].row;
    NSDictionary *dict;
    
    if (myData) {
        dict = [myData objectAtIndex:riga];
        sottoTitolo = [dict objectForKey:kSottoTitolo];
    }
    
    return sottoTitolo;
}

- (NSString *)getChiaveRigaSelezionata {
    NSString *chiave;
    NSDictionary *dict;
    NSInteger riga = [self.tableView indexPathForSelectedRow].row;
    
    if (myData) {
        dict = [myData objectAtIndex:riga];
        chiave = [dict objectForKey:kChiave];
    }
    
    return chiave;
}

- (NSString *)getTitoloFinestraRigaSelezionata {
    NSString *titolo;
    NSDictionary *dict;
    NSInteger riga = [self.tableView indexPathForSelectedRow].row;

    if (myData) {
        dict = [myData objectAtIndex:riga];
        titolo = [dict objectForKey:kTitoloFinestra];
        
        if ([titolo length] < 1) {
            titolo = [self getChiaveRigaSelezionata];
            titolo = [titolo capitalizedString];
      }
    }
    return titolo;
}

@end
