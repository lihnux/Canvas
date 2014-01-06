//
//  LineTool.m
//  Canvas
//
//  Created by Paul Li on 1/2/14.
//  Copyright (c) 2014 Paul Li. All rights reserved.
//

#import "LineTool.h"
#import "ImageTools.h"

@implementation LineTool

- (id)init {
    
    return [super initWithForegroundColor:nil backgroundColor:[NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
}

- (NSString*)description {
    return kLineToolbarItemID;
}

#pragma mark - Implement Drawing Methods

- (NSBezierPath *)pathFromPoint:(NSPoint)begin toPoint:(NSPoint)end {
    
    path = [NSBezierPath bezierPath];
    
    [path setLineWidth:lineWidth];
    
	[path moveToPoint:begin];
    [path lineToPoint:end];
    
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
        
        [[self pathFromPoint:lastPoint toPoint:point] stroke];
        
        GCUnlockBitmapImage(drawToImage);
    }
    
	return nil;
}

@end
