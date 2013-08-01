//
//  OpzioniController.m
//  118codes
//
//  Created by Guido Ceresa on 16-12-12.
//  Copyright (c) 2012 Alessandro Valbonesi. All rights reserved.
//

#import "OpzioniController.h"

@interface OpzioniController ()

@end

@implementation OpzioniController

#pragma mark - Constants
//--Nome del campo chiave interno al NSDictionary
static NSString *kNomeParametro = @"nomeParametro";

//--Nome del campo chiave interno al NSDictionary
static NSString *kValoreParametro = @"valoreParametro";

//--Nome del campo chiave interno al NSDictionary
static NSString *kValoriParametriOpzione = @"valoriParametriOpzione";

//--Nome della chiave equivalente al filePList
static NSString *kGlagow = @"glasgow";
static NSString *kGlagowPed = @"glasgowped";
static NSString *kChest = @"chest";
static NSString *kCincinnati = @"cincinnati";


- (UIView *)footerViewCompletaForFile:chiave {
    UIView *localFooterView;

    if ([chiave isEqualToString:kGlagow]) {
        localFooterView = [self footerViewGlagow];
    }
    if ([chiave isEqualToString:kGlagowPed]) {
        localFooterView = [self footerViewGlagow];
    }
    if ([chiave isEqualToString:kChest]) {
        localFooterView = [self footerViewChest];
    }

    if ([chiave isEqualToString:kCincinnati]) {
        localFooterView = [self footerViewCincinnati];
    }

    return localFooterView;
}

//--EVM occhi, verbale, motoria
- (UIView *)footerViewGlagow {
    UIView *localFooterView;
    NSString *testo;
    NSString *dettaglio;
    UIColor *colore;
    UIFont *font = [UIFont boldSystemFontOfSize:24];
    int valoreOcchi = [self getValoreOcchi];
    int valoreVerbale = [self getValoreVerbale];
    int valoreMotoria = [self getValoreMotoria];
    int valore = [super getValoreOpzioni];
    
    if (valore < 9) {
        colore = [UIColor redColor];
    } else {
        if (valore < 13) {
            colore = [UIColor yellowColor];
        } else {
            colore = [UIColor greenColor];
        }
    }
    testo = [NSString stringWithFormat:@"GCS = %d", valore];;
    dettaglio = [NSString stringWithFormat:@"E%d V%d M%d", valoreOcchi, valoreVerbale, valoreMotoria];
    
    localFooterView = [super footerViewWithTesto:testo colore:colore font:font dettaglio:dettaglio];
    
    return localFooterView;
}

- (UIView *)footerViewChest {
    UIView *localFooterView;
    NSString *testo;
    NSString *dettaglio;
    UIColor *colore;
    UIFont *font = [UIFont boldSystemFontOfSize:24];
    int valore = [super getValoreOpzioni];

    if (valore < 4) {
        testo = [NSString stringWithFormat:@"Dolore ATIPICO"];
        dettaglio = [NSString stringWithFormat:@"score = %d: bassa probabilità di angina", valore];
        colore = [UIColor yellowColor];
    } else {
        testo = [NSString stringWithFormat:@"Dolore TIPICO"];;
        dettaglio = [NSString stringWithFormat:@"score = %d: alta probabilità di angina", valore];
        colore = [UIColor redColor];
    }
    
    localFooterView = [super footerViewWithTesto:testo colore:colore font:font dettaglio:dettaglio];
    
    return localFooterView;
}


- (UIView *)footerViewCincinnati {
    UIView *localFooterView;
    NSString *testo;
    NSString *dettaglio;
    UIColor *colore;
    UIFont *font = [UIFont boldSystemFontOfSize:24];
    int valore = [super getValoreOpzioni];
    
    if (valore == 0) {
        testo = [NSString stringWithFormat:@"Cincinnati positiva"];
        colore = [UIColor greenColor];
    } else {
        testo = [NSString stringWithFormat:@"Cincinnati negativa"];;
        colore = [UIColor yellowColor];
    }
    
    localFooterView = [super footerViewWithTesto:testo colore:colore font:font dettaglio:dettaglio];
    
    return localFooterView;
}

#pragma mark - Utility methods
//--Recupera il valore del parametro apertura degli occhi
//--Solo per la scala Glasgow
- (int)getValoreOcchi {
    return [super getValoreForOpzione:0];
}

//--Recupera il valore del parametro risposta verbale
//--Solo per la scala Glasgow
- (int)getValoreVerbale {
    return [super getValoreForOpzione:1];
}

//--Recupera il valore del parametro risposta motoria
//--Solo per la scala Glasgow
- (int)getValoreMotoria {
    return [super getValoreForOpzione:2];
}


////--Recupera il valore di un parametro
////--Solo per la scala Glasgow
//- (int)getValoreForOpzione:(int)posOpzione {
//    int valore = 0;
//    NSString *valoreOpzione;
//    NSDictionary *dictOpzione;
//    NSDictionary *dictParametri;
//    NSArray *arrayParametri;
//    NSString *nomeParametro;
//    
//    valoreOpzione = [super.testoOpzioni objectAtIndex:posOpzione];
//    if ([super.parametri objectForKey:[super.opzioni objectAtIndex:posOpzione]]) {
//        dictOpzione = [super.parametri objectForKey:[super.opzioni objectAtIndex:posOpzione]];
//        if ([dictOpzione objectForKey:kValoriParametriOpzione]) {
//            arrayParametri = [dictOpzione objectForKey:kValoriParametriOpzione];
//            for (dictParametri in arrayParametri) {
//                if ([dictParametri objectForKey:kNomeParametro]) {
//                    nomeParametro = [dictParametri objectForKey:kNomeParametro];
//                    if ([nomeParametro isEqualToString:valoreOpzione]) {
//                        valore = [[dictParametri objectForKey:kValoreParametro] intValue];
//                    }
//                }
//            }
//        }
//    }
//    return valore;
//}

