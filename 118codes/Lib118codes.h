//
//  Lib118codes.h
//  118codes
//
//  Created by Guido Ceresa on 14-12-12.
//  Copyright (c) 2012 Alessandro Valbonesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lib118codes : NSObject

//--Array di stringhe coi nomi delle categorie contenute nell'omonimo campo (key) del dizionario
//--Capitalizzate per la prima lettera
//--Ordinate alfabeticamente
+ (NSArray *)listaCategorieFromDizionario:(NSDictionary *)dict;

//--Array di tutti i dizionari che hanno la categoria indicata nel campo chiave ''categorie'
+ (NSArray *)listaAllDizionariFromDizionario:(NSDictionary *)dict withCategorie:(NSString *)categoria;

//--Array dei dizionari che hanno la categoria indicata nel campo chiave ''categorie' ed il flag 'visibile' attivo
+ (NSArray *)listaDizionariVisibiliFromDizionario:(NSDictionary *)dict withCategorie:(NSString *)categoria;

@end
