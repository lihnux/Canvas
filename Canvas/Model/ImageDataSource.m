//
//  ImageDataSource.m
//  Canvas
//
//  Created by Paul Li on 12/26/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import "ImageDataSource.h"
#import "ImageTools.h"

@implementation ImageDataSource

@synthesize mainImage;
@synthesize bufferImage;

#pragma mark - Life Cycle
- (id)initWithSize:(NSSize)aImageSize {
    
    return [self initWithSize:aImageSize mainImageBackgroundColor:[NSColor colorWithCalibratedWhite:1.0 alpha:1.0] bufferImageBackgroundColor:nil];
}

- (id)initWithSize:(NSSize)aImageSize mainImageBackgroundColor:(NSColor*)mainBackgroundColor bufferImageBackgroundColor:(NSColor*)bufferBackgroundColor {
    
    self = [super init];
    
    if (self) {
        imageSize = aImageSize;
        
        [ImageTools initBitmapImage:&mainImage      size:imageSize backgroundColor:mainBackgroundColor];
        [ImageTools initBitmapImage:&bufferImage    size:imageSize backgroundColor:bufferBackgroundColor];
    }
    
    return self;
}

- (void)dealloc {
    
    [mainImage      release];
    [bufferImage    release];
    
    [super dealloc];
}

#pragma mark - Drawing

- (void)renderToContext:(CGContextRef)context withFrame:(NSRect)frame{
    
	[NSGraphicsContext saveGraphicsState];
    
	// If you don't do this, the image looks blurry when zoomed in
	[[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationNone];
	
	// Draw the NSBitmapImageRep to the view
	if (mainImage) {
		CGContextDrawImage(context, NSRectToCGRect((NSRect){NSZeroPoint, [mainImage size]}), [mainImage CGImage]);
    }
	
	// If there's an overlay image being used at the moment, draw it
	if (bufferImage) {
		CGContextDrawImage(context, NSRectToCGRect((NSRect){NSZeroPoint, [bufferImage size]}), [bufferImage CGImage]);
	}
	
	[NSGraphicsContext restoreGraphicsState];
}

@end
