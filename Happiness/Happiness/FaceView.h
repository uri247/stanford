//
//  FaceView.h
//  Happiness
//
//  Created by Uri London on 8/15/12.
//  Copyright (c) 2012 Uri London. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaceView : UIView
@property (nonatomic)CGFloat scale;

- (void)pinch:(UIPinchGestureRecognizer*)gesture;
@end
