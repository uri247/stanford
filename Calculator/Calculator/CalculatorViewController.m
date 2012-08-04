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

- (NSDictionary*)variableValues
{
    if( !_variableValues ) {
        _variableValues = [[NSDictionary alloc] init];
    }
    return _variableValues;
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


- (void)viewDidUnload {
    [self setProgDesc:nil];
    [super viewDidUnload];
}
@end
	