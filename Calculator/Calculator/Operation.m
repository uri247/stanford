//
//  Operation.m
//  Calculator
//
//  Created by Uri London on 8/5/12.
//
//

#import "Operation.h"


@implementation OperationTraits

+ (OperationTraits*)initWithName:(NSString*)name
                             Num:(int)num
                             Sel:(SEL)sel
{
    OperationTraits* optr = [[OperationTraits alloc] init];
    optr->_name = name;
    optr->_numOperands = num;
    optr->_sel = sel;
    return optr;
}

+ (NSArray*)all
{
    return [NSArray arrayWithObjects:
            [OperationTraits initWithName:@"pi" Num:0 Sel:@selector(pi)],
            [OperationTraits initWithName:@"e" Num:0 Sel:@selector(e)],
            [OperationTraits initWithName:@"+/-" Num:1 Sel:@selector(negative)],
            [OperationTraits initWithName:@"sqrt" Num:1 Sel:@selector(sqrt)],
            [OperationTraits initWithName:@"sin" Num:1 Sel:@selector(sin)],
            [OperationTraits initWithName:@"cos" Num:1 Sel:@selector(cos)],
            [OperationTraits initWithName:@"+" Num:2 Sel:@selector(add)],
            [OperationTraits initWithName:@"-" Num:2 Sel:@selector(sub)],
            [OperationTraits initWithName:@"*" Num:2 Sel:@selector(mul)],
            [OperationTraits initWithName:@"/" Num:2 Sel:@selector(div)],
            nil
            ];
}

+ (OperationTraits*)find:(NSString*)name {
    for (OperationTraits* const optr in [self all]) {
        if( [optr->_name isEqualToString:name] )
            return optr;
    }
    return nil;
}

+ (double)pi { return 3.1415926; }
+ (double)e { return 2.718281828; }
+ (double)negative:(double)x { return -x; }
+ (double)sqrt:(double)x { return sqrt(x); }
+ (double)sin:(double)x { return sin(x); }
+ (double)cos:(double)x { return cos(x); }
+ (double)add:(double)x :(double)y { return x+y; }
+ (double)mul:(double)x :(double)y { return x*y; }
+ (double)sub:(double)x :(double)y { return x-y; }
+ (double)div:(double)x :(double)y { return x/y; }

@end
