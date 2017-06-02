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
extern NSString *const CalculatorBinNumeralSystem;


@protocol CalculatorModelDelegate;


@interface CalculatorModel : NSObject

@property (retain, nonatomic) NSString *strOperand;
@property (retain, nonatomic, readonly) NSString *displayResult;
@property (retain, nonatomic) NSString *numeralSystem;
@property (assign, nonatomic) id <CalculatorModelDelegate> delegate;

- (void)performOperation:(NSString *)operation;

@end


@protocol CalculatorModelDelegate <NSObject>

- (double)convertOperandToDecimal:(NSString*)operand;
- (NSString*)converResult:(NSString*)dispalyResult;

@end
