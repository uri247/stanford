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
    // returns a copy of the program stack
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
    id topOfStack = [stack lastObject];
    if( topOfStack) {
        [stack removeLastObject];
    }
    
    if( [topOfStack isKindOfClass:[NSNumber class]] ) {
        result = [topOfStack doubleValue];
    }
    else if( [topOfStack isKindOfClass:[NSString class]] )
    {
        NSString* operation = topOfStack;
        
        if( [operation isEqualToString:@"+"] ) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        }
        else if( [operation isEqualToString:@"-"] ) {
            result = [self popOperandOffStack:stack] - [self popOperandOffStack:stack];
        }
        else if( [operation isEqualToString:@"*"] ) {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        }
        else if( [operation isEqualToString:@"/"] ) {
            result = [self popOperandOffStack:stack] / [self popOperandOffStack:stack];
        }
        else if( [operation isEqualToString:@"+/-"] ) {
            result = - [self popOperandOffStack:stack];
        }
        else if( [operation isEqualToString:@"pi"] ) {
            result = 3.14159265;
        }
        else if( [operation isEqualToString:@"e"] ) {
            result = 2.718281828;
        }
        else if( [operation isEqualToString:@"sin"] ) {
            result = sin( [self popOperandOffStack:stack] );
        }
        else if( [operation isEqualToString:@"cos"] ) {
            result = cos( [self popOperandOffStack:stack] );
        }
        else if( [operation isEqualToString:@"sqrt"] ) {
            result = sqrt( [self popOperandOffStack:stack] );
        }
        else if( [operation isEqualToString:@"log"] ) {
            result = log( [self popOperandOffStack:stack] );
        }
    }
        
    return result;
}

+ (double)runProgram:(id)program
{
    NSMutableArray* stack;
    if( [program isKindOfClass:[NSArray class]] ) {
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}

- (void)clear
{
    [self.programStack removeAllObjects];
}
@end
