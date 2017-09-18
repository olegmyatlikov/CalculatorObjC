//
//  MainNavigationViewController.m
//  CalculatorObjC
//
//  Created by Oleg Myatlikov on 9/18/17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "MainNavigationViewController.h"
#import <REFrostedViewController.h>

@interface MainNavigationViewController ()

@end

@implementation MainNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
}

@end
