//
//  PenTool.m
//  Canvas
//
//  Created by Paul Li on 12/27/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import "PenTool.h"
#import "ImageTools.h"

@implementation PenTool

- (id)init {
    
    return [super initWithForegroundColor:nil backgroundColor:[NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
}

- (NSString*)description {
    return kPenToolbarItemID;
}

#pragma mark - Implement Drawing Methods

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
	
	if (event.type == NSLeftMouseUp) {
        drawing = NO;
        needUpdateToMainLayer = YES;
	}
	else {
        
		[self pathFromPoint:lastPoint toPoint:point];
		lastPoint = point;
        needUpdateToMainLayer = YES;
	}
	return nil;
}

- (void)drawOnMainLayer {
    
    [foregroundColor    setStroke];
    [path               stroke];
    [path               removeAllPoints];
    
    needUpdateToMainLayer = NO;
}

@end
