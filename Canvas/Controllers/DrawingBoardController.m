//
//  DrawingBoardController.m
//  Canvas
//
//  Created by Paul Li on 12/26/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import "ImageDataSource.h"
#import "Canvas.h"

#import "PenTool.h"
#import "RectangleTool.h"

#import "DrawingBoardController.h"

@implementation DrawingBoardController

- (id)init {
    self = [super initWithWindowNibName:@"DrawingBoard"];
    
    return self;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        
        // Init the tools
        self.toolList = [NSDictionary dictionaryWithObjectsAndKeys: [[PenTool alloc] init], kPenToolbarItemID,
                                                                    [[RectangleTool alloc] init], kRectangleToolbarItemID,
                         nil];
        
        // Set the current tool
        [self changeCurrentToolWithString:kPenToolbarItemID];
    }
    return self;
}

- (void)dealloc {
    
    [imageDataSource release];
    
    [super dealloc];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [ib_toolbar setSelectedItemIdentifier:kPenToolbarItemID];
    
    imageDataSource = [[ImageDataSource alloc] initWithSize:[ib_canvas frame].size];
    [ib_canvas prepareWithImageDataSource:imageDataSource controller:self];
    [ib_canvas setNeedsDisplay:YES];
    
    [self.window center];
}

#pragma mark - Override the toolbar items

- (NSArray*)toolbarItems {
    return [NSArray arrayWithObjects:   kPenToolbarItemID, kHighLighterToolbarItemID,
                                        kLineToolbarItemID, kRectangleToolbarItemID, kEllipseToolbarItemID,
                                        kTextToolbarItemID, kEraserToolbarItemID, kCleanToolbarItemID,
                                        NSToolbarSeparatorItemIdentifier,
                                        kLineWidthToolbarItemID, kFontToolbarItemID, kColorsToolbarItemID,
            nil];
}

- (NSArray*)toolbarSelectableItems {
    return [NSArray arrayWithObjects:   kPenToolbarItemID, kHighLighterToolbarItemID,
                                        kLineToolbarItemID, kRectangleToolbarItemID, kEllipseToolbarItemID,
                                        kTextToolbarItemID, kEraserToolbarItemID,
            nil];
}

@end
