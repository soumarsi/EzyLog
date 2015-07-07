//
//  mySmoothLineView.m
//  EzyLog
//
//  Created by ios on 26/06/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "mySmoothLineView.h"

@implementation mySmoothLineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        // set Multiple touches Enabled to false for allow only single touch.
        [self setMultipleTouchEnabled: NO];
        self->_path = [UIBezierPath bezierPath];
        // set Line width.
        [self->_path setLineWidth:5.0];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self->_path stroke];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    ctr = 0;
    UITouch *myTouch = [touches anyObject];
    pts[0] = [myTouch locationInView: self];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView: self];
    ctr++;
    pts[ctr] = p;
    if (ctr == 4) {
        pts[3] = CGPointMake((pts[2].x + pts[4].x)/2.0, (pts[2].y + pts[4].y)/2.0);
        [self->_path moveToPoint: pts[0]];
        [self->_path addCurveToPoint: pts[3] controlPoint1:pts[1] controlPoint2:pts[2]];
        [self setNeedsDisplay];
        pts[0] = pts[3];
        pts[1] = pts[4];
        ctr = 1;
    }
}

@end
