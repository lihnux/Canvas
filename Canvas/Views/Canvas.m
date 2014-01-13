//
//  Canvas.m
//  Canvas
//
//  Created by Paul Li on 12/26/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import "Canvas.h"
#import "ImageDataSource.h"
#import "DrawingTool.h"
#import "BaseDrawingWindowController.h"

@implementation Canvas

#pragma mark - Override method

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)dealloc {
    
    CGLayerRelease(mainLayer);
    
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
    
    if (dirtyRect.size.width == 0 || dirtyRect.size.height == 0) {
        return;
    }
    
    [[NSColor clearColor] setFill];
    NSRectFill(dirtyRect);
    
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    
    
    if (controller.currentTool.needUpdateToMainLayer) {
        CGContextRef layerContext = CGLayerGetContext(mainLayer);
        
        [NSGraphicsContext saveGraphicsState];
        [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithGraphicsPort:layerContext flipped:NO]];
        
        [controller.currentTool drawOnMainLayer];
        
        [NSGraphicsContext restoreGraphicsState];
    }
    
    CGContextDrawLayerAtPoint(context, CGPointMake(0, 0), mainLayer);
    
    [controller.currentTool drawOnView];
}

- (BOOL)isFlipped {
    return YES;
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

#pragma mark - Public Methods

- (void)prepareWithFrame:(NSSize)size controller:(BaseDrawingWindowController*)aController {
    
    if (self.frame.size.width != size.width && self.frame.size.height != size.height) {
        self.frame = NSMakeRect(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    }
    
    controller = aController;
    
    [self clearMainLayer];
}

- (void)clearMainLayer {
    
    if (mainLayer == NULL) {
        CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
        mainLayer = CGLayerCreateWithContext(context, NSSizeToCGSize(self.frame.size), NULL);
    }
    
    CGContextRef layerContext = CGLayerGetContext(mainLayer);
    CGContextSetRGBFillColor (layerContext, 1.0, 1.0, 1.0, 0.0);
    CGContextFillRect(layerContext, CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height));
}

#pragma mark - Mouse Events

- (void)mouseDown:(NSEvent *)event {
	[controller.currentTool performDrawWithEvent:event view:self];
}

- (void)mouseDragged:(NSEvent *)event {
    [controller.currentTool performDrawWithEvent:event view:self];
		
    [self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)event {
    [controller.currentTool performDrawWithEvent:event view:self];
    
    [self setNeedsDisplay:YES];
}

@end
