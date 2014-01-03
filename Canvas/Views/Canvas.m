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

- (BOOL)acceptsFirstResponder {
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
	
	// If it's shifted, do something about it
	[controller.currentTool performDrawAtPoint:downPoint
                                 withMainImage:imageDataSource.mainImage
                                   bufferImage:imageDataSource.bufferImage
                                    mouseEvent:mouseDownEvent
                                          view:self];
    
    [self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)event
{
    NSPoint p = [event locationInWindow];
    NSPoint dragPoint = [self convertPoint:p fromView:nil];
    
    [controller.currentTool performDrawAtPoint:dragPoint
                                 withMainImage:imageDataSource.mainImage
                                   bufferImage:imageDataSource.bufferImage
                                    mouseEvent:mouseDragEvent
                                          view:self];
		
    [self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)event
{
    NSPoint p = [event locationInWindow];
    NSPoint upPoint = [self convertPoint:p fromView:nil];
    
    [controller.currentTool performDrawAtPoint:upPoint
                                 withMainImage:imageDataSource.mainImage
                                   bufferImage:imageDataSource.bufferImage
                                    mouseEvent:mouseUpEvent
                                          view:self];
    
    
    [self setNeedsDisplay:YES];
}

#pragma mark - Key Event
- (void)keyDown:(NSEvent *)theEvent {
    
    NSString *chars = theEvent.charactersIgnoringModifiers;
    unichar aChar = [chars characterAtIndex: 0];
    
    switch (aChar) {
        case 3:
        case 13: // Enter Key Event
            break;
        case 127: // Delete Key Event
            break;
        default:
            break;
    }
    
    NSLog(@"Key down");
    
}


@end
