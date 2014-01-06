//
//  OverlayToolboxController.h
//  Canvas
//
//  Created by Paul Li on 1/6/14.
//  Copyright (c) 2014 Paul Li. All rights reserved.
//

#import "BaseDrawingWindowController.h"

@class OverlayWindowController;

@interface OverlayToolboxController : BaseDrawingWindowController {
    OverlayWindowController *overlayWindowController;
}

@property (nonatomic, assign) OverlayWindowController *overlayWindowController;

- (void)initTools;

@end
