//
//  TextTool.m
//  Canvas
//
//  Created by Paul Li on 1/2/14.
//  Copyright (c) 2014 Paul Li. All rights reserved.
//

#import "TextTool.h"
#import "BaseDrawingWindowController.h"
#import "ImageTools.h"

@implementation TextTool

@synthesize fontFamily;
@synthesize fontSize;
@synthesize bold;
@synthesize italic;
@synthesize underline;

- (id)init {
    
    self = [super initWithForegroundColor:nil backgroundColor:[NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
    
    if (self) {
        self.fontFamily = @"Arial";
        self.fontSize   = @"13";
        self.bold       = NO;
        self.italic     = NO;
        self.underline  = NO;
        
        textCell = [[NSTextFieldCell alloc] initTextCell:@""];
        textView = [[NSText alloc] init];
    }
    return self;
}

- (NSString*)description {
    return kTextToolbarItemID;
}

- (void)dealloc {
    [textCell release];
    [textView release];
    [super dealloc];
}

#pragma mark - Override the add/remove observer methods

- (void)addObserverWithWindowController:(BaseDrawingWindowController*)controller {
    
    [controller addObserver:self
                 forKeyPath:kLineWidthKey
                    options:NSKeyValueObservingOptionNew
                    context:NULL];
    
    [controller addObserver:self
                 forKeyPath:kForegroundColorKey
                    options:NSKeyValueObservingOptionNew
                    context:NULL];
    
    [controller addObserver:self
                 forKeyPath:kBackgroundColorKey
                    options:NSKeyValueObservingOptionNew
                    context:NULL];
    
    [controller addObserver:self
                 forKeyPath:kFontFamilyKey
                    options:NSKeyValueObservingOptionNew
                    context:NULL];
    
    [controller addObserver:self
                 forKeyPath:kFontSizeKey
                    options:NSKeyValueObservingOptionNew
                    context:NULL];
    
    [controller addObserver:self
                 forKeyPath:kFontBoldKey
                    options:NSKeyValueObservingOptionNew
                    context:NULL];
    
    [controller addObserver:self
                 forKeyPath:kFontItalicKey
                    options:NSKeyValueObservingOptionNew
                    context:NULL];
    
    [controller addObserver:self
                 forKeyPath:kFontUnderlineKey
                    options:NSKeyValueObservingOptionNew
                    context:NULL];
}


- (void)removeObserverWithWindowController:(BaseDrawingWindowController*)controller {
    [controller removeObserver:self forKeyPath:kForegroundColorKey];
    [controller removeObserver:self forKeyPath:kBackgroundColorKey];
    [controller removeObserver:self forKeyPath:kFontFamilyKey];
    [controller removeObserver:self forKeyPath:kFontSizeKey];
    [controller removeObserver:self forKeyPath:kFontBoldKey];
    [controller removeObserver:self forKeyPath:kFontItalicKey];
    [controller removeObserver:self forKeyPath:kFontUnderlineKey];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
						change:(NSDictionary *)change
					   context:(void *)context
{
	id value = [change objectForKey:NSKeyValueChangeNewKey];
	
	if ([keyPath isEqualToString:kLineWidthKey]) {
		[self setLineWidth:[value integerValue]];
	}
    else if ([keyPath isEqualToString:kForegroundColorKey]) {
		[self setForegroundColor:value];
	}
    else if ([keyPath isEqualToString:kBackgroundColorKey]) {
		[self setBackgroundColor:value];
    }
    else if ([keyPath isEqualToString:kFontFamilyKey]) {
        [self setFontFamily:value];
    }
    else if ([keyPath isEqualToString:kFontSizeKey]) {
        [self setFontSize:value];
    }
    else if ([keyPath isEqualToString:kFontBoldKey]) {
        [self setBold:[value boolValue]];
    }
    else if ([keyPath isEqualToString:kFontItalicKey]) {
        [self setItalic:[value boolValue]];
    }
    else if ([keyPath isEqualToString:kFontUnderlineKey]) {
        [self setUnderline:[value boolValue]];
    }
}

#pragma mark - Draw the string

- (void)drawWithString:(NSString *)string {
    
    @autoreleasepool {
        NSDictionary            *attributes     = [[[NSMutableDictionary alloc] init] autorelease];
        NSFontManager           *fontManager    = [NSFontManager sharedFontManager];
        NSFont                  *font           = nil;
        
        NSUInteger fontMask = 0;
        if (bold) {
            fontMask |= NSBoldFontMask;
        }
        
        if (italic) {
            fontMask |= NSItalicFontMask;
        }
        
        font = [fontManager fontWithFamily:fontFamily traits:fontMask weight:0 size:[fontSize floatValue]];
        
        [attributes setValue:font forKey:NSFontAttributeName];
        [attributes setValue:foregroundColor forKey:NSForegroundColorAttributeName];
        [attributes setValue:backgroundColor forKey:NSBackgroundColorAttributeName];
        [attributes setValue:[NSNumber numberWithBool:underline] forKey:NSUnderlineStyleAttributeName];
        
        GCLockBitmapImage(mainImage);
        CGContextTranslateCTM([[NSGraphicsContext currentContext] graphicsPort], 0, canvas.frame.size.height);
        CGContextScaleCTM([[NSGraphicsContext currentContext] graphicsPort], 1.0, -1.0);
        [string drawAtPoint:NSMakePoint(lastPoint.x, canvas.frame.size.height - lastPoint.y - [string sizeWithAttributes:attributes].height) withAttributes:attributes];
        GCUnlockBitmapImage(mainImage);
    }
}


#pragma mark - Implement Drawing Methods

- (NSBezierPath *)pathFromPoint:(NSPoint)begin toPoint:(NSPoint)end {
    return nil;
}

- (NSBezierPath *)performDrawWithEvent:(NSEvent*)event
                         withMainImage:(NSBitmapImageRep *)aMainImage
                           bufferImage:(NSBitmapImageRep *)aBufferImage
                                  view:(NSView*)fromView {
    
    if (event.type == NSLeftMouseUp && event.clickCount > 1 && drawing == NO) { //begin to input the text after clicking twice
        
        mainImage   = aMainImage;
        bufferImage = aBufferImage;
        lastPoint   = [fromView convertPoint:[event locationInWindow] fromView:nil];
        canvas      = fromView;
        drawing     = YES;
        
        [textCell setTitle:@""];
        
        NSFont *font = [NSFont fontWithName:fontFamily size:[fontSize floatValue]];
        [textCell editWithFrame:NSMakeRect(lastPoint.x, lastPoint.y, [[fromView superview] frame].size.width - lastPoint.x - 5, 40) inView:fromView editor:textView delegate:self event:nil];
        [textView setEditable:YES];
        [textView setFont:font];
        [textView setBackgroundColor:[NSColor lightGrayColor]];
        [textView setDrawsBackground:YES];
    }
    
    return nil;
}

- (void)finishDrawing {
    if (drawing) {
        
        drawing = NO;
        [textCell endEditing:textView];
        
        [self drawWithString:textView.string];
        [canvas setNeedsDisplay:YES];
    }
}

#pragma mark - NSText Delegate

- (void)textDidEndEditing:(NSNotification *)notification {
    [self finishDrawing];
}

@end
