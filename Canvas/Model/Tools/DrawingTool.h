//
//  DrawingTool.h
//  Canvas
//
//  Created by Paul Li on 12/27/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseDrawingWindowController;

#define kLineWidthKey               @"lineWidth"
#define kForegroundColorKey         @"foregroundColor"
#define kBackgroundColorKey         @"backgroundColor"
#define kFontFamilyKey              @"fontFamily"
#define kFontSizeKey                @"fontSize"
#define kFontBoldKey                @"bold"
#define kFontItalicKey              @"italic"
#define kFontUnderlineKey           @"underline"

/////////////////////////////////////////////////

#define kSelectToolbarItemID        @"Select"
#define kPenToolbarItemID           @"Pen"
#define kHighLighterToolbarItemID   @"HighLighter"
#define kLineToolbarItemID          @"Line"
#define kRectangleToolbarItemID     @"Rectangle"
#define kEllipseToolbarItemID       @"Ellipse"
#define kTextToolbarItemID          @"Text"
#define kEraserToolbarItemID        @"Eraser"
#define kCleanToolbarItemID         @"Clean"
#define kLineWidthToolbarItemID     @"Stroke"
#define kColorsToolbarItemID        @"Colors"
#define kFontToolbarItemID          @"Font"

/////////////////////////////////////////////////

enum {
    mouseDownEvent  = 1,
    mouseDragEvent  = 2,
    mouseUpEvent    = 3,
};

@interface DrawingTool : NSObject {
    NSColor             *foregroundColor;
    NSColor             *backgroundColor;
    
    NSUInteger          lineWidth;
    NSUInteger          lineMinWidth;
    NSUInteger          lineMaxWidth;
    
    NSBitmapImageRep    *mainImage;
    NSBitmapImageRep    *bufferImage;
    NSView              *canvas;
    
    NSBezierPath        *path;
    
    NSPoint             lastPoint;
    
    BOOL                drawing;
}

@property (nonatomic, strong) NSColor       *foregroundColor;
@property (nonatomic, strong) NSColor       *backgroundColor;
@property (nonatomic, assign) NSUInteger    lineWidth;
@property (nonatomic, assign) NSUInteger    lineMinWidth;
@property (nonatomic, assign) NSUInteger    lineMaxWidth;

- (id)initWithForegroundColor:(NSColor*)aForegroundColor backgroundColor:(NSColor*)aBackgroundColor;
- (id)initWithLineWidth:(NSUInteger)aLineWidth lineMinWidth:(NSUInteger)aLineMinWidth lineMaxWidth:(NSUInteger)aLineMaxWidth foregroundColor:(NSColor*)aForegroundColor backgroundColor:(NSColor*)aBackgroundColor;

- (void)addObserverWithWindowController:(BaseDrawingWindowController*)controller;
- (void)removeObserverWithWindowController:(BaseDrawingWindowController*)controller;

- (void)finishDrawing;

@end

@interface DrawingTool (Abstract)
- (NSBezierPath *)pathFromPoint:(NSPoint)begin toPoint:(NSPoint)end;
- (NSBezierPath *)performDrawAtPoint:(NSPoint)point
					   withMainImage:(NSBitmapImageRep *)aMainImage
						 bufferImage:(NSBitmapImageRep *)aBufferImage
						  mouseEvent:(UInt8)mouseEvent
                                view:(NSView*)fromView;
@end
