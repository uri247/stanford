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
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize everything = _everything;
@synthesize userInTheMiddleOfANumber = _userInTheMiddleOfANumber;
@synthesize brain = _brain;


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
        [self removeEqualFromEverything];
    }
}

- (void)addItemToEverything :(NSString*)item {
    self.everything.text = [self.everything.text stringByAppendingFormat:@" %@", item];
}

- (void)removeEqualFromEverything {
    NSString* ev = self.everything.text;
    NSRange range = [ev rangeOfString:@" ="];
    if( range.location != NSNotFound ) {
        NSString* newev = [ev substringToIndex:range.location];
        self.everything.text = newev;
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:self.display.text.doubleValue];
    [self addItemToEverything:self.display.text];
    self.userInTheMiddleOfANumber = FALSE;
    self.userPressedDot = FALSE;
}

- (IBAction)clearPressed {
    self.display.text = @"";
    self.everything.text = @"";
    self.userInTheMiddleOfANumber = FALSE;
    self.userPressedDot = FALSE;
    [self.brain clear];
}

- (IBAction)operationPressed:(UIButton *)sender {
    if( self.userInTheMiddleOfANumber) {
        [self enterPressed];
    }
    else {
        [self removeEqualFromEverything];
    }
    [self addItemToEverything:sender.currentTitle];
    [self addItemToEverything:@" ="];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString* resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}


- (void)viewDidUnload {
    [self setEverything:nil];
    [super viewDidUnload];
}
@end
	