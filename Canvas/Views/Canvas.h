//
//  Canvas.h
//  Canvas
//
//  Created by Paul Li on 12/26/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ImageDataSource;
@class BaseDrawingWindowController;

@interface Canvas : NSView {
    ImageDataSource             *imageDataSource;
    BaseDrawingWindowController *controller;
    
    BOOL                        overlay;
}

@property (nonatomic, assign) ImageDataSource   *imageDataSource;
@property (nonatomic, assign) BOOL              overlay;

- (void)prepareWithImageDataSource:(ImageDataSource*)anImageDataSource controller:(BaseDrawingWindowController*)aController;

@end
