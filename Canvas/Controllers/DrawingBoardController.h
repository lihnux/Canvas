//
//  DrawingBoardController.h
//  Canvas
//
//  Created by Paul Li on 12/26/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BaseDrawingWindowController.h"

@class ImageDataSource;
@class Canvas;

@interface DrawingBoardController : BaseDrawingWindowController {
    
    IBOutlet Canvas *ib_canvas;
}

@end
