//
//  ImageTools.m
//  Canvas
//
//  Created by Paul Li on 12/26/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import "ImageTools.h"

void GCLockBitmapImage(NSBitmapImageRep *bitmapImage) {
    [NSGraphicsContext saveGraphicsState];
	[NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:bitmapImage]];
}

void GCUnlockBitmapImage(NSBitmapImageRep *bitmapImage) {
    [NSGraphicsContext restoreGraphicsState];
}

@implementation ImageTools

+ (void)initBitmapImage:(NSBitmapImageRep**)bitmapImage size:(NSSize)size backgroundColor:(NSColor*)backgroundColor{
    
	*bitmapImage = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes: nil
														pixelsWide: size.width
														pixelsHigh: size.height
													 bitsPerSample: 8
												   samplesPerPixel: 4
														  hasAlpha: YES
														  isPlanar: NO
													colorSpaceName: NSCalibratedRGBColorSpace
													   bytesPerRow: 0	// "you figure it out"
													  bitsPerPixel: 32];
	// Initialize it to a completely transparent image
	[ImageTools clearBitmapImage:*bitmapImage backgroundColor:backgroundColor];
}

+ (void)clearBitmapImage:(NSBitmapImageRep*)bitmapImage {
    [ImageTools clearBitmapImage:bitmapImage backgroundColor:nil];
}

+ (void)clearBitmapImage:(NSBitmapImageRep *)bitmapImage backgroundColor:(NSColor*)backgroundColor{
	[ImageTools clearBitmapImage:bitmapImage
                            rect:NSMakeRect(0, 0, [bitmapImage pixelsWide], [bitmapImage pixelsHigh])
                 backgroundColor:backgroundColor];
}

+ (void)clearBitmapImage:(NSBitmapImageRep *)bitmapImage rect:(NSRect)rect backgroundColor:(NSColor*)backgroundColor{
	GCLockBitmapImage(bitmapImage);
    if (backgroundColor) {
        [backgroundColor setFill];
    }
    else {
        [[NSColor clearColor] setFill];
    }
	NSRectFillUsingOperation(rect, NSCompositeCopy);
	GCUnlockBitmapImage(bitmapImage);
}

@end
