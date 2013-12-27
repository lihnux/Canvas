//
//  DrawingTool.h
//  Canvas
//
//  Created by Paul Li on 12/27/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseDrawingWindowController;

#define kLineWidthKey       @"lineWidth"
#define kForegroundColorKey @"foregroundColor"
#define kBackgroundColorKey @"backgroundColor"

enum {
    mouseDownEvent  = 1,
    mouseDragEvent  = 2,
    mouseUpEvent    = 3,
};

@interface DrawingTool : NSObject {
    NSColor     *foregroundColor;
    NSColor     *backgroundColor;
    NSUInteger  lineWidth;
    
    //NSBitmapImageRep *mainImage;
    //NSBitmapImageRep *bufferImage;
    
    NSPoint lastPoint;
}

@property (nonatomic, strong) NSColor       *foregroundColor;
@property (nonatomic, strong) NSColor       *backgroundColor;
@property (nonatomic, assign) NSUInteger    lineWidth;

- (void)addObserverWithWindowController:(BaseDrawingWindowController*)controller;
- (void)removeObserverWithWindowController:(BaseDrawingWindowController*)controller;

@end
