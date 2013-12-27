//
//  Canvas.m
//  Canvas
//
//  Created by Paul Li on 12/26/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import "Canvas.h"
#import "ImageDataSource.h"

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
- (void)prepareWithImageDataSource:(ImageDataSource *)anImageDataSource {
    self.imageDataSource = anImageDataSource;
}

#pragma mark - Mouse Events

- (void)mouseDown:(NSEvent *)event
{
    /*
	isPayingAttention = YES;
	NSPoint p = [event locationInWindow];
	NSPoint downPoint = [self convertPoint:p fromView:nil];
	
	// Necessary for when the view is zoomed above 100%
	currentPoint.x = floor(downPoint.x);
	currentPoint.y = floor(downPoint.y);
    
	[[toolbox currentTool] setSavedPoint:currentPoint];
	
	// If it's shifted, do something about it
	[[toolbox currentTool] setFlags:[event modifierFlags]];
	[[toolbox currentTool] performDrawAtPoint:currentPoint
                                withMainImage:[dataSource mainImage]
                                  bufferImage:[dataSource bufferImage]
                                   mouseEvent:MOUSE_DOWN];
	
	[self setNeedsDisplayInRect:[[toolbox currentTool] invalidRect]];
     */
}

- (void)mouseDragged:(NSEvent *)event
{
    /*
	if (isPayingAttention)
	{
		NSPoint p = [event locationInWindow];
		NSPoint dragPoint = [self convertPoint:p fromView:nil];
		
		// Necessary for when the view is zoomed above 100%
		currentPoint.x = floor(dragPoint.x);
		currentPoint.y = floor(dragPoint.y);
		
		[[toolbox currentTool] setFlags:[event modifierFlags]];
		[[toolbox currentTool] performDrawAtPoint:currentPoint
									withMainImage:[dataSource mainImage]
									  bufferImage:[dataSource bufferImage]
									   mouseEvent:MOUSE_DRAGGED];
		
		[self setNeedsDisplayInRect:[[toolbox currentTool] invalidRect]];
	}
     */
}

- (void)mouseUp:(NSEvent *)event
{
    /*
	if (isPayingAttention)
	{
		NSPoint p = [event locationInWindow];
		NSPoint upPoint = [self convertPoint:p fromView:nil];
		
		// Necessary for when the view is zoomed above 100%
		currentPoint.x = floor(upPoint.x);
		currentPoint.y = floor(upPoint.y);
		[[toolbox currentTool] setFlags:[event modifierFlags]];
		NSBezierPath *path = [[toolbox currentTool] performDrawAtPoint:currentPoint
														 withMainImage:[dataSource mainImage]
														   bufferImage:[dataSource bufferImage]
															mouseEvent:MOUSE_UP];
		
		if (path) {
			expPath = path;
		}
		
		[self setNeedsDisplayInRect:[[toolbox currentTool] invalidRect]];
	}
     */
}

@end
