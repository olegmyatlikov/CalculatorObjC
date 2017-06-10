//
//  NumeralSystemFactory.h
//  CalculatorObjC
//
//  Created by Admin on 10.06.17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NumeralSystemProtocol;


@interface NumeralSystemFactory : NSObject

+ (id<NumeralSystemProtocol>)systemFromSystemName:(NSString *)systemName;

@end

@protocol NumeralSystemProtocol <NSObject>

- (double)convertOperandToDecimal:(NSString*)operand;
- (NSString*)converResult:(NSString*)dispalyResult;

@end
