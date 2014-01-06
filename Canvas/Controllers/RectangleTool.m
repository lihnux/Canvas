//
//  RectangleTool.m
//  Canvas
//
//  Created by Paul Li on 12/27/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import "RectangleTool.h"
#import "ImageTools.h"

@implementation RectangleTool

- (id)init {
    
    return [super initWithForegroundColor:nil backgroundColor:[NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
}

- (NSString*)description {
    return kRectangleToolbarItemID;
}

#pragma mark - Implement Drawing Methods

- (NSBezierPath *)pathFromPoint:(NSPoint)begin toPoint:(NSPoint)end {
    
    path = [NSBezierPath bezierPath];
    
    [path setLineWidth:lineWidth];
	[path setLineCapStyle:NSSquareLineCapStyle];
	[path moveToPoint:begin];
    
    [path appendBezierPathWithRect:NSMakeRect(begin.x, begin.y, end.x - begin.x, end.y - begin.y)];
    
	return path;
}

- (NSBezierPath *)performDrawWithEvent:(NSEvent*)event
                         withMainImage:(NSBitmapImageRep *)aMainImage
                           bufferImage:(NSBitmapImageRep *)aBufferImage
                                  view:(NSView*)fromView {
    
    @autoreleasepool {
        
        mainImage   = aMainImage;
        bufferImage = aBufferImage;
        canvas      = fromView;
        
        NSPoint point = [fromView convertPoint:[event locationInWindow] fromView:nil];
        
        [ImageTools clearBitmapImage:bufferImage];
        
        NSBitmapImageRep *drawToImage = nil;
        
        if (event.type == NSLeftMouseUp) {
            drawToImage = mainImage;
            drawing     = NO;
        }
        else if (event.type == NSLeftMouseDown) {
            drawToImage = bufferImage;
            lastPoint   = point;
            drawing     = YES;
        }
        else {
            drawToImage = bufferImage;
        }
        
        GCLockBitmapImage(drawToImage);
        
        [foregroundColor setStroke];
        [backgroundColor setFill];
        
        [self pathFromPoint:lastPoint toPoint:point];
        
        [path stroke];
        [path fill];
        
        GCUnlockBitmapImage(drawToImage);
    }
    
	return nil;
}

@end
