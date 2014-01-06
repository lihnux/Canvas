//
//  OverlayToolboxController.m
//  Canvas
//
//  Created by Paul Li on 1/6/14.
//  Copyright (c) 2014 Paul Li. All rights reserved.
//

#import "OverlayToolboxController.h"
#import "OverlayWindowController.h"

#import "DrawingTool.h"
#import "SelectTool.h"
#import "PenTool.h"
#import "RectangleTool.h"
#import "EllipseTool.h"
#import "LineTool.h"
#import "HighLighterTool.h"
#import "OverlayEraserTool.h"
#import "TextTool.h"

#import "ImageTools.h"

@implementation OverlayToolboxController

@synthesize overlayWindowController;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

#pragma mark - Override Methods

- (void)changeCurrentToolWithString:(NSString*)string {
    [super changeCurrentToolWithString:string];
    
    if ([string isEqualToString:kSelectToolbarItemID]) {
        [overlayWindowController.window setIgnoresMouseEvents:YES];
    }
    else {
        [overlayWindowController.window setIgnoresMouseEvents:NO];
    }
}

- (IBAction)onClean:(id)sender {
    [overlayWindowController cleanCanvas];
}

#pragma mark - Public Methods

- (void)initTools {
    // Init the tools
    self.toolList = [NSDictionary dictionaryWithObjectsAndKeys: [[SelectTool alloc] init],          kSelectToolbarItemID,
                                                                [[PenTool alloc] init],             kPenToolbarItemID,
                                                                [[RectangleTool alloc] init],       kRectangleToolbarItemID,
                                                                [[EllipseTool alloc] init],         kEllipseToolbarItemID,
                                                                [[LineTool alloc] init],            kLineToolbarItemID,
                                                                [[HighLighterTool alloc] init],     kHighLighterToolbarItemID,
                                                                [[OverlayEraserTool alloc] init],   kEraserToolbarItemID,
                                                                [[TextTool alloc] init],            kTextToolbarItemID,
                     nil];
    
    // Set the current tool
    [self changeCurrentToolWithString:kSelectToolbarItemID];
    [ib_toolbar setSelectedItemIdentifier:kSelectToolbarItemID];
}

@end
