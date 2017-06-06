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
    return strtol(operand.UTF8String, nil, 8);
}

- (NSString *)converResult:(NSString *)dispalyResult {
    int octResultInInt = [dispalyResult intValue];
    return [NSString stringWithFormat:@"%o", octResultInInt];
}

@end
