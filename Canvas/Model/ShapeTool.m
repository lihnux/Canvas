//
//  ShapeTool.m
//  Canvas
//
//  Created by Paul Li on 1/13/14.
//  Copyright (c) 2014 Paul Li. All rights reserved.
//

#import "ShapeTool.h"

@implementation ShapeTool

#pragma mark - Private Draw method

- (void)drawCurrentPath {
    if ([self.description isEqualToString:kLineToolbarItemID] ==  NO) {
        [backgroundColor    setFill];
        [path               fill];
    }
    
    [foregroundColor    setStroke];
    [path               stroke];
    
    [path               removeAllPoints];
}

#pragma mark - Override Drawing Methods

- (NSBezierPath *)performDrawWithEvent:(NSEvent*)event view:(NSView*)fromView {
    
    NSPoint point = [fromView convertPoint:[event locationInWindow] fromView:nil];
    
    if (event.type == NSLeftMouseDown) {
        drawing     = YES;
        lastPoint   = point;
    }
    else if (event.type == NSLeftMouseUp) {
        [self pathFromPoint:lastPoint toPoint:point];
        drawing = NO;
        needUpdateToMainLayer = YES;
	}
	else {
        
        [self pathFromPoint:lastPoint toPoint:point];
	}
	return nil;
}

- (void)drawOnMainLayer {
    [self drawCurrentPath];
    needUpdateToMainLayer = NO;
}

- (void)drawOnView {
    [self drawCurrentPath];
}

@end
