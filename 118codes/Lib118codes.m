//
//  Lib118codes.m
//  118codes
//
//  Created by Guido Ceresa on 14-12-12.
//  Copyright (c) 2012 Alessandro Valbonesi. All rights reserved.
//

#import "Lib118codes.h"
#import "AlgosLibUtil.h"

@implementation Lib118codes

//--Nome del campo chiave interno al NSDictionary
static NSString *kVisibile = @"visibile";

//--Array di stringhe coi nomi delle categorie contenute nell'omonimo campo (key) del dizionario
//--Capitalizzate per la prima lettera
//--Ordinate alfabeticamente
+ (NSArray *)listaCategorieFromDizionario:(NSDictionary *)dict {
    NSArray *listaCategorie;
    static NSString *kCategorie = @"categorie"; //--Nome del campo chiave interno al NSDictionary
    NSArray *listaCategorieGrezza;
    NSMutableArray *listaCategorieTmp = [[NSMutableArray alloc] init];
    NSString *nomiCategorie;
    NSString *categoria;
    
    nomiCategorie = [dict objectForKey:kCategorie];
    if ([nomiCategorie length] > 0) {
        listaCategorieGrezza = [nomiCategorie componentsSeparatedByString: @","];
        if (listaCategorieGrezza) {
            for (NSString *cat in listaCategorieGrezza) {
                categoria = [cat stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                categoria = [categoria capitalizedString];
                [listaCategorieTmp addObject:categoria];
            }
        }
        listaCategorie = [listaCategorieTmp sortedArrayUsingSelector:@selector(compare:)];
    }
    return listaCategorie;
}

//--Array di dizionari che hanno la categoria indicata nel campo chiave ''categorie'
+ (NSArray *)listaAllDizionariFromDizionario:(NSDictionary *)dict withCategorie:(NSString *)categoria {
    NSArray *listaDizionari;
    NSMutableArray *listaDizionariTmp = [[NSMutableArray alloc] init];
    NSDictionary *dictProtocollo;
    NSArray *listaCategorie;
    
    if (dict) {
        for (NSString *key in [dict allKeys]) {
            dictProtocollo = [dict objectForKey:key];
            listaCategorie = [Lib118codes listaCategorieFromDizionario:dictProtocollo];
            if ([listaCategorie containsObject:categoria]) {
                [listaDizionariTmp addObject:dictProtocollo];
            }
        }
        listaDizionari = listaDizionariTmp;
    }
    return listaDizionari;
}


//--Array dei dizionari che hanno la categoria indicata nel campo chiave ''categorie' ed il flag 'visibile' attivo
+ (NSArray *)listaDizionariVisibiliFromDizionario:(NSDictionary *)dict withCategorie:(NSString *)categoria {
    NSArray *listaDizionari;
    NSMutableArray *listaDizionariTmp = [[NSMutableArray alloc] init];
    NSDictionary *dictProtocollo;
    NSArray *listaCategorie;
    
    if (dict) {
        for (NSString *key in [dict allKeys]) {
            dictProtocollo = [dict objectForKey:key];
            if ([AlgosLibUtil boolValueFromDict:dictProtocollo forKey:kVisibile]) {
                listaCategorie = [Lib118codes listaCategorieFromDizionario:dictProtocollo];
                if ([listaCategorie containsObject:categoria]) {
                    [listaDizionariTmp addObject:dictProtocollo];
                }
            }
        }
        listaDizionari = listaDizionariTmp;
    }
    return listaDizionari;

}

// Sorts an array of strings
- (NSArray *)sortStringArray:(NSArray *)array {
    NSMutableArray *arrayTmp = [[NSMutableArray alloc] initWithArray:array];
    [arrayTmp sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    return arrayTmp;
}

@end
