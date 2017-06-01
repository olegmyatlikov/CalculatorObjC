//
//  HexCalculatorDelegate.m
//  CalculatorObjC
//
//  Created by Admin on 31.05.17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "HexNumeralSystemDelegate.h"

@implementation HexNumeralSystemDelegate

- (double)convertOperandToDecimal:(NSString*)operand {
    NSScanner* pScanner = [NSScanner scannerWithString: operand];
    //[pScanner setScanLocation:1]; // bypass '#' character
    unsigned int iValue;
    [pScanner scanHexInt: &iValue];
    return (double)iValue;
}

- (NSString*)converResult:(NSString*)dispalyResult {
    return [NSString stringWithFormat:@"0x%lX",
            (unsigned long)[dispalyResult doubleValue]];
}

@end
