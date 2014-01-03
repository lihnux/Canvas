//
//  BaseDrawingWindowController.h
//  Canvas
//
//  Created by Paul Li on 12/27/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DrawingTool;
@class ImageDataSource;

enum {
    // H -- Host, P -- Participant
    canvasForWhiteboardH = 1,
    canvasForWhiteboardP = 2,
    canvasForAnnotationH = 3,
    canvasForAnnotationP = 4,
};

@interface BaseDrawingWindowController : NSWindowController<NSToolbarDelegate> {
    
    ImageDataSource *imageDataSource;
    
    NSColor     *foregroundColor;
    NSColor     *backgroundColor;
    
    NSUInteger  lineWidth;
    NSUInteger  lineMinWidth;
    NSUInteger  lineMaxWidth;
    
    NSString    *fontFamily;
    NSString    *fontSize;
    BOOL        bold;
    BOOL        italic;
    BOOL        underline;
    
    DrawingTool     *currentTool;
    NSDictionary    *toolList;
    
    IBOutlet NSToolbar  *ib_toolbar;
    
    IBOutlet NSView     *ib_strokeView;
    IBOutlet NSView     *ib_colorsView;
    IBOutlet NSView     *ib_fontView;
}

@property (nonatomic, strong)   NSColor         *foregroundColor;
@property (nonatomic, strong)   NSColor         *backgroundColor;
@property (nonatomic, assign)   NSUInteger      lineWidth;
@property (nonatomic, assign)   NSUInteger      lineMinWidth;
@property (nonatomic, assign)   NSUInteger      lineMaxWidth;
@property (nonatomic, copy)     NSString        *fontFamily;
@property (nonatomic, copy)     NSString        *fontSize;
@property (nonatomic, assign)   BOOL            bold;
@property (nonatomic, assign)   BOOL            italic;
@property (nonatomic, assign)   BOOL            underline;
@property (nonatomic, assign)   DrawingTool     *currentTool;
@property (nonatomic, strong)   NSDictionary    *toolList;

- (NSArray*)toolbarItems;
- (NSArray*)toolbarSelectableItems;
- (void)changeCurrentToolWithString:(NSString*)string;
- (NSUInteger)lineWidthOrFontItemIndex;

- (IBAction)onToolToggle:(id)sender;
- (IBAction)onClean:(id)sender;

@end
