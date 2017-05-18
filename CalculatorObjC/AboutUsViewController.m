//
//  AboutUsViewController.m
//  CalculatorObjC
//
//  Created by Admin on 18.05.17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [[NSBundle mainBundle] loadNibNamed:@"AboutUs" owner:self options:nil];
    }
    return self;
}

@end
