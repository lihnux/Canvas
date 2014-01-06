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

@synthesize imageDataSource;
@synthesize overlay;

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
    
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
	//[super drawRect:dirtyRect];
    //if (overlay) {
        [[NSColor clearColor] setFill];
        NSRectFill(dirtyRect);
    //}
    
    if (dirtyRect.size.width != 0 && dirtyRect.size.height != 0)
	{
		//CGContextEndTransparencyLayer(cgContext);
		CGContextRef cgContext = [[NSGraphicsContext currentContext] graphicsPort];
		
		[imageDataSource renderToContext:cgContext withFrame:dirtyRect];
	}
}

- (BOOL)isFlipped {
    return YES;
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

#pragma mark - Public Methods
- (void)prepareWithImageDataSource:(ImageDataSource *)anImageDataSource controller:(BaseDrawingWindowController*)aController{
    self.imageDataSource = anImageDataSource;
    controller = aController;
}

#pragma mark - Mouse Events

- (void)mouseDown:(NSEvent *)event {
	[controller.currentTool performDrawWithEvent:event
                                   withMainImage:imageDataSource.mainImage
                                     bufferImage:imageDataSource.bufferImage
                                            view:self];
    
    [self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)event {
    [controller.currentTool performDrawWithEvent:event
                                   withMainImage:imageDataSource.mainImage
                                     bufferImage:imageDataSource.bufferImage
                                            view:self];
		
    [self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)event {
    [controller.currentTool performDrawWithEvent:event
                                   withMainImage:imageDataSource.mainImage
                                     bufferImage:imageDataSource.bufferImage
                                            view:self];
    
    
    [self setNeedsDisplay:YES];
}

@end
