//
//  Operation.m
//  Calculator
//
//  Created by Uri London on 8/5/12.
//
//

#import "Operation.h"


double pi() { return 3.1415926; }
double e() { return 2.718281828; }
double neg(double x) { return -x; }
double add(double x, double y) { return x+y; }
double sub(double x, double y) { return x-y; }
double mul(double x, double y) { return x*y; }
double divide(double x, double y) { return x/y; }

static struct Operation _AllOperations[] = {
    { "pi", 0, pi },
    { "e", 0, e },
    { "+/-", 1, neg },
    { "sqrt", 1, sqrt },
    { "sin", 1, sin },
    { "cos", 1, cos },
    { "+", 2, add },
    { "-", 2, sub },
    { "*", 2, mul },
    { "/", 2, divide },
};
static int _num_operations = sizeof(_AllOperations)/sizeof(struct Operation);


@implementation Operations


+ (struct Operation*)find:(id)name
{
    int i;
    if( [name isKindOfClass:[NSString class]] ) {
        for( i=0; i<_num_operations; ++i ) {
            if( !strcmp( [name cString], _AllOperations[i]._name ) ) {
                return _AllOperations + i;
            }
        }
    }
    return nil;
}


@end
