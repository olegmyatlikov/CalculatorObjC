//
//  CalculatorModel.h
//  CalculatorObjC
//
//  Created by Admin on 20.05.17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const CalculatorHexNumeralSystem;
extern NSString * const CalculatorOctNumeralSystem;
extern NSString * const CalculatorBinNumeralSystem;
extern NSString * const CalculatorDecNumeralSystem;


@protocol NumeralSystemProtocol;


@interface CalculatorModel : NSObject

@property (retain, nonatomic) NSString *strOperand; // add becouse HEX have a litteral "ABCDEF"
@property (retain, nonatomic, readonly) NSString *displayResult;

- (void)performOperation:(NSString *)operation;
- (void)applyNumeralSystemByName:(NSString *)nameNumeralSystem;

@end


@protocol NumeralSystemProtocol <NSObject>

- (double)convertOperandToDecimal:(NSString*)operand;
- (NSString*)converResult:(NSString*)dispalyResult;

@end
