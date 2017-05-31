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

@end

@implementation CopyrightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.popUpCopyrightView.layer.cornerRadius = 5;
}

- (IBAction)closeButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc {
    [_popUpCopyrightView release];
    [super dealloc];
}
@end
