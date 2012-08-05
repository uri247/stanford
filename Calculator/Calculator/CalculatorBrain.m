//
//  CalbulatorBrain.m
//  Calculator
//
//  Created by Uri London on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"
#import "Operation.h"


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

- (void)pushOperator:(NSString*)opera
{
    [self.programStack addObject:opera];
}

- (void)pushVariable:(NSString*)variable
{
    [self.programStack addObject:variable];
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

+ (BOOL)isOperation:(id)opname
{
    if ( [opname isKindOfClass:[NSString class]] ) {
        return ([OperationTraits find:opname]) ? true: false;
    }
    else
        return false;
}


+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues
{
    NSMutableArray* stack;
    int i;
    
    if( [program isKindOfClass:[NSArray class]] ) {
        stack = [program mutableCopy];
    
        for( i=0; i<stack.count; ++i )
        {
            id o = [stack objectAtIndex:i];
            if( [o isKindOfClass:[NSString class]] ) {
                if( ![self isOperation:o] ) {
                    [stack replaceObjectAtIndex:i withObject:[variableValues objectForKey:o]];
                }
            }
        }    
    }
    return 0;
}


- (void)clear
{
    [self.programStack removeAllObjects];
}
@end
