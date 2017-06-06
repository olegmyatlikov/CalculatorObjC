//
//  HexNumeralSystem.m
//  CalculatorObjC
//
//  Created by Admin on 31.05.17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "HexNumeralSystem.h"

@implementation HexNumeralSystem

- (double)convertOperandToDecimal:(NSString *)operand {
    NSScanner* pScanner = [NSScanner scannerWithString:operand];
    unsigned int iValue;
    [pScanner scanHexInt: &iValue];
    return (double)iValue;
}

- (NSString *)converResult:(NSString *)dispalyResult {
    return [NSString stringWithFormat:@"%llX", [dispalyResult longLongValue]];
}

@end
