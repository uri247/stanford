//
//  CalbulatorBrain.m
//  Calculator
//
//  Created by Uri London on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property(nonatomic,strong) NSMutableArray* programStack;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray*)programStack
{
    if (_programStack == nil) {
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}

- (id)program
{
    return [self.programStack copy];
}


- (void)pushOperand:(double)operand
{
    NSNumber* operandObject = [NSNumber numberWithDouble:operand];
    [self.programStack addObject:operandObject];
}

- (double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}

+ (NSString*)descriptionOfProgram:(id)program
{
    return @"implement this later";
}

+ (double)popOperandOffStack:(NSMutableArray*)stack
{
    double result = 0;
    return result;
}

+ (double)runProgram:(id)program
{
    return [self popOperandOffStack:[program mutableCopy]];
}
    /*
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
     */

- (void)clear
{
    [self.programStack removeAllObjects];
}
@end
