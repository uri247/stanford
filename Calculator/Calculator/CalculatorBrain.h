//
//  CalbulatorBrain.h
//  Calculator
//
//  Created by Uri London on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (void)pushOperator:(NSString*)opera;
- (void)pushVariable:(NSString*)variable;
- (double)performOperation:(NSString*)operation;
- (void)clear;

@property (readonly) id program;

+(double)runProgram:(id)program;
+(double)runProgram:(id)Program
	usingVariableValues:(NSDictionary*)variableValues;
+(NSString*)descriptionOfProgram:(id)program;
+(BOOL)isOperation:(NSString*)opname;

@end
