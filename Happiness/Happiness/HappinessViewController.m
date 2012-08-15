//
//  HappinessViewController.m
//  Happiness
//
//  Created by Uri London on 8/15/12.
//  Copyright (c) 2012 Uri London. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"

@interface HappinessViewController ()
@property (nonatomic, weak) IBOutlet FaceView* faceView;
@end


@implementation HappinessViewController
@synthesize happiness = _happiness;
@synthesize faceView = _faceView;


- (void)setHappiness:(int)happiness
{
    _happiness = happiness;
    [self.faceView setNeedsDisplay];
}

- (void)setFaceView:(FaceView *)faceView
{
    _faceView = faceView;
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView
                                                                                  action:@selector(pinch:)]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
@end
