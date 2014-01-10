//
//  DrawingBoardController.m
//  Canvas
//
//  Created by Paul Li on 12/26/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import "ImageDataSource.h"
#import "Canvas.h"

#import "ImageTools.h"

#import "PenTool.h"
#import "RectangleTool.h"
#import "EllipseTool.h"
#import "LineTool.h"
#import "HighLighterTool.h"
#import "EraserTool.h"
#import "TextTool.h"

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
        self.toolList = [NSDictionary dictionaryWithObjectsAndKeys: [[PenTool alloc] init],         kPenToolbarItemID,
                                                                    [[RectangleTool alloc] init],   kRectangleToolbarItemID,
                                                                    [[EllipseTool alloc] init],     kEllipseToolbarItemID,
                                                                    [[LineTool alloc] init],        kLineToolbarItemID,
                                                                    [[HighLighterTool alloc] init], kHighLighterToolbarItemID,
                                                                    [[EraserTool alloc] init],      kEraserToolbarItemID,
                                                                    [[TextTool alloc] init],        kTextToolbarItemID,
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
    [ib_canvas prepareWithFrame:NSMakeSize(1024, 768) controller:self];
    [ib_canvas setNeedsDisplay:YES];
    
    [self.window center];
}

#pragma mark - Override Methods

- (IBAction)onClean:(id)sender {
    
    [ib_canvas clearMainLayer];
    [ib_canvas setNeedsDisplay:YES];
}

#pragma mark - Override the toolbar items

- (NSArray*)toolbarItems {
    return [NSArray arrayWithObjects:   kPenToolbarItemID, kHighLighterToolbarItemID,
                                        kLineToolbarItemID, kRectangleToolbarItemID, kEllipseToolbarItemID,
                                        kTextToolbarItemID, kEraserToolbarItemID, kCleanToolbarItemID,
                                        NSToolbarSeparatorItemIdentifier,
                                        kColorsToolbarItemID, kLineWidthToolbarItemID,
            nil];
}

- (NSArray*)toolbarSelectableItems {
    return [NSArray arrayWithObjects:   kPenToolbarItemID, kHighLighterToolbarItemID,
                                        kLineToolbarItemID, kRectangleToolbarItemID, kEllipseToolbarItemID,
                                        kTextToolbarItemID, kEraserToolbarItemID,
            nil];
}

@end
