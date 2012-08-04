//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Uri London on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"


@interface CalculatorViewController ()
@property (nonatomic) BOOL userInTheMiddleOfANumber;
@property (nonatomic) BOOL userPressedDot;
@property (nonatomic, strong) CalculatorBrain* brain;
@property (nonatomic, strong) NSDictionary* variableValues;
@end


@implementation CalculatorViewController

@synthesize display = _display;
@synthesize progDesc = _progDesc;
@synthesize variableDesc = _variableDesc;
@synthesize userInTheMiddleOfANumber = _userInTheMiddleOfANumber;
@synthesize brain = _brain;
@synthesize variableValues = _variableValues;




- (CalculatorBrain*)brain
{
    if( !_brain ) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}

- (IBAction)digitPressed:(UIButton*)sender {
    NSString* digit = sender.currentTitle;
    if( [digit isEqualToString:@"."] ) {
        if( self.userPressedDot )
            return;
        self.userPressedDot = TRUE;
    }
    if (self.userInTheMiddleOfANumber) {		
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else {
        self.display.text = digit;
        self.userInTheMiddleOfANumber = TRUE;
        [self removeEqualFromProgDisc];
    }
}

- (void)addItemToEverything :(NSString*)item {
    self.progDesc.text = [self.progDesc.text stringByAppendingFormat:@" %@", item];
}

- (void)removeEqualFromProgDisc {
    NSString* ev = self.progDesc.text;
    NSRange range = [ev rangeOfString:@" ="];
    if( range.location != NSNotFound ) {
        NSString* newev = [ev substringToIndex:range.location];
        self.progDesc.text = newev;
    }
}

- (void)refreshResult :(BOOL)recalc {
    self.progDesc.text = [CalculatorBrain descriptionOfProgram:[self.brain program]];
    if( recalc ) {
        double result = [CalculatorBrain runProgram:[self.brain program]];
        self.display.text = [NSString stringWithFormat:@"%g", result];
    }
}

- (void)refreshVariableDesc {
    NSMutableString* variableDesc = [NSMutableString stringWithString:@""];
    for (NSString* vname in self.variableValues) {
        [variableDesc appendFormat:@" %@=%@", vname, [self.variableValues objectForKey:vname]];
    }
    self.variableDesc.text = variableDesc;
}

- (IBAction)enterPressed {
    [self.brain pushOperand:self.display.text.doubleValue];
    [self refreshResult:false];
    self.userInTheMiddleOfANumber = FALSE;
    self.userPressedDot = FALSE;
}

- (IBAction)clearPressed {
    self.display.text = @"";
    self.progDesc.text = @"";
    self.userInTheMiddleOfANumber = FALSE;
    self.userPressedDot = FALSE;
    [self.brain clear];
}

- (IBAction)operationPressed:(UIButton *)sender {
    if( self.userInTheMiddleOfANumber) {
        [self enterPressed];
    }
    [self.brain pushOperator:sender.currentTitle];
    [self refreshResult:(true)];
}

- (IBAction)testPressed:(UIButton *)sender {
    if( [sender.currentTitle isEqualToString:@"Test 1"] ) {
        self.variableValues = nil;
    }
    else if( [sender.currentTitle isEqualToString:@"Test 2"] ) {
        self.variableValues = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithDouble:15], @"x",
                               [NSNumber numberWithDouble:3], @"y",
                               [NSNumber numberWithDouble:4], @"z",
                               [NSNumber numberWithDouble:12], @"w",
                               nil
                               ];
    }
    else if( [sender.currentTitle isEqualToString:@"Test 3"] ) {
        self.variableValues = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithDouble:42], @"answer",
                               [NSNumber numberWithDouble:8], @"x",
                               nil
                               ];
    }
    [self refreshVariableDesc];
}


- (IBAction)variablePressed:(UIButton *)sender {
}

- (void)viewDidUnload {
    [self setProgDesc:nil];
    [super viewDidUnload];
}
@end

	