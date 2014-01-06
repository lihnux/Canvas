//
//  OverlayWindowController.m
//  Canvas
//
//  Created by Paul Li on 1/6/14.
//  Copyright (c) 2014 Paul Li. All rights reserved.
//

#import "OverlayWindowController.h"
#import "Canvas.h"
#import "ImageDataSource.h"
#import "ImageTools.h"
#import "DrawingTool.h"
#import "OverlayToolboxController.h"

@implementation OverlayWindowController

- (id)init {
    self = [super initWithWindowNibName:@"OverlayWindow"];
    return self;
}

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
    
    
    [self.window setOpaque:NO];
    [self.window setHasShadow:NO];
    [self.window setFrame:[[[NSScreen screens] objectAtIndex:0] visibleFrame] display:YES animate:NO];
    [self.window setLevel:NSFloatingWindowLevel];
    [self.window setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces];
    
    ib_overlayToolboxController.overlayWindowController = self;
    [ib_overlayToolboxController initTools];
    [ib_overlayToolboxController.window setLevel:NSPopUpMenuWindowLevel];
    [ib_overlayToolboxController.window setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces];
    
    imageDataSource = [[ImageDataSource alloc] initWithSize:[ib_canvas frame].size mainImageBackgroundColor:nil bufferImageBackgroundColor:nil];
    [ib_canvas prepareWithImageDataSource:imageDataSource controller:ib_overlayToolboxController];
    [ib_canvas setOverlay:YES];
    [ib_canvas setNeedsDisplay:YES];
}

- (void)cleanCanvas {
    [ImageTools clearBitmapImage:imageDataSource.mainImage backgroundColor:[NSColor colorWithCalibratedWhite:1.0 alpha:0.0]];
    [ib_canvas setNeedsDisplay:YES];
}

- (BOOL)overlayWindowCanBecomeKeyWindow {
    if ([ib_overlayToolboxController.currentTool.description isEqualToString:kTextToolbarItemID]) {
        return YES;
    }
    
    return NO;
}

@end
