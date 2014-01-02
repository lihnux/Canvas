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

#pragma mark - Implement Drawing Methods

- (NSBezierPath *)pathFromPoint:(NSPoint)begin toPoint:(NSPoint)end {
    
    path = [NSBezierPath bezierPath];
    
    [path setLineWidth:lineWidth];
    
	[path moveToPoint:begin];
    [path lineToPoint:end];
    
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
        
        [path stroke];
        
        GCUnlockBitmapImage(drawToImage);
    }
    
	return nil;
}

@end
