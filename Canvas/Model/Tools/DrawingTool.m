//
//  DrawingTool.m
//  Canvas
//
//  Created by Paul Li on 12/27/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import "DrawingTool.h"

@implementation DrawingTool

@synthesize foregroundColor;
@synthesize backgroundColor;
@synthesize lineWidth;
@synthesize lineMinWidth;
@synthesize lineMaxWidth;

- (id)init {
    return [self initWithForegroundColor:nil backgroundColor:nil];
}

- (id)initWithForegroundColor:(NSColor*)aForegroundColor backgroundColor:(NSColor*)aBackgroundColor {
    return [self initWithLineWidth:3 lineMinWidth:1 lineMaxWidth:15 foregroundColor:aForegroundColor backgroundColor:aBackgroundColor];
}

- (id)initWithLineWidth:(NSUInteger)aLineWidth lineMinWidth:(NSUInteger)aLineMinWidth lineMaxWidth:(NSUInteger)aLineMaxWidth foregroundColor:(NSColor*)aForegroundColor backgroundColor:(NSColor*)aBackgroundColor {
    self = [super init];
    
    if (self) {
        
        self.foregroundColor    = (aForegroundColor == nil) ? [NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:1.0] : aForegroundColor;
        self.backgroundColor    = (aBackgroundColor == nil) ? [NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:1.0] : aBackgroundColor;
        self.lineWidth          = aLineWidth;
        self.lineMinWidth       = aLineMinWidth;
        self.lineMaxWidth       = aLineMaxWidth;
    }
    
    return self;
}

- (void)dealloc {
    
    [foregroundColor        release];
    [backgroundColor        release];
    
    [path                   release];
    
    [super dealloc];
}

- (void)addObserverWithWindowController:(BaseDrawingWindowController*)controller {
    
    [controller addObserver:self
                 forKeyPath:kLineWidthKey
                    options:NSKeyValueObservingOptionNew
                    context:NULL];
    
    [controller addObserver:self
                 forKeyPath:kForegroundColorKey
                    options:NSKeyValueObservingOptionNew
                    context:NULL];
    
    [controller addObserver:self
                 forKeyPath:kBackgroundColorKey
                    options:NSKeyValueObservingOptionNew
                    context:NULL];
}

- (void)removeObserverWithWindowController:(BaseDrawingWindowController*)controller {
    [controller removeObserver:self forKeyPath:kLineWidthKey];
    [controller removeObserver:self forKeyPath:kForegroundColorKey];
    [controller removeObserver:self forKeyPath:kBackgroundColorKey];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
						change:(NSDictionary *)change
					   context:(void *)context
{
	id value = [change objectForKey:NSKeyValueChangeNewKey];
	
	if ([keyPath isEqualToString:kLineWidthKey]) {
		[self setLineWidth:[value integerValue]];
	}
    else if ([keyPath isEqualToString:kForegroundColorKey]) {
		[self setForegroundColor:value];
	}
    else if ([keyPath isEqualToString:kBackgroundColorKey]) {
		[self setBackgroundColor:value];
	}
}

- (void)finishDrawing {
    if (drawing) {
        [self performDrawAtPoint:lastPoint withMainImage:mainImage bufferImage:bufferImage mouseEvent:mouseUpEvent view:canvas];
        [canvas setNeedsDisplay:YES];
        
        drawing = NO;
    }
}

@end
