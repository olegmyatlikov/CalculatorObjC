//
//  DecNumeralSystemDelegate.m
//  CalculatorObjC
//
//  Created by Admin on 31.05.17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "DecNumeralSystemDelegate.h"

@implementation DecNumeralSystemDelegate

- (double)convertOperandToDecimal:(NSString*)operand {
    return operand.doubleValue;
}

- (NSString*)converResult:(NSString*)dispalyResult {
    return dispalyResult;
}

@end
