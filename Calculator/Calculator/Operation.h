//
//  Operation.h
//  Calculator
//
//  Created by Uri London on 8/5/12.
//
//

#import <Foundation/Foundation.h>


struct Operation
{
    char* _name;
    int _numOperands;
    double (*_fn)();
};


@interface Operations : NSObject

+ (struct Operation*)find:(id)opname;


@end

