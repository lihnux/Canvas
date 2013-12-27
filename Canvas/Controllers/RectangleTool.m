//
//  RectangleTool.m
//  Canvas
//
//  Created by Paul Li on 12/27/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import "RectangleTool.h"

@implementation RectangleTool

- (id)init {
    self = [super init];
    
    if (self) {
        self.foregroundColor = [NSColor colorWithCalibratedRed:1.0 green:0.0 blue:0.0 alpha:1.0];
        self.backgroundColor = [NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.lineWidth = 2;
    }
    return self;
}

@end
