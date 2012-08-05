//
//  Operation.h
//  Calculator
//
//  Created by Uri London on 8/5/12.
//
//

#import <Foundation/Foundation.h>


enum Precedence {
    PrecAtomic = 0,
    PrecMultiply = 1,
    PrecAdd = 2,
};


struct Operation
{
    char* _name;
    int _numOperands;
    double (*_fn)();
    enum Precedence _prec;
};


@interface Operations : NSObject

+ (struct Operation*)find:(id)opname;


@end

