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
    self = [super init];
    
    if (self) {
        self.foregroundColor = [NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        self.backgroundColor = [NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.lineWidth = 3;
    }
    return self;
}

#pragma mark - Implement Drawing Methods

- (NSBezierPath *)pathFromPoint:(NSPoint)begin toPoint:(NSPoint)end {
    
    if (path == nil) {
        path = [[NSBezierPath alloc] init];
        [path setLineWidth:lineWidth];
        [path setLineCapStyle:NSRoundLineCapStyle];
        [path setLineJoinStyle:NSRoundLineJoinStyle];
    }
    
	[path moveToPoint:begin];
	[path lineToPoint:end];
    
	return path;
}

- (NSBezierPath *)performDrawAtPoint:(NSPoint)point
					   withMainImage:(NSBitmapImageRep *)mainImage
						 bufferImage:(NSBitmapImageRep *)bufferImage
						  mouseEvent:(UInt8)mouseEvent {
	
	if (mouseEvent == mouseUpEvent) {
		//[ImageTools drawToImage:mainImage fromImage:bufferImage withComposition:YES];
        [ImageTools clearBitmapImage:bufferImage];
        
		[path release];
		path = nil;
	}
	else {
        GCLockBitmapImage(bufferImage);
		
		[ImageTools clearBitmapImage:bufferImage];
		
		[NSGraphicsContext saveGraphicsState];
		[[NSGraphicsContext currentContext] setCompositingOperation:NSCompositeCopy];
        
        [foregroundColor setStroke];
        
        if (mouseEvent == mouseDownEvent) {
            lastPoint = point;
        }
        
		[[self pathFromPoint:lastPoint toPoint:point] stroke];
		[NSGraphicsContext restoreGraphicsState];
        
		lastPoint = point;
        
        GCUnlockBitmapImage(bufferImage);
	}
	return nil;
}

@end
