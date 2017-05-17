//
//  ViewController.m
//  CalculatorObjC
//
//  Created by Admin on 14.05.17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (retain, nonatomic) IBOutlet UILabel *displayLabel;
@property (assign, nonatomic) BOOL userMiddleOfTyping;

@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeOnDispalyRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeRecognizer:)] ;
    swipeOnDispalyRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.displayLabel addGestureRecognizer:swipeOnDispalyRecognizer];
    [swipeOnDispalyRecognizer release];
}


- (IBAction)clearButtonPressed:(UIButton *)sender {
    _displayLabel.text = @"0";
    _userMiddleOfTyping = NO;
}


- (IBAction)dotButtonPressed:(UIButton *)sender {
    if (![self.displayLabel.text containsString:@"."]) {
        _displayLabel.text = [NSString stringWithFormat:@"%@.", self.displayLabel.text];
        _userMiddleOfTyping = YES;
    }
}


- (IBAction)digitButtonPressed:(UIButton *)sender {
    if (_userMiddleOfTyping) {
        _displayLabel.text = [self.displayLabel.text stringByAppendingString: sender.currentTitle];
    } else {
        _displayLabel.text = sender.currentTitle;
        if (![sender.currentTitle  isEqual: @"0"] && ![self.displayLabel.text isEqual:@"0"])  { // fix item when we try add 0 to 0
            _userMiddleOfTyping = YES;
        }
    }
}


- (void)handleSwipeRecognizer:(UIGestureRecognizerState *)recognizer {
    if ([self.displayLabel.text length] > 1) {
        _displayLabel.text = [self.displayLabel.text substringToIndex:[self.displayLabel.text length] - 1];
    } else {
        _displayLabel.text = @"0";
        _userMiddleOfTyping = NO;
    }
}



- (void)dealloc {
    [_displayLabel release];
    [super dealloc];
}

@end
