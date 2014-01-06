//
//  EraserTool.m
//  Canvas
//
//  Created by Paul Li on 1/2/14.
//  Copyright (c) 2014 Paul Li. All rights reserved.
//

#import "EraserTool.h"

@implementation EraserTool

- (id)init {
    
    return [super initWithLineWidth:10 lineMinWidth:5 lineMaxWidth:20 foregroundColor:[NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:1.0] backgroundColor:[NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
}

- (NSString*)description {
    return kEraserToolbarItemID;
}


@end
