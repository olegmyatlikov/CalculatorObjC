//
//  OctNumeralSystem.m
//  CalculatorObjC
//
//  Created by Admin on 31.05.17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "OctNumeralSystem.h"

@implementation OctNumeralSystem

- (double)convertOperandToDecimal:(NSString *)operand {
    int intOperand = [operand intValue];
    NSString *octalString = [NSString stringWithFormat:@"%o", intOperand];
    return octalString.doubleValue;
}

- (NSString *)converResult:(NSString *)dispalyResult {
    long octLongResult;
    octLongResult = strtol(dispalyResult.UTF8String, nil, 8);
    return [NSString stringWithFormat:@"%ld", octLongResult];
}

@end
