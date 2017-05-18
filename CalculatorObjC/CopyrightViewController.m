//
//  CopyrightViewController.m
//  CalculatorObjC
//
//  Created by Admin on 18.05.17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "CopyrightViewController.h"

@interface CopyrightViewController ()
@property (retain, nonatomic) IBOutlet UIView *popUpCopyrightView;
@property (retain, nonatomic) IBOutlet UITextView *copyrightTextView;

@end

@implementation CopyrightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _popUpCopyrightView.layer.cornerRadius = 10;
    _copyrightTextView.layer.cornerRadius = 5;
}

- (IBAction)closeButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc {
    [_popUpCopyrightView release];
    [_copyrightTextView release];
    [super dealloc];
}
@end
