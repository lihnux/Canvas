//
//  HighLighterTool.m
//  Canvas
//
//  Created by Paul Li on 1/2/14.
//  Copyright (c) 2014 Paul Li. All rights reserved.
//

#import "HighLighterTool.h"
#import "ImageTools.h"

@implementation HighLighterTool

- (id)init {
    
    return [super initWithLineWidth:15 lineMinWidth:15 lineMaxWidth:30 foregroundColor:[NSColor colorWithCalibratedRed:0.0 green:0.0 blue:1.0 alpha:0.6] backgroundColor:[NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
}

- (NSString*)description {
    return kHighLighterToolbarItemID;
}

- (NSBezierPath *)pathFromPoint:(NSPoint)begin toPoint:(NSPoint)end {
    
    [path setLineWidth:lineWidth];
    [path setLineCapStyle:NSRoundLineCapStyle];
    [path setLineJoinStyle:NSRoundLineJoinStyle];
    
    if (path.elementCount == 0) {
        [path moveToPoint:begin];
        [path lineToPoint:end];
    }
    else {
        [path lineToPoint:end];
    }
    
	return path;
}

- (NSBezierPath *)performDrawWithEvent:(NSEvent*)event view:(NSView*)fromView {
    
    NSPoint point = [fromView convertPoint:[event locationInWindow] fromView:nil];
    
    if (event.type == NSLeftMouseDown) {
        drawing     = YES;
        lastPoint   = point;
    }
	else if (event.type == NSLeftMouseUp) {
        drawing = NO;
        needUpdateToMainLayer = YES;
	}
	else {
        
        //if (fabsf(lastPoint.x - point.x) > 4.0f && fabsf(lastPoint.y - point.y) > 4.0f) {
            [self pathFromPoint:lastPoint toPoint:point];
            lastPoint = point;
        //}
	}
	return nil;
}

- (void)drawOnMainLayer {
    [foregroundColor    setStroke];
    [path               stroke];
    [path               removeAllPoints];
    
    needUpdateToMainLayer = NO;
}

- (void)drawOnView {
    [foregroundColor setStroke];
    [path stroke];
}


@end
