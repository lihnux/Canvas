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

- (NSBezierPath *)performDrawAtPoint:(NSPoint)point
					   withMainImage:(NSBitmapImageRep *)aMainImage
						 bufferImage:(NSBitmapImageRep *)aBufferImage
						  mouseEvent:(UInt8)mouseEvent
                                view:(NSView*)fromView{
    
    @autoreleasepool {
        
        mainImage   = aMainImage;
        bufferImage = aBufferImage;
        canvas      = fromView;
        
        [ImageTools clearBitmapImage:bufferImage];
        
        NSBitmapImageRep *drawToImage = nil;
        
        if (mouseEvent == mouseUpEvent) {
            drawToImage = mainImage;
        }
        else {
            drawToImage = bufferImage;
        }
        
        GCLockBitmapImage(drawToImage);
        
        if (mouseEvent == mouseDownEvent) {
            lastPoint   = point;
            drawing     = YES;
        }
        else {
            drawing     = NO;
        }
        
        [self pathFromPoint:lastPoint toPoint:point];
        
        [foregroundColor setStroke];
        [backgroundColor setFill];
        
        [path stroke];
        [path fill];
        
        GCUnlockBitmapImage(drawToImage);
    }
    
	return nil;
}

@end
