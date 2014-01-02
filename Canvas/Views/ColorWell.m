//
//  ColorWell.m
//  Canvas
//
//  Created by Paul Li on 1/2/14.
//  Copyright (c) 2014 Paul Li. All rights reserved.
//

#import "ColorWell.h"

@implementation ColorWell

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)dealloc {
    [alphaBkgImage release];
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    
    NSBezierPath *path = [NSBezierPath bezierPathWithRect:dirtyRect];
    
    if (alphaBkgImage == nil) {
        alphaBkgImage = [[NSImage imageNamed:@"bkgImage.png"] retain];
    }
    
    // Fill the background
    if (self.color.alphaComponent == 0.0) {
        [[NSColor colorWithPatternImage:alphaBkgImage] setFill];
    }
    else {
        [[NSColor whiteColor] setFill];
    }
    NSRectFill(dirtyRect);
	
    // The fill the color
	[[self color] setFill];
	[path fill];
}

@end
