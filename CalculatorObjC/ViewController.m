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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)clearButton:(UIButton *)sender {
    _display.text = @"0";
}


- (IBAction)digitButton:(UIButton *)sender {
    
    /*NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 20;
    NSString *number = [formatter stringFromNumber:@1.];
    NSNumber* number = [[[NSNumber alloc] init] autorelease];
    number = [NSString stringWithFormat:@"%f", [result doubleValue]];
    */
    
    NSString* result = [[[NSString alloc] init] autorelease];
    result = [NSString stringWithFormat:@"%@", _display.text];
    result = [result stringByAppendingString: sender.titleLabel.text];
    _display.text = [NSString stringWithFormat: @"%ld", (long)[result integerValue]];
    //NSLog(@"%f", [formatter stringFromNumber: number]);
}




- (void)dealloc {
    [_display release];
    [super dealloc];
}
@end
