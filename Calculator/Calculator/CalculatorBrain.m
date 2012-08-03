//
//  CalbulatorBrain.m
//  Calculator
//
//  Created by Uri London on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property(nonatomic,strong) NSMutableArray* operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray*)operandStack
{
    if (_operandStack == nil) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

- (void)setOperandStack:(NSMutableArray *)operandStack
{
    _operandStack = operandStack;
}

- (void)pushOperand:(double)operand
{
    NSNumber* operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

- (double)popOperand
{
    NSNumber* operandObject = [self.operandStack lastObject];
    if( operandObject ) {
        [self.operandStack removeLastObject];
    }
    return operandObject.doubleValue;
}

- (double)performOperation:(NSString *)operation
{	
    double result = 0;
    
    if( [operation isEqualToString:@"+"] ) {
        result = [self popOperand] + [self popOperand];
    }
    else if( [operation isEqualToString:@"-"] ) {
        result = [self popOperand] - [self popOperand];
    }
    else if( [operation isEqualToString:@"*"] ) {
        result = [self popOperand] * [self popOperand];
    }
    else if( [operation isEqualToString:@"/"] ) {
        result = [self popOperand] / [self popOperand];
    }
    else if( [operation isEqualToString:@"+/-"] ) {
        result = - [self popOperand];
    }
    else if( [operation isEqualToString:@"pi"] ) {
        result = 3.14159265;
    }
    else if( [operation isEqualToString:@"e"] ) {
        result = 2.718281828;
    }
    else if( [operation isEqualToString:@"sin"] ) {
        result = sin( [self popOperand] );
    }
    else if( [operation isEqualToString:@"cos"] ) {
        result = cos( [self popOperand] );
    }
    else if( [operation isEqualToString:@"sqrt"] ) {
        result = sqrt( [self popOperand] );
    }
    else if( [operation isEqualToString:@"log"] ) {
        result = log( [self popOperand] );
    }
    
    [self pushOperand:result];
    
    return result;
}

- (void)clear
{
    [self.operandStack removeAllObjects];
}
@end
