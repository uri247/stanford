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
    else if( [self isOperation:topOfStack] )
    {
        struct Operation* op = [self getOp:topOfStack];
        
        // collect appropriate number of arguments recursively
        double arg1, arg2;
        if( op->_numOperands >= 2 )
            arg2 = [self popOperandOffStack:stack];
        if( op->_numOperands >= 1 )
            arg1 = [self popOperandOffStack:stack];
        
        // call
        if( op->_numOperands == 0 )
            result = (*op->_fn)( );
        else if( op->_numOperands == 1 )
            result = (*op->_fn)( arg1 );
        else if( op->_numOperands == 2 )
            result = (*op->_fn)( arg1, arg2 );
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


+ (struct Operation*)getOp:(id)opname
{
    return [Operations find:opname];
}

+ (BOOL)isOperation:(id)opname
{
    return [Operations find:opname] ? true : false;
}

+ (BOOL)isVariable:(id)obj
{
    // A variable is a string which is not an operation
    if ( [obj isKindOfClass:[NSString class]] ) {
        return ![self isOperation:obj];
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
