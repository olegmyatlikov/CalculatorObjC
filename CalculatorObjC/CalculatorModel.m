//
//  CalculatorModel.m
//  CalculatorObjC
//
//  Created by Admin on 20.05.17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "CalculatorModel.h"
#import "NumeralSystemFactory.h"
#import <REFrostedViewController.h>

@interface CalculatorModel()

@property (assign, nonatomic) double operand;
@property (assign, nonatomic) double accumulator;
@property (assign, nonatomic) double result;
@property (strong, nonatomic, readwrite) NSString *displayResult;

@property (assign, nonatomic) BOOL haveDeferredOperation;
@property (assign, nonatomic) BOOL haveSecondOperand;

@property (strong, nonatomic) NSDictionary *binaryOperations;
@property (strong, nonatomic) NSDictionary *unaryOperations;
@property (strong, nonatomic) NSDictionary *constants;
@property (strong, nonatomic) double (^reservedOperation)(double, double);

@property (strong, nonatomic) id <NumeralSystemProtocol> numeralSystem;

@end


@implementation CalculatorModel

#pragma mark - constants

static NSString * const CalculatorMPISymbol = @"π";
static NSString * const CalculatorZeroValue = @"0";

static NSString * const CalculatorPlusOperation = @"+";
static NSString * const CalculatorMinusOperation = @"-";
static NSString * const CalculatorMultiplyOperation = @"×";
static NSString * const CalculatorDivideOperation = @"÷";
static NSString * const CalculatorRemainderOperation = @"﹪";

static NSString * const CalculatorSqrtOperation = @"√";
static NSString * CalculatorSignChangeOperation = @"±";
static NSString * CalculatorSinOperation = @"sin";
static NSString * CalculatorCosOperation = @"cos";

static NSString * CalculatorACValue = @"AC";
static NSString * CalculatorEqualSymbol = @"=";

static NSString * CalculatorErrorMessege = @"Error";
static NSString * CalculatorInfErrorMessege = @"inf";
static NSString * CalculatorNanErrorMessege = @"nan";

NSString * const CalculatorHexNumeralSystem = @"hex";
NSString * const CalculatorOctNumeralSystem = @"oct";
NSString * const CalculatorBinNumeralSystem = @"bin";
NSString * const CalculatorDecNumeralSystem = @"dec";

NSString * const ResultDidChange = @"resultDidChange";


#pragma mark - add operation

- (void)addBinaryOperation:(NSString *)operationName operation:(double (^)(double, double))operation {
    NSMutableDictionary *binaryOperation = [self.binaryOperations mutableCopy];
    [binaryOperation setValue:operation forKey:operationName];
    self.binaryOperations = binaryOperation;
}

- (void)addUnaryOperation:(NSString *)operationName operation:(double (^)(double))operation {
    NSMutableDictionary *unaryOperation = [self.unaryOperations mutableCopy];
    [unaryOperation setValue:operation forKey:operationName];
    self.unaryOperations = unaryOperation;
}

- (void)addConstants:(NSString *)operationName constantValue:(double)constantValue {
    NSMutableDictionary *constants = [self.constants mutableCopy];
    [constants setValue:@(constantValue) forKey:operationName];
    self.constants = constants;
}


#pragma mark - custom init

- (id)init {
    self = [super init];
    if (self) {
        
        _haveDeferredOperation = NO;
        _displayResult = CalculatorZeroValue;
        _numeralSystem = [NumeralSystemFactory systemFromSystemName:CalculatorDecNumeralSystem];
        _strOperand = @"0";
        
        _binaryOperations = @{CalculatorPlusOperation : ^ double (double firstValue, double secondValue) {
            return firstValue + secondValue;
        },
                            CalculatorMinusOperation : ^ double (double firstValue, double secondValue) {
                                     return firstValue - secondValue;
                                 },
                            CalculatorMultiplyOperation : ^ double (double firstValue, double secondValue) {
                                     return firstValue * secondValue;
                                 },
                            CalculatorDivideOperation : ^ double (double firstValue, double secondValue) {
                                     return firstValue / secondValue;
                                 },
                            CalculatorRemainderOperation : ^ double (double firstValue, double secondValue) {
                                      return fmod(firstValue, secondValue);
                                  }};
        
    
        _unaryOperations = @{CalculatorSqrtOperation : ^ double (double value) {
                                     return sqrt(value);
                                 },
                            CalculatorSignChangeOperation : ^ double (double value) {
                                     return 0 - value;
                                 },
                            CalculatorSinOperation : ^ double (double value) {
                                     return sin(value);
                                 },
                            CalculatorCosOperation : ^ double (double value) {
                                     return cos(value);
                                 }};
        
        _constants = @{CalculatorMPISymbol : @M_PI};
    }
    
    return self;
}


#pragma mark - setters

- (void)setOperand:(double) operand {
    _operand = operand;
    self.result = operand;
    self.haveSecondOperand = YES;
}

- (void)setStrOperand:(NSString *)strOperand { 
    _strOperand = [strOperand copy];
    self.operand = [self.numeralSystem convertOperandToDecimal:self.strOperand];
}

- (void)setResult:(double)result {
    _result = result;
}

-(void)setNumeralSystem:(id<NumeralSystemProtocol>)numeralSystem {
    _numeralSystem = numeralSystem;
    self.displayResult = [self.numeralSystem converResult:[NSString stringWithFormat:@"%g", self.result]];
}

- (void)setDisplayResult:(NSString *)displayResult {
    _displayResult = displayResult;
    [[NSNotificationCenter defaultCenter] postNotificationName:ResultDidChange object:nil];
}


#pragma mark - methods

- (void)calcIfItPostponedOperation {
    self.result = self.reservedOperation(self.accumulator, self.operand);
    self.haveDeferredOperation = NO;
}

- (void)checkErrors {
    if ([self.displayResult isEqualToString:CalculatorInfErrorMessege] || [self.displayResult isEqualToString:CalculatorNanErrorMessege]) {
        self.displayResult = CalculatorErrorMessege;
        self.accumulator = 0;
        self.reservedOperation = nil;
        self.haveDeferredOperation = NO;
        _result = 0; // fix case "Error + 1"
    }
}

- (void)applyNumeralSystemByName:(NSString *)nameNumeralSystem {
    self.numeralSystem = [NumeralSystemFactory systemFromSystemName:nameNumeralSystem];
}

- (void)performOperation:(NSString *)operation {
    
    if (self.binaryOperations[operation]) {
        if (self.haveDeferredOperation && self.haveSecondOperand) {
            [self calcIfItPostponedOperation];
        }
        self.reservedOperation = [self.binaryOperations objectForKey:operation];
        self.accumulator = self.result;
        self.haveDeferredOperation = YES;
        self.haveSecondOperand = NO;

    } else if (self.unaryOperations[operation]) {
        double (^unaryOperation)(double) = [self.unaryOperations objectForKey:operation];
        self.operand = unaryOperation(self.result);

    } else if (self.constants[operation]) {
        self.operand = [[self.constants objectForKey:operation] doubleValue];
        
    } else if ([operation isEqualToString:CalculatorEqualSymbol]) {
        if (self.reservedOperation) {
            [self calcIfItPostponedOperation];
            self.accumulator = self.result;
        }

    } else if ([operation isEqualToString:CalculatorACValue]) {
        self.accumulator = 0;
        self.operand = 0;
        self.reservedOperation = nil;
        self.haveDeferredOperation = NO;
    }
    
    self.displayResult = [self.numeralSystem converResult:[NSString stringWithFormat:@"%g", self.result]];
    [self checkErrors];
    
}

@end
