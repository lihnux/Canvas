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
    
    path = [NSBezierPath bezierPath];
    [path setLineWidth:lineWidth];
    [path setLineCapStyle:NSRoundLineCapStyle];
    
    
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
    
    NSBitmapImageRep *drawToImage = mainImage;
    
    if (event.type == NSLeftMouseUp) {
        drawing = NO;
    }
    else if (event.type == NSLeftMouseDown){
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
