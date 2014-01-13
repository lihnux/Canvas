//
//  TextTool.h
//  Canvas
//
//  Created by Paul Li on 1/2/14.
//  Copyright (c) 2014 Paul Li. All rights reserved.
//

#import "DrawingTool.h"

@interface TextTool : DrawingTool<NSTextDelegate> {
    NSString    *fontFamily;
    NSString    *fontSize;
    BOOL        bold;
    BOOL        italic;
    BOOL        underline;
    
    NSString    *drawText;
    
    NSTextFieldCell *textCell;
    NSText          *textView;
}

@property (nonatomic, copy)     NSString    *fontFamily;
@property (nonatomic, copy)     NSString    *fontSize;
@property (nonatomic, assign)   BOOL        bold;
@property (nonatomic, assign)   BOOL        italic;
@property (nonatomic, assign)   BOOL        underline;
@property (nonatomic, copy)     NSString    *drawText;

@end
