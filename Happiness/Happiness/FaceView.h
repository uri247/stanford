//
//  FaceView.h
//  Happiness
//
//  Created by Uri London on 8/15/12.
//  Copyright (c) 2012 Uri London. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FaceView;


@protocol FaceViewDataSource
- (float)smileForFaceView:(FaceView*)sender;
@end


@interface FaceView : UIView
@property (nonatomic)CGFloat scale;
@property (nonatomic, weak) IBOutlet id<FaceViewDataSource> dataSource;
- (void)pinch:(UIPinchGestureRecognizer*)gesture;
@end
