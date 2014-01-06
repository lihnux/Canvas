//
//  OverlayWindowController.h
//  Canvas
//
//  Created by Paul Li on 1/6/14.
//  Copyright (c) 2014 Paul Li. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ImageDataSource;
@class Canvas;
@class OverlayToolboxController;

@interface OverlayWindowController : NSWindowController {
    ImageDataSource *imageDataSource;
    
    IBOutlet Canvas                     *ib_canvas;
    IBOutlet OverlayToolboxController   *ib_overlayToolboxController;
}

- (void)cleanCanvas;
- (BOOL)overlayWindowCanBecomeKeyWindow;

@end
