//
//  CalculatorModel.m
//  CalculatorObjC
//
//  Created by Admin on 20.05.17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "CalculatorModel.h"
#import "HexNumeralSystem.h"
#import "DecNumeralSystem.h"
#import "OctNumeralSystem.h"
#import "BinNumeralSystem.h"

@interface CalculatorModel()

@property (assign, nonatomic) double operand;
@property (assign, nonatomic) double accumulator;
@property (assign, nonatomic) double result;
@property (retain, nonatomic, readwrite) NSString *displayResult;

@property (assign, nonatomic) BOOL haveDeferredOperation;
@property (assign, nonatomic) BOOL haveSecondOperand;

@property (retain, nonatomic) NSDictionary *binaryOperations;
@property (retain, nonatomic) NSDictionary *unaryOperations;
@property (retain, nonatomic) NSDictionary *constants;
@property (copy, nonatomic) double (^reservedOperation)(double, double);

@property (retain, nonatomic) id <NumeralSystemProtocol> numeralSystem;
@property (retain, nonatomic) DecNumeralSystem *decNumeralSystem;
@property (retain, nonatomic) BinNumeralSystem *binNumeralSystem;
@property (retain, nonatomic) OctNumeralSystem *octNumeralSystem;
@property (retain, nonatomic) HexNumeralSystem *hexNumeralSystem;

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

#pragma mark - custom init

- (id)init {
    self = [super init];
    if (self) {
        
        _haveDeferredOperation = NO;
        _displayResult = CalculatorZeroValue;
        _numeralSystem = [self.decNumeralSystem retain];
        _strOperand = @"0";
        
        _binaryOperations = [@{CalculatorPlusOperation : ^ double (double firstValue, double secondValue) {
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
                                  }} retain];
        
    
        _unaryOperations = [@{CalculatorSqrtOperation : ^ double (double value) {
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
                                 }} retain];
        
        _constants = [@{CalculatorMPISymbol : @M_PI} retain];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resultDidChange" object:nil];
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
    if ([nameNumeralSystem isEqual:CalculatorBinNumeralSystem]) {
        self.numeralSystem = self.binNumeralSystem;
    } else if ([nameNumeralSystem isEqual:CalculatorOctNumeralSystem]) {
        self.numeralSystem = self.octNumeralSystem;
    } else if ([nameNumeralSystem isEqual:CalculatorHexNumeralSystem]) {
        self.numeralSystem = self.hexNumeralSystem;
    } else {
        self.numeralSystem = self.decNumeralSystem;
    }
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


#pragma mark - lazy getters for numeral systems

- (DecNumeralSystem *)decNumeralSystem {
    if (!_decNumeralSystem) {
        _decNumeralSystem = [[DecNumeralSystem alloc] init];
    }
    return _decNumeralSystem;
}

- (BinNumeralSystem *)binNumeralSystem {
    if (!_binNumeralSystem) {
        _binNumeralSystem = [[BinNumeralSystem alloc] init];
    }
    return _binNumeralSystem;
}

- (OctNumeralSystem *)octNumeralSystem {
    if (!_octNumeralSystem) {
        _octNumeralSystem = [[OctNumeralSystem alloc] init];
    }
    return _octNumeralSystem;
}

- (HexNumeralSystem *)hexNumeralSystem {
    if (!_hexNumeralSystem) {
        _hexNumeralSystem = [[HexNumeralSystem alloc] init];
    }
    return _hexNumeralSystem;
}


#pragma mark - dealloc

- (void)dealloc {
    [_displayResult release];
    [_binaryOperations release];
    [_unaryOperations release];
    [_constants release];
    [_reservedOperation release];
    [_strOperand release];
    [_numeralSystem release];
    [_decNumeralSystem release];
    [_binNumeralSystem release];
    [_octNumeralSystem release];
    [_hexNumeralSystem release];
    [super dealloc];
}

@end
