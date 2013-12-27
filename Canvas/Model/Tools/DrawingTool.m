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

- (void)dealloc {
    [foregroundColor    release];
    [backgroundColor    release];
    
    [path               release];
    
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

@end
