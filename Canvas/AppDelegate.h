//
//  AppDelegate.h
//  Canvas
//
//  Created by Paul Li on 12/26/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DrawingBoardController;

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    DrawingBoardController *drawingBoardController;
}

@property (nonatomic, strong) DrawingBoardController *drawingBoardController;

@end
