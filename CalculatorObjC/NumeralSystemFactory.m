//
//  NumeralSystemFactory.m
//  CalculatorObjC
//
//  Created by Admin on 10.06.17.
//  Copyright © 2017 Oleg Myatlikov. All rights reserved.
//

#import "NumeralSystemFactory.h"
#import "CalculatorModel.h" // add for constants
#import "HexNumeralSystem.h"
#import "DecNumeralSystem.h"
#import "OctNumeralSystem.h"
#import "BinNumeralSystem.h"


@implementation NumeralSystemFactory

+ (id<NumeralSystemProtocol>)systemFromSystemName:(NSString *)systemName {
    
    if ([systemName isEqual:CalculatorBinNumeralSystem]) {
        return [[BinNumeralSystem alloc] init];
    } else if ([systemName isEqual:CalculatorOctNumeralSystem]) {
        return [[OctNumeralSystem alloc] init];
    } else if ([systemName isEqual:CalculatorHexNumeralSystem]) {
        return [[HexNumeralSystem alloc] init];
    } else {
        return [[DecNumeralSystem alloc] init];
    }
    
}

@end
