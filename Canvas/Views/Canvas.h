//
//  Canvas.h
//  Canvas
//
//  Created by Paul Li on 12/26/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ImageDataSource;

@interface Canvas : NSView {
    ImageDataSource *imageDataSource;
}

@property (nonatomic, assign) ImageDataSource *imageDataSource;

- (void)prepareWithImageDataSource:(ImageDataSource*)anImageDataSource;

@end
