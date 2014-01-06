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

- (NSBezierPath *)performDrawWithEvent:(NSEvent*)event
                         withMainImage:(NSBitmapImageRep *)aMainImage
                           bufferImage:(NSBitmapImageRep *)aBufferImage
                                  view:(NSView*)fromView {
    
    mainImage   = aMainImage;
    bufferImage = aBufferImage;
    canvas      = fromView;
    
    NSPoint point = [fromView convertPoint:[event locationInWindow] fromView:nil];
	
	if (event.type == NSLeftMouseUp) {
		[ImageTools drawToImage:mainImage fromImage:bufferImage withComposition:YES];
        [ImageTools clearBitmapImage:bufferImage];
        
        drawing = NO;
        
		[path release];
		path = nil;
	}
	else {
        
        GCLockBitmapImage(bufferImage);
		
		[ImageTools clearBitmapImage:bufferImage];
		
		[NSGraphicsContext saveGraphicsState];
		[[NSGraphicsContext currentContext] setCompositingOperation:NSCompositeCopy];
        
        [foregroundColor setStroke];
        
        if (event.type == NSLeftMouseDown) {
            lastPoint   = point;
            drawing     = YES;
        }
        
		[[self pathFromPoint:lastPoint toPoint:point] stroke];
		[NSGraphicsContext restoreGraphicsState];
        
		lastPoint = point;
        
        GCUnlockBitmapImage(bufferImage);
	}
	return nil;
}

@end
