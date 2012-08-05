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

+ (id)popFromStack:(NSMutableArray*)stack
{
    id topOfStack = [stack lastObject];
    if( topOfStack) {
        [stack removeLastObject];
    }
    return topOfStack;
}

+ (NSString*)popDescriptionOffStack:(NSMutableArray*)stack :(enum Precedence*)pprec
{
    NSString* result;
    id topOfStack = [self popFromStack:stack];
    enum Precedence prec;
    
    if( [self isNumber:topOfStack] ) {
        NSNumber* num = topOfStack;
        result = [num stringValue];
        prec = PrecAtomic;
    }
    else if( [self isOperation:topOfStack] ) {
        struct Operation* op = [self getOp:topOfStack];
        NSString *arg1, *arg2;
        enum Precedence prec1, prec2;
        
        if( op->_numOperands >= 2 )
            arg2 = [self popDescriptionOffStack:stack :&prec2];
        if( op->_numOperands >= 1 )
            arg1 = [self popDescriptionOffStack:stack :&prec1];
        
        if( op->_numOperands == 0 ) {
            result = [NSString stringWithCString:op->_name encoding:NSUTF8StringEncoding];
            prec = PrecAtomic;
        }
        else if( op->_numOperands == 1 ) {
            result = [NSString stringWithFormat:@"%s(%@)", op->_name, arg1];
            prec = PrecAtomic;
        }
        else if( op->_numOperands == 2 ) {
            // Prepare the format string, and put parenthesis according to precedence calculation
            NSString* fmt;
            if( prec1 <= op->_prec && prec2 <= op->_prec )
                fmt = @"%@ %s %@";
            else if( prec1 < op->_prec && prec2 > op->_prec )
                fmt = @"%@ %s (%@)";
            else if( prec1 > op->_prec && prec2 <= op->_prec )
                fmt = @"(%@) %s %@";
            else
                fmt = @"(%@) %s (%@)";
            
            result = [NSString stringWithFormat:fmt, arg1, op->_name, arg2];
            prec = op->_prec;
        }
    }

    if( pprec ) *pprec = prec;
    return result;
     
}


+ (NSString*)descriptionOfProgram:(id)program
{
    NSMutableArray* stack;
    if( [program isKindOfClass:[NSArray class]] ) {
        stack = [program mutableCopy];
    }
    NSString* result = [self popDescriptionOffStack:stack :nil];
    while( stack.count > 0 ) {
        result = [[self popDescriptionOffStack:stack :nil] stringByAppendingFormat:@", %@", result];
    }
    return result;
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

+ (BOOL)isNumber:(id)obj
{
    return [obj isKindOfClass:[NSNumber class]];
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
