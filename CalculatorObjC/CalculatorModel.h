//
//  CalculatorModel.h
//  CalculatorObjC
//
//  Created by Admin on 20.05.17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorModel : NSObject

@property (assign, nonatomic) double operand;
@property (retain, nonatomic, readonly) NSString *displayResult;

- (void)performOperation:(NSString *)operation;

@end
