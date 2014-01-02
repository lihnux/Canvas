//
//  EllipseTool.m
//  Canvas
//
//  Created by Paul Li on 1/2/14.
//  Copyright (c) 2014 Paul Li. All rights reserved.
//

#import "EllipseTool.h"
#import "ImageTools.h"

@implementation EllipseTool

- (id)init {
    
    return [super initWithForegroundColor:nil backgroundColor:[NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
}

#pragma mark - Implement Drawing Methods

- (NSBezierPath *)pathFromPoint:(NSPoint)begin toPoint:(NSPoint)end {
    
    path = [NSBezierPath bezierPath];
    
    [path setLineWidth:lineWidth];
	[path setLineCapStyle:NSSquareLineCapStyle];
	[path moveToPoint:begin];
    
    [path appendBezierPathWithOvalInRect:NSMakeRect(begin.x, begin.y, end.x - begin.x, end.y - begin.y)];
    
	return path;
}

- (NSBezierPath *)performDrawAtPoint:(NSPoint)point
					   withMainImage:(NSBitmapImageRep *)mainImage
						 bufferImage:(NSBitmapImageRep *)bufferImage
						  mouseEvent:(UInt8)mouseEvent {
    
    @autoreleasepool {
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
            lastPoint = point;
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
