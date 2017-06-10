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
@property (retain, nonatomic) NSString *numeralSystem;
@property (retain, nonatomic) IBOutlet UILabel *numeralSystemLabel;

@property (retain, nonatomic) IBOutlet UIStackView *forHexLettersButtonsStackView;
@property (retain, nonatomic) IBOutlet UIStackView *allButtonsStackView;
@property (retain, nonatomic) IBOutlet UIStackView *numeralSystemStackView;

@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;
// buttons witch should be disabled if user chose one of numeral systems (hex, oct or bin)
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *hexDisableButtons;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *octDisableButtons;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *binDisableButtons;

@end


@implementation ViewController

#pragma mark - constants

static NSString * const CalculatorZeroValue = @"0";
static NSString * const CalculatorDotSymbol = @".";


#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipeOnDispalyRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeRecognizer:)] ;
    swipeOnDispalyRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.displayLabel addGestureRecognizer:swipeOnDispalyRecognizer];
    [swipeOnDispalyRecognizer release];
    self.numeralSystemLabel.text = CalculatorDecNumeralSystem;
    self.forHexLettersButtonsStackView.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeDisplayResult) name:ResultDidChange object:nil];
}


#pragma mark - general methods

- (void)handleSwipeRecognizer:(UIGestureRecognizerState *)recognizer {
    if ([self.displayLabel.text length] > 1) {
        self.displayLabel.text = [self.displayLabel.text substringToIndex:[self.displayLabel.text length] - 1];
    } else {
        self.displayLabel.text = CalculatorZeroValue;
        self.userMiddleOfTyping = NO;
    }
}

- (IBAction)copyrightButtonPressed:(id)sender {
    CopyrightViewController *copyrightViewController = [[CopyrightViewController alloc] initWithNibName:@"Copyright" bundle:nil];
    copyrightViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    copyrightViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:copyrightViewController animated:YES completion:nil];
    [copyrightViewController release];
}


- (void)disableButtonsForNumeralSystem:(NSArray *)buttonsArray {
    [self enableAllButtons];
    for (UIButton *button in buttonsArray) {
        button.enabled = NO;
        button.alpha = 0.35;
    }
}

- (void)enableAllButtons {
    for (UIButton *button in self.allButtons) {
        button.enabled = YES;
        button.alpha = 1;
    }
    self.forHexLettersButtonsStackView.hidden = YES;
}

- (void)changeDisplayResult {
    self.displayLabel.text = self.calculatorModel.displayResult;
}

- (void)animatedHiddenOrShowStackView:(UIStackView *)stackView hide:(BOOL)hide {
    [UIView transitionWithView:stackView
                      duration:0.2
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                       stackView.hidden = hide;
                    }
                    completion:NULL];
}


#pragma mark - change rotation

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        self.allButtonsStackView.axis = UILayoutConstraintAxisHorizontal;
        self.numeralSystemStackView.axis = UILayoutConstraintAxisVertical;
        self.forHexLettersButtonsStackView.axis = UILayoutConstraintAxisVertical;
    } else {
        self.allButtonsStackView.axis = UILayoutConstraintAxisVertical;
        self.numeralSystemStackView.axis = UILayoutConstraintAxisHorizontal;
        self.forHexLettersButtonsStackView.axis = UILayoutConstraintAxisHorizontal;
    }
}


#pragma mark - tapping on the calc's button

- (IBAction)digitButtonPressed:(UIButton *)sender {
    if (self.userMiddleOfTyping) {
        self.displayLabel.text = [self.displayLabel.text stringByAppendingString: sender.currentTitle];
    } else {
        if (![sender.currentTitle isEqual:CalculatorZeroValue] || [self.numeralSystemLabel.text isEqual: CalculatorBinNumeralSystem]) { // fix case when 0 add to 0 (00001) and unfix if binary
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
    } else if ([sender.currentTitle  isEqual: CalculatorHexNumeralSystem]) {
        [self disableButtonsForNumeralSystem:self.hexDisableButtons];
        [self animatedHiddenOrShowStackView:self.forHexLettersButtonsStackView hide:NO];
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


- (void)dealloc {
    [_calculatorModel release];
    [_displayLabel release];
    [_allButtonsStackView release];
    [_numeralSystemStackView release];
    [_binDisableButtons release];
    [_allButtons release];
    [_octDisableButtons release];
    [_hexDisableButtons release];
    [_forHexLettersButtonsStackView release];
    [_numeralSystemLabel release];
    [_numeralSystem release];
    [super dealloc];
}

@end
