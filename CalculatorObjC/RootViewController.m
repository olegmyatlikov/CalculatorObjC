//
//  RootViewController.m
//  CalculatorObjC
//
//  Created by Oleg Myatlikov on 9/18/17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
}

@end
