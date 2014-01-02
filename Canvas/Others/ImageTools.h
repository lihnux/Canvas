//
//  ImageTools.h
//  Canvas
//
//  Created by Paul Li on 12/26/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import <Foundation/Foundation.h>

void GCLockBitmapImage(NSBitmapImageRep *bitmapImage);
void GCUnlockBitmapImage(NSBitmapImageRep *bitmapImage);

@interface ImageTools : NSObject

+ (void)initBitmapImage:(NSBitmapImageRep**)bitmapImage size:(NSSize)size backgroundColor:(NSColor*)backgroundColor;
+ (void)clearBitmapImage:(NSBitmapImageRep*)bitmapImage;
+ (void)clearBitmapImage:(NSBitmapImageRep*)bitmapImage backgroundColor:(NSColor*)backgroundColor;
+ (void)clearBitmapImage:(NSBitmapImageRep*)bitmapImage rect:(NSRect)rect backgroundColor:(NSColor*)backgroundColor;

+ (void)drawToImage:(NSBitmapImageRep *)dest fromImage:(NSBitmapImageRep *)src withComposition:(BOOL)shouldCompositeOver;
+ (void)drawToImage:(NSBitmapImageRep *)dest fromImage:(NSBitmapImageRep *)src atPoint:(NSPoint)point withComposition:(BOOL)shouldCompositeOver;

@end
