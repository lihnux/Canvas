//
//  ImageDataSource.h
//  Canvas
//
//  Created by Paul Li on 12/26/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDataSource : NSObject {
    
    NSBitmapImageRep    *mainImage;
    NSBitmapImageRep    *bufferImage;
    
    NSSize              imageSize;
}

@property (nonatomic, readonly) NSBitmapImageRep    *mainImage;
@property (nonatomic, readonly) NSBitmapImageRep    *bufferImage;

- (id)initWithSize:(NSSize)aImageSize;
- (id)initWithSize:(NSSize)aImageSize mainImageBackgroundColor:(NSColor*)mainBackgroundColor bufferImageBackgroundColor:(NSColor*)bufferBackgroundColor;

- (void)renderToContext:(CGContextRef)context withFrame:(NSRect)frame;

@end
