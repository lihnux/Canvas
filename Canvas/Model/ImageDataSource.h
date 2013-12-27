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

- (id)initWithSize:(NSSize)aImageSize;

- (void)renderToContext:(CGContextRef)context withFrame:(NSRect)frame;

@end
