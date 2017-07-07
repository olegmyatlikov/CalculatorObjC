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
extern NSString * const ResultDidChange;

@protocol NumeralSystemProtocol;


@interface CalculatorModel : NSObject

@property (strong, nonatomic) NSString *strOperand; // add becouse HEX have a litteral "ABCDEF"
@property (strong, nonatomic, readonly) NSString *displayResult;

- (void)performOperation:(NSString *)operation;
- (void)applyNumeralSystemByName:(NSString *)nameNumeralSystem;

@end

