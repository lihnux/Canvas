//
//  HighLighterTool.m
//  Canvas
//
//  Created by Paul Li on 1/2/14.
//  Copyright (c) 2014 Paul Li. All rights reserved.
//

#import "HighLighterTool.h"
#import "ImageTools.h"

@implementation HighLighterTool

- (id)init {
    
    return [super initWithLineWidth:15 lineMinWidth:15 lineMaxWidth:30 foregroundColor:[NSColor colorWithCalibratedRed:0.0 green:0.0 blue:1.0 alpha:0.6] backgroundColor:nil];
}

@end
