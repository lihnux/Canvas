//
//  OverlayWindow.m
//  Canvas
//
//  Created by Paul Li on 1/6/14.
//  Copyright (c) 2014 Paul Li. All rights reserved.
//

#import "OverlayWindow.h"

@implementation OverlayWindow

- (BOOL)becomeFirstResponder {
    return YES;
}

- (BOOL)ignoresMouseEvents {
    return YES;
}

@end
