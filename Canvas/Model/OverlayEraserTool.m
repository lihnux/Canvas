//
//  OverlayEraserTool.m
//  Canvas
//
//  Created by Paul Li on 1/6/14.
//  Copyright (c) 2014 Paul Li. All rights reserved.
//

#import "OverlayEraserTool.h"
#import "ImageTools.h"

@implementation OverlayEraserTool

- (id)init {
    
    return [super initWithLineWidth:20 lineMinWidth:15 lineMaxWidth:35
                    foregroundColor:[NSColor clearColor]
                    backgroundColor:[NSColor clearColor]];
}

- (NSString*)description {
    return kEraserToolbarItemID;
}

#pragma mark - Implement Drawing Methods

- (NSBezierPath *)pathFromPoint:(NSPoint)begin toPoint:(NSPoint)end {
    
    /*
    if (path == nil) {
        path = [[NSBezierPath alloc] init];
        [path setLineWidth:lineWidth];
        [path setLineCapStyle:NSRoundLineCapStyle];
        [path setLineJoinStyle:NSRoundLineJoinStyle];
    }
    */
    
    path = [NSBezierPath bezierPath];
    [path setLineWidth:lineWidth];
    [path setLineCapStyle:NSRoundLineCapStyle];
    
    
    [path moveToPoint:begin];
	[path lineToPoint:end];
    
	return path;
}

- (NSBezierPath *)performDrawAtPoint:(NSPoint)point
					   withMainImage:(NSBitmapImageRep *)aMainImage
						 bufferImage:(NSBitmapImageRep *)aBufferImage
						  mouseEvent:(UInt8)mouseEvent
                                view:(NSView*)fromView {
    
    mainImage   = aMainImage;
    bufferImage = aBufferImage;
    canvas      = fromView;
    
    NSBitmapImageRep *drawToImage = mainImage;
    
    if (mouseEvent == mouseUpEvent) {
        drawing = NO;
        //[path release];
        //path = nil;
    }
    else if (mouseEvent == mouseDownEvent){
        drawing = YES;
        lastPoint = point;
    }

    GCLockBitmapImage(drawToImage);
    
    [NSGraphicsContext saveGraphicsState];
    [[NSGraphicsContext currentContext] setCompositingOperation:NSCompositeCopy];
    
    [foregroundColor setStroke];
    
    @autoreleasepool {
        [[self pathFromPoint:lastPoint toPoint:point] stroke];
    }
    
    [NSGraphicsContext restoreGraphicsState];
    
    lastPoint = point;
    
    GCUnlockBitmapImage(drawToImage);
    
	return nil;
}


@end
