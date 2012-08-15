//
//  PsychologistViewController.m
//  Psychologist
//
//  Created by Uri London on 8/15/12.
//  Copyright (c) 2012 Uri London. All rights reserved.
//

#import "PsychologistViewController.h"
#import "HappinessViewController.h"

@interface PsychologistViewController ()
@property (nonatomic) int diagnosis;
@end

@implementation PsychologistViewController
@synthesize diagnosis = _diagnosis;

- (void)setAndShowDiagnonsis:(int)diagnosis
{
    self.diagnosis = diagnosis;
    [self performSegueWithIdentifier:@"ShowDiagnosis" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    HappinessViewController* hvc = segue.destinationViewController;
    if( [segue.identifier isEqualToString:@"ShowDiagnosis"] ) {
        [hvc setHappiness:self.diagnosis];
    }
    else if( [segue.identifier isEqualToString:@"Celebrity"] ) {
        [hvc setHappiness:100];
    }
    else if( [segue.identifier isEqualToString:@"Serious"] ) {
        [hvc setHappiness:20];
    }
    else if( [segue.identifier isEqualToString:@"TV Kook"] ) {
        [hvc setHappiness:50];
    }
}
- (IBAction)flying {
    [self setAndShowDiagnonsis:85];
}

- (IBAction)apple {
    [self setAndShowDiagnonsis:100];
}

- (IBAction)dragons {
    [self setAndShowDiagnonsis:20];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
