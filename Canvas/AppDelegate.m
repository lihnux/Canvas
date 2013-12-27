//
//  AppDelegate.m
//  Canvas
//
//  Created by Paul Li on 12/26/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import "AppDelegate.h"
#import "DrawingBoardController.h"

@implementation AppDelegate

@synthesize drawingBoardController;

- (void)dealloc {
    
    [drawingBoardController release];
    
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.drawingBoardController = [[DrawingBoardController alloc] init];
    [drawingBoardController showWindow:self];
}

@end