//#pragma mark - Constants
////--Nome del campo chiave interno al NSDictionary
//static NSString *kDescrizioneOp = @"descrizioneProtocollo";
//
////--Nome del campo chiave interno al NSDictionary
//static NSString *kValoriOp = @"valoriOpzioniProtocollo";
//
////--Nome del campo chiave interno al NSDictionary
//static NSString *kOpzione = @"nomeOpzione";
//
////--Nome del campo chiave interno al NSDictionary
//static NSString *kParametri = @"valoriParametriOpzione";
//
//#pragma mark - Init View
//- (void)viewDidLoad {
//    [super viewDidLoad];
//}
//
//
//
//#pragma mark - Table view group section
////--Return the number of sections.
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
////--Return the number of rows in the section.
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
//}
//
//
//#pragma mark - Table view sections header
//#pragma mark - Table view sections footer
////--Regola l'altezza della sezione footer. Se non usa il footer, viene messa a zero
//- (CGFloat)tableView2:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    //differ between your sections or if you
//    //have only on section return a static value
//    if (usaFooter) {
//        return 24;
//    } else {
//        return 0;
//    }
//}
//
//
//#pragma mark - Table view data source
////--chiamata dal sistema ogni volta che deve disegnare una riga
////--la PrototypeCell dello storyboard è vuota
////--la label viene creata qui nel codice
////--la chiave per recuperare la cella dallo storyboard DEVE essere "label"
//- (UITableViewCell *)tableView2:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
//
////--chiamata dal sistema ogni volta che deve disegnare una riga
////--utilizza (tramite delega) lo stesso metodo usato per dimensionare la label della cella
////--calcola l'altezza esatta della label che contiene il testo
//-(CGFloat)tableView2:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 76;
//}
//
//#pragma mark - Utility methods
////--Recupera la descrizione della scheda dalla pList--
////--regola la variabile d'istanza--
//- (void)setUpDescrizione {
//    NSDictionary *dictRoot = [super getDictionary];
//    NSString *descrizione;
//    
//    if (dictRoot) {
//        descrizione = [dictRoot objectForKey:kDescrizioneOp];
//    }
//    [self setTestoHeader:descrizione];
//}
//
////--Recupera i nomeOpzione da ogni dizionario dell'array
////--Utilizzato solo dalla sottoclasse ATableOpzioni
////--Presuppone che lo schema della pList sia costituito da:
////--n dizionari (opzioni), contenuti nell'array valoriOpzioniProtocollo
////--ognuno contiene un array con n dizionari (parametri) 
////--L'ordine è garantito
//- (void)setUpSezioni {
//    NSMutableArray *arrayTmp = [[NSMutableArray alloc] init];;
//    NSDictionary *dictRoot = [super getDictionary];
//    NSArray *arrayValori;
//    NSObject *obj;
//    NSDictionary *dictOpzione;
//    NSString *nomeSezione;
//
//    if (dictRoot) {
//        arrayValori = [dictRoot objectForKey:kValoriOp];
//        if (arrayValori) {
//            for (obj in arrayValori) {
//                if ([obj isKindOfClass:[NSDictionary class]]) {
//                    dictOpzione = (NSDictionary *)obj;
//                    if ([dictOpzione objectForKey:kOpzione]) {
//                        nomeSezione = [dictOpzione objectForKey:kOpzione];
//                        [arrayTmp addObject:nomeSezione];
//                    }
//                }
//            }
//        }
//    }
//    super.opzioni = arrayTmp;
//}
//
//
////--Recupera i nomeParametro da ogni dizionario dell'array
////--Utilizzato solo dalla sottoclasse ATableOpzioni
////--Presuppone che lo schema della pList sia costituito da:
////--n dizionari (opzioni), contenuti nell'array valoriOpzioniProtocollo
////--ognuno contiene un array con n dizionari (parametri)
////--L'ordine è garantito
//- (void)setUpParametri {
//    NSDictionary *dictRoot = [super getDictionary];
//    NSArray *arrayValori;
//    NSObject *obj;
//    NSMutableDictionary *tempParametri = [NSMutableDictionary dictionary];
//    NSDictionary *dictOpzione;
//    NSDictionary *dictParametri;
//    
//    arrayValori = [dictRoot objectForKey:kValoriOp];
//    
//    if (arrayValori) {
//        for (obj in arrayValori) {
//            if ([obj isKindOfClass:[NSDictionary class]]) {
//                dictOpzione = (NSDictionary *)obj;
//                if ([dictOpzione objectForKey:kParametri]) {
//                    dictParametri = [dictOpzione objectForKey:kParametri];
//                   [tempParametri setObject:dictParametri forKey:[dictOpzione objectForKey:kOpzione]];
//                }
//            }
//        }
//    }
//    super.parametri = tempParametri;
//}
//
@end
