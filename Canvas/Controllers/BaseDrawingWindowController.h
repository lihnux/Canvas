//
//  BaseDrawingWindowController.h
//  Canvas
//
//  Created by Paul Li on 12/27/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DrawingTool;

enum {
    // H -- Host, P -- Participant
    canvasForWhiteboardH = 1,
    canvasForWhiteboardP = 2,
    canvasForAnnotationH = 3,
    canvasForAnnotationP = 4,
};

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

@interface BaseDrawingWindowController : NSWindowController<NSToolbarDelegate> {
    
    NSColor *foregroundColor;
    NSColor *backgroundColor;
    NSUInteger lineWidth;
    
    DrawingTool     *currentTool;
    NSDictionary    *toolList;
    
    IBOutlet NSToolbar  *ib_toolbar;
    
    IBOutlet NSView     *ib_strokeView;
    IBOutlet NSView     *ib_colorsView;
    IBOutlet NSView     *ib_fontView;
}

@property (nonatomic, strong) NSColor       *foregroundColor;
@property (nonatomic, strong) NSColor       *backgroundColor;
@property (nonatomic, assign) NSUInteger    lineWidth;
@property (nonatomic, assign) DrawingTool   *currentTool;
@property (nonatomic, strong) NSDictionary  *toolList;

- (NSArray*)toolbarItems;
- (NSArray*)toolbarSelectableItems;
- (void)changeCurrentToolWithString:(NSString*)string;

- (IBAction)onToolToggle:(id)sender;
- (IBAction)onClean:(id)sender;

@end
