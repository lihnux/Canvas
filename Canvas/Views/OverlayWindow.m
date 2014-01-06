//
//  OverlayWindow.m
//  Canvas
//
//  Created by Paul Li on 1/6/14.
//  Copyright (c) 2014 Paul Li. All rights reserved.
//

#import "OverlayWindow.h"
#import "OverlayWindowController.h"

@implementation OverlayWindow

- (BOOL)canBecomeKeyWindow {
    
    OverlayWindowController *controller = (OverlayWindowController*)self.delegate;
    return [controller overlayWindowCanBecomeKeyWindow];
}

@end
