//
//  ViewController.m
//  CalculatorObjC
//
//  Created by Admin on 14.05.17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "ViewController.h"
#import "CopyrightViewController.h"
#import "CalculatorModel.h"

@interface ViewController ()

@property (retain, nonatomic) IBOutlet UILabel *displayLabel;
@property (assign, nonatomic) BOOL userMiddleOfTyping;
@property (retain, nonatomic) CalculatorModel *calculatorModel;

@property (retain, nonatomic) IBOutlet UIStackView *generalStackView;
@property (retain, nonatomic) IBOutlet UIStackView *allButtonsStackView;
@property (retain, nonatomic) IBOutlet UIStackView *firstTwoLinesStackView;
@property (retain, nonatomic) IBOutlet UIStackView *numberSystemStackView;

@end


@implementation ViewController

#pragma mark - constants

static NSString * const CalculatorZeroValue = @"0";
static NSString * const CalculatorDotSymbol = @".";

#pragma mark - methods

- (void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipeOnDispalyRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeRecognizer:)] ;
    swipeOnDispalyRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.displayLabel addGestureRecognizer:swipeOnDispalyRecognizer];
    [swipeOnDispalyRecognizer release];
}

- (void)handleSwipeRecognizer:(UIGestureRecognizerState *)recognizer {
    if ([self.displayLabel.text length] > 1) {
        self.displayLabel.text = [self.displayLabel.text substringToIndex:[self.displayLabel.text length] - 1];
    } else {
        self.displayLabel.text = CalculatorZeroValue;
        self.userMiddleOfTyping = NO;
    }
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        [self.firstTwoLinesStackView removeArrangedSubview:self.firstTwoLinesStackView.arrangedSubviews[0]];
        self.numberSystemStackView.axis = UILayoutConstraintAxisVertical;
        [self.generalStackView insertArrangedSubview:self.numberSystemStackView atIndex:0];
    } else {
        [self.generalStackView removeArrangedSubview:self.generalStackView.arrangedSubviews[0]];
        self.numberSystemStackView.axis = UILayoutConstraintAxisHorizontal;
        [self.firstTwoLinesStackView insertArrangedSubview:self.numberSystemStackView atIndex:0];
    }
}

- (IBAction)copyrightButtonPressed:(id)sender {
    CopyrightViewController *copyrightViewController = [[CopyrightViewController alloc] initWithNibName:@"Copyright" bundle:nil];
    copyrightViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    copyrightViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:copyrightViewController animated:YES completion:nil];
    [copyrightViewController release];
}


#pragma mark - tapping on the calc's button

- (IBAction)digitButtonPressed:(UIButton *)sender {
    if (self.userMiddleOfTyping) {
        self.displayLabel.text = [self.displayLabel.text stringByAppendingString: sender.currentTitle];
    } else {
        if (![sender.currentTitle isEqual:CalculatorZeroValue]) {
            self.userMiddleOfTyping = YES; // fix case when 0 add to 0 (00001)
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
    self.displayLabel.text = self.calculatorModel.displayResult;
}


- (CalculatorModel*)calculatorModel {
    if (!_calculatorModel) {
        _calculatorModel = [[CalculatorModel alloc] init];
    }
    return _calculatorModel;
}


- (void)dealloc {
    [_calculatorModel release];
    [_displayLabel release];
    [_generalStackView release];
    [_allButtonsStackView release];
    [_firstTwoLinesStackView release];
    [_numberSystemStackView release];
    [super dealloc];
}

@end
