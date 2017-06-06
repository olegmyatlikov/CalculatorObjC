//
//  BinNumeralSystem.m
//  CalculatorObjC
//
//  Created by Admin on 31.05.17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "BinNumeralSystem.h"

@implementation BinNumeralSystem

- (double)convertOperandToDecimal:(NSString *)operand {
    long decLongOperand;
    decLongOperand = strtol(operand.UTF8String, nil, 2);
    return (double)decLongOperand;
}

- (NSString *)converResult:(NSString *)dispalyResult {
    
    NSInteger value = dispalyResult.integerValue;
    NSMutableString *resultString = [NSMutableString string];
    while (value)
    {
        [resultString insertString:(value & 1)? @"1": @"0" atIndex:0];
        value /= 2;
    }
    
    return resultString;
}

@end
