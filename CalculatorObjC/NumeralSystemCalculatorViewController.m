//
//  NumeralSystemCalculatorViewController.m
//  CalculatorObjC
//
//  Created by Oleg Myatlikov on 7/9/17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "NumeralSystemCalculatorViewController.h"
#import "CalculatorModel.h"

@interface NumeralSystemCalculatorViewController ()

@property (assign, nonatomic) BOOL userMiddleOfTyping;
@property (strong, nonatomic) CalculatorModel *calculatorModel;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (weak, nonatomic) IBOutlet UILabel *numeralSystemLabel;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *octDisableButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *binDisableButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *decDisableButtons;

@end

@implementation NumeralSystemCalculatorViewController

#pragma mark - constants

static NSString * const CalculatorZeroValue = @"0";
static NSString * const CalculatorDotSymbol = @".";


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipeOnDispalyRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeRecognizer:)] ;
    swipeOnDispalyRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.displayLabel addGestureRecognizer:swipeOnDispalyRecognizer];
    
    self.numeralSystemLabel.text = CalculatorDecNumeralSystem;
    [self disableButtonsForNumeralSystem:self.decDisableButtons];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeDisplayResult) name:ResultDidChange object:nil];
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

- (BOOL)shouldAutorotate {
    return NO; // no rotait simple calcultor
}

- (void)disableButtonsForNumeralSystem:(NSArray *)buttonsArray {
    [self enableAllButtons];
    for (UIButton *button in buttonsArray) {
        button.enabled = NO;
        button.alpha = 0.85;
    }
}

- (void)enableAllButtons {
    for (UIButton *button in self.allButtons) {
        button.enabled = YES;
        button.alpha = 1;
    }
    //self.forHexLettersButtonsStackView.hidden = YES;
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

- (IBAction)numeralSystemButtonPressed:(UIButton *)sender {
    
    if ([sender.currentTitle  isEqual: CalculatorBinNumeralSystem]) {
        [self disableButtonsForNumeralSystem:self.binDisableButtons];
    } else if ([sender.currentTitle  isEqual: CalculatorOctNumeralSystem]) {
        [self disableButtonsForNumeralSystem:self.octDisableButtons];
    } else if ([sender.currentTitle  isEqual: CalculatorDecNumeralSystem]) {
        [self disableButtonsForNumeralSystem:self.decDisableButtons];
    } else {
        [self enableAllButtons];
    }
    
    self.numeralSystemLabel.text = sender.currentTitle;
    [self.calculatorModel applyNumeralSystemByName:sender.currentTitle];
}

// Lazy getter

- (CalculatorModel *)calculatorModel {
    if (!_calculatorModel) {
        _calculatorModel = [[CalculatorModel alloc] init];
    }
    return _calculatorModel;
}


@end
