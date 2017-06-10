//
//  HexNumeralSystem.h
//  CalculatorObjC
//
//  Created by Admin on 31.05.17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumeralSystemFactory.h"

@interface HexNumeralSystem : NSObject <NumeralSystemProtocol>

- (double)convertOperandToDecimal:(NSString *)operand;
- (NSString *)converResult:(NSString *)dispalyResult;

@end
