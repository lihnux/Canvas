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
	[super drawRect:dirtyRect];
	
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

#pragma mark - Public Methods
- (void)prepareWithImageDataSource:(ImageDataSource *)anImageDataSource controller:(BaseDrawingWindowController*)aController{
    self.imageDataSource = anImageDataSource;
    controller = aController;
}

#pragma mark - Mouse Events

- (void)mouseDown:(NSEvent *)event
{
	NSPoint p = [event locationInWindow];
	NSPoint downPoint = [self convertPoint:p fromView:nil];
	
	// Necessary for when the view is zoomed above 100%
    //NSPoint currentPoint = NSMakePoint(floor(downPoint.x), floor(downPoint.y));
	
	// If it's shifted, do something about it
	[controller.currentTool performDrawAtPoint:downPoint
                                 withMainImage:imageDataSource.mainImage
                                   bufferImage:imageDataSource.bufferImage
                                    mouseEvent:mouseDownEvent];
    
    [self setNeedsDisplay:YES];
	
	//[self setNeedsDisplayInRect:[[toolbox currentTool] invalidRect]];
}

- (void)mouseDragged:(NSEvent *)event
{

    NSPoint p = [event locationInWindow];
    NSPoint dragPoint = [self convertPoint:p fromView:nil];
    
    //NSPoint currentPoint = NSMakePoint(floor(dragPoint.x), floor(dragPoint.y));
    
    [controller.currentTool performDrawAtPoint:dragPoint
                                 withMainImage:imageDataSource.mainImage
                                   bufferImage:imageDataSource.bufferImage
                                    mouseEvent:mouseDragEvent];
		
    [self setNeedsDisplay:YES];
	
	//[self setNeedsDisplayInRect:[[toolbox currentTool] invalidRect]];
}

- (void)mouseUp:(NSEvent *)event
{
    NSPoint p = [event locationInWindow];
    NSPoint upPoint = [self convertPoint:p fromView:nil];
    
    //NSPoint currentPoint = NSMakePoint(floor(dragPoint.x), floor(dragPoint.y));
    
    [controller.currentTool performDrawAtPoint:upPoint
                                 withMainImage:imageDataSource.mainImage
                                   bufferImage:imageDataSource.bufferImage
                                    mouseEvent:mouseUpEvent];
    
    
    [self setNeedsDisplay:YES];
	
	//[self setNeedsDisplayInRect:[[toolbox currentTool] invalidRect]];
}

@end
