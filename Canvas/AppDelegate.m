//
//  AppDelegate.m
//  Canvas
//
//  Created by Paul Li on 12/26/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import "AppDelegate.h"
#import "DrawingBoardController.h"
#import "OverlayWindowController.h"

@implementation AppDelegate

@synthesize drawingBoardController;
@synthesize overlayWindowController;

- (void)dealloc {
    
    [drawingBoardController release];
    [overlayWindowController release];
    
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    //self.drawingBoardController = [[DrawingBoardController alloc] init];
    //[drawingBoardController showWindow:self];
    self.overlayWindowController = [[OverlayWindowController alloc] init];
    [overlayWindowController showWindow:self];
    
    [[NSColorPanel sharedColorPanel] setShowsAlpha:YES];
}

@end
