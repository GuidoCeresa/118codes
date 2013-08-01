//
//  ColorataController.m
//  118codes
//
//  Created by Guido Ceresa on 25-12-12.
//  Copyright (c) 2012 Alessandro Valbonesi. All rights reserved.
//

#import "ColorataController.h"

@interface ColorataController ()

@end

@implementation ColorataController


#pragma mark - Init View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //--regolazioni varie iniziali--
}

#pragma mark - Table view data source
//--Insert individual row into the table view--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    int riga = indexPath.row;
    NSObject *obj;
    NSDictionary *dict;
    NSString *kDescrizione = @"descrizioneValore";
    NSString *kValoreColore = @"valoreColore";
    NSString *descrizione;
    NSString *valoreColore;
    int valore;
    UIColor *colore;
    
    @try {
        cell = [tableView dequeueReusableCellWithIdentifier:@"colorataCell" forIndexPath:indexPath];
	}
    @catch (NSException* ex) {
    }
    
    // Configure the cell...
    if (cell) {
        obj = [myData objectAtIndex:riga];
        
        if ([obj isKindOfClass:[NSString class]]) {
            descrizione = [myData objectAtIndex:riga];
        }

        if ([obj isKindOfClass:[NSDictionary class]]) {
            dict = (NSDictionary *)obj;
            if ([dict objectForKey:kDescrizione]) {
                descrizione = [dict objectForKey:kDescrizione];
            }
            if ([dict objectForKey:kValoreColore]) {
                valoreColore = [dict objectForKey:kValoreColore];
                valore = [self hexToInteger:valoreColore];
                colore = [self colorFromRGB:valore];
            }
            if (colore) {
                cell.textLabel.backgroundColor = [UIColor clearColor];
                cell.detailTextLabel.backgroundColor = [UIColor clearColor];
//                cell.contentView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.00f];
                cell.contentView.backgroundColor = colore;
                
            }
            
            //--inversione colore del testo
           // if (green < 0.5 && blue < 0.5) {
           //     cell.textLabel.textColor = [UIColor whiteColor];
           // }
        }
        cell.textLabel.text = descrizione;
    }
    
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (UIColor *)colorFromRGB:(int)rgbValue {
    
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

//
//convert or parse hex value stored in string to integer value
- (unsigned int) hexToInteger:(NSString*)HexVal
{
    unsigned int decVal = 0 ;
    NSScanner* scan = [NSScanner scannerWithString:HexVal];
    [scan scanHexInt:&decVal];
    scan = nil;
    return decVal;
}

@end
