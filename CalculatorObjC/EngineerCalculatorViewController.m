//
//  EngineerCalculatorViewController.m
//  CalculatorObjC
//
//  Created by Oleg Myatlikov on 7/9/17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "EngineerCalculatorViewController.h"
#import "CalculatorModel.h"
#import <REFrostedViewController.h>

@interface EngineerCalculatorViewController ()

@property (assign, nonatomic) BOOL userMiddleOfTyping;
@property (strong, nonatomic) CalculatorModel *calculatorModel;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

@end

@implementation EngineerCalculatorViewController

#pragma mark - constants

static NSString * const CalculatorZeroValue = @"0";
static NSString * const CalculatorDotSymbol = @".";


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipeOnDispalyRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeRecognizer:)] ;
    swipeOnDispalyRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.displayLabel addGestureRecognizer:swipeOnDispalyRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeDisplayResult) name:ResultDidChange object:nil];
    
    
#pragma mark - add operation
    
    // Add constants
    [self.calculatorModel addConstants:@"e" constantValue:M_E];
    
    // Add unary operations
    [self.calculatorModel addUnaryOperation:@"tg" operation:^double(double value) {
        return sin(value)/cos(value);
    }];
    [self.calculatorModel addUnaryOperation:@"ctg" operation:^double(double value) {
        return cos(value)/sin(value);
    }];
    [self.calculatorModel addUnaryOperation:@"log" operation:^double(double value) {
        return log(value);
    }];
    [self.calculatorModel addUnaryOperation:@"x²" operation:^double(double value) {
        return pow(value, 2.f);
    }];
    
    // Add binary operations
    [self.calculatorModel addBinaryOperation:@"xʸ" operation:^double(double firstValue, double secondValue) {
        return pow(firstValue, secondValue);
    }];
    
}


#pragma mark - methods

- (void)handleSwipeRecognizer:(UIGestureRecognizerState *)recognizer {
    if ([self.displayLabel.text length] > 1) {
        self.displayLabel.text = [self.displayLabel.text substringToIndex:[self.displayLabel.text length] - 1];
    } else {
        self.displayLabel.text = CalculatorZeroValue;
        self.userMiddleOfTyping = NO;
    }
}

- (void)changeDisplayResult {
    self.displayLabel.text = self.calculatorModel.displayResult;
}


// only landscape

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}


#pragma mark - tapping on the calc's button

- (IBAction)digitButtonPressed:(UIButton *)sender {
    if (self.userMiddleOfTyping) {
        self.displayLabel.text = [self.displayLabel.text stringByAppendingString: sender.currentTitle];
    } else {
        if (![sender.currentTitle isEqual:CalculatorZeroValue]) {
            self.userMiddleOfTyping = YES;
        }
        _displayLabel.text = sender.currentTitle;
    }
    
    self.calculatorModel.strOperand = self.displayLabel.text;
}


- (IBAction)dotButtonPressed:(UIButton *)sender {
    if (![self.displayLabel.text containsString:CalculatorDotSymbol]) {
        self.displayLabel.text = [NSString stringWithFormat:@"%@%@", self.displayLabel.text, CalculatorDotSymbol];
        self.userMiddleOfTyping = YES;
    }
}

- (IBAction)operationButtonPressed:(UIButton *)sender {
    if (self.userMiddleOfTyping) {
        self.userMiddleOfTyping = NO;
    }
    [self.calculatorModel performOperation:sender.currentTitle];
}


// Lazy getter

- (CalculatorModel *)calculatorModel {
    if (!_calculatorModel) {
        _calculatorModel = [[CalculatorModel alloc] init];
    }
    return _calculatorModel;
}


@end
