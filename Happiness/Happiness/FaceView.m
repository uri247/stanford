//
//  FaceView.m
//  Happiness
//
//  Created by Uri London on 8/14/12.
//  Copyright (c) 2012 Uri London. All rights reserved.
//

#import "FaceView.h"

#define DEFAULT_SCALE   0.90
#define EYE_H           0.35
#define EYE_V           0.35
#define EYE_RADIUS      0.10
#define MOUTH_H         0.45
#define MOUTH_V         0.40
#define MOUTH_SMILE     0.25


@implementation FaceView
@synthesize scale = _scale;
@synthesize dataSource = _dataSource;

- (CGFloat)scale
{
    if(!_scale) {
        return DEFAULT_SCALE;
    }
    else {
        return _scale;
    }
    
}

- (void)setScale:(CGFloat)scale
{
    if( _scale != scale ) {
        _scale = scale;
        [self setNeedsDisplay];
    }
}


- (void)pinch:(UIPinchGestureRecognizer*)gesture
{
    if( (gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded) ) {
        self.scale *= gesture.scale;
        gesture.scale = 1;
    }
}


- (void)setup
{
    self.contentMode = UIViewContentModeRedraw;
}


- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)ctx
{
    UIGraphicsPushContext(ctx);
    CGContextBeginPath(ctx);
    CGContextAddArc(ctx, p.x, p.y, radius, 0, 2*M_PI, YES);
    CGContextStrokePath(ctx);
    UIGraphicsPopContext();
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGPoint midPoint;
    midPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
    midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    CGFloat size = self.bounds.size.width / 2;
    if( self.bounds.size.height < self.bounds.size.width )
        size = self.bounds.size.height / 2;
    size *= self.scale;

    CGContextSetLineWidth(ctx, 5.0);
    [[UIColor blueColor] setStroke];
    
    // draw face (circle)
    [self drawCircleAtPoint:midPoint withRadius:size inContext:ctx];
    
    // draw eyes (2 circles)
    CGPoint eyePoint = { midPoint.x - size*EYE_H, midPoint.y - size*EYE_V };
    [self drawCircleAtPoint:eyePoint withRadius:size*EYE_RADIUS inContext:ctx];
    eyePoint.x = midPoint.x + size*EYE_H;
    [self drawCircleAtPoint:eyePoint withRadius:size*EYE_RADIUS inContext:ctx];
    
    // no nose
    
    // draw mouth
    CGPoint mouthStart = { midPoint.x - MOUTH_H*size, midPoint.y + MOUTH_V*size };
    CGPoint mouthEnd = { midPoint.x + MOUTH_H*size, midPoint.y + MOUTH_V*size };
    
    // get the smile from data source
    float smile = [self.dataSource smileForFaceView:self];
    if( smile < -1 ) smile = -1;
    if( smile > 1 ) smile = 1;
    
    CGFloat smileOffset = MOUTH_SMILE * size * smile;
    CGPoint mouthCP1 = { mouthStart.x + MOUTH_H*size*2/3, mouthStart.y + smileOffset };
    CGPoint mouthCP2 = { mouthEnd.x - MOUTH_H*size*2/3, mouthEnd.y + smileOffset };

    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, mouthStart.x, mouthStart.y);
    CGContextAddCurveToPoint(ctx, mouthCP1.x, mouthCP1.y, mouthCP2.x, mouthCP2.y, mouthEnd.x, mouthEnd.y);
    CGContextStrokePath(ctx);
}

@end
