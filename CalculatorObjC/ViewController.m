//
//  ViewController.m
//  CalculatorObjC
//
//  Created by Admin on 14.05.17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (retain, nonatomic) IBOutlet UILabel *display;
@property (assign, nonatomic) BOOL userMiddleOfTyping;

@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeDellLastNumOnDisplay = [[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeOnDisplay:)] autorelease];
    swipeDellLastNumOnDisplay.direction = UISwipeGestureRecognizerDirectionRight;
    [self.display addGestureRecognizer:swipeDellLastNumOnDisplay];
}


- (IBAction)clearButton:(UIButton *)sender {
    _display.text = @"0";
    _userMiddleOfTyping = NO;
}


- (IBAction)dotButton:(UIButton *)sender {
    if (![_display.text containsString:@"."]) {
        _display.text = [NSString stringWithFormat:@"%@.", _display.text];
        _userMiddleOfTyping = YES;
    }
}


- (IBAction)digitButton:(UIButton *)sender {
    NSString *result = [[[NSString alloc] init] autorelease];
    if (_userMiddleOfTyping) {
        result = [NSString stringWithFormat:@"%@", _display.text];
        result = [result stringByAppendingString: sender.titleLabel.text];
    } else {
        result = [NSString stringWithFormat:@"%@", sender.titleLabel.text];
    }
    _display.text = [NSString stringWithFormat: @"%@", result];
    _userMiddleOfTyping = YES;
}


- (void)swipeOnDisplay:(UIGestureRecognizerState *)recognizer {
    NSString *result = [[[NSString alloc] init] autorelease];
    result = [NSString stringWithFormat:@"%@", _display.text];
    if ([result length] > 1) {
        result = [result substringToIndex:[result length] - 1];
    } else {
        result = @"0";
        _userMiddleOfTyping = NO;
    }
    _display.text = result;
}



- (void)dealloc {
    [_display release];
    [super dealloc];
}

@end
