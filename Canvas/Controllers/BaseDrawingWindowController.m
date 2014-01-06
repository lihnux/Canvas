//
//  BaseDrawingWindowController.m
//  Canvas
//
//  Created by Paul Li on 12/27/13.
//  Copyright (c) 2013 Paul Li. All rights reserved.
//

#import "BaseDrawingWindowController.h"
#import "PenTool.h"
#import "RectangleTool.h"
#import "TextTool.h"

@implementation BaseDrawingWindowController

@synthesize foregroundColor;
@synthesize backgroundColor;
@synthesize lineWidth;
@synthesize lineMinWidth;
@synthesize lineMaxWidth;
@synthesize fontFamily;
@synthesize fontSize;
@synthesize bold;
@synthesize italic;
@synthesize underline;
@synthesize currentTool;
@synthesize toolList;

#pragma mark - Override Methods

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
    }
    return self;
}

- (void)dealloc {
    [foregroundColor    release];
    [backgroundColor    release];
    [toolList           release];
    [super dealloc];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

#pragma mark - Public Methods

- (void)changeCurrentToolWithString:(NSString*)string {
    
    if ([self.currentTool.description isEqualToString:string] == YES) { //NO Change
        return;
    }
    
    if ([string isEqualToString:kTextToolbarItemID]) {
        [ib_toolbar removeItemAtIndex:[self lineWidthOrFontItemIndex]];
        [ib_toolbar insertItemWithItemIdentifier:kFontToolbarItemID atIndex:[self lineWidthOrFontItemIndex]];
    }
    else {
        if ([self.currentTool.description isEqualToString:kTextToolbarItemID]) {
            [ib_toolbar removeItemAtIndex:[self lineWidthOrFontItemIndex]];
            [ib_toolbar insertItemWithItemIdentifier:kLineWidthToolbarItemID atIndex:[self lineWidthOrFontItemIndex]];
        }
    }
    
    [currentTool finishDrawing];
    
    [currentTool removeObserverWithWindowController:self];
    
    self.currentTool = [toolList objectForKey:string];
    
    self.foregroundColor    = self.currentTool.foregroundColor;
    self.backgroundColor    = self.currentTool.backgroundColor;
    if ([string isEqualToString:kTextToolbarItemID]) {
        TextTool *textTool = (TextTool*)self.currentTool;
        self.fontFamily = textTool.fontFamily;
        self.fontSize   = textTool.fontSize;
        self.bold       = textTool.bold;
        self.italic     = textTool.italic;
        self.underline  = textTool.underline;
    }
    else {
        self.lineWidth          = self.currentTool.lineWidth;
        self.lineMinWidth       = self.currentTool.lineMinWidth;
        self.lineMaxWidth       = self.currentTool.lineMaxWidth;
    }
    
    [currentTool addObserverWithWindowController:self];
}

- (NSUInteger)lineWidthOrFontItemIndex {
    return [[self toolbarItems] indexOfObject:NSToolbarSeparatorItemIdentifier] + 1;
}

#pragma mark - Toolbar Item Actions

- (IBAction)onToolToggle:(id)sender {
    NSToolbarItem *item = (NSToolbarItem*)sender;
    [self changeCurrentToolWithString:item.paletteLabel];
}

- (IBAction)onClean:(id)sender {
    
}

#pragma mark - toolbar help Methods
- (NSArray*)toolbarItems {
    return [NSArray arrayWithObjects:   kSelectToolbarItemID, kPenToolbarItemID, kHighLighterToolbarItemID,
                                        kLineToolbarItemID, kRectangleToolbarItemID, kEllipseToolbarItemID,
                                        kTextToolbarItemID, kEraserToolbarItemID, kCleanToolbarItemID,
                                        NSToolbarSeparatorItemIdentifier,
                                        kColorsToolbarItemID, kLineWidthToolbarItemID,
            nil];
}

- (NSArray*)toolbarSelectableItems {
    return [NSArray arrayWithObjects:   kSelectToolbarItemID, kPenToolbarItemID, kHighLighterToolbarItemID,
                                        kLineToolbarItemID, kRectangleToolbarItemID, kEllipseToolbarItemID,
                                        kTextToolbarItemID, kEraserToolbarItemID,
            nil];
}

#pragma mark - Private Methods

- (NSToolbarItem *)toolbarItemWithIdentifier:(NSString *)identifier
                                       label:(NSString *)label
                                 paleteLabel:(NSString *)paletteLabel
                                     toolTip:(NSString *)toolTip
                                      target:(id)target
                                 itemContent:(id)imageOrView
                                      action:(SEL)action
                                        item:(NSToolbarItem*)anItem
{
    NSToolbarItem *item = (anItem == nil) ? [[[NSToolbarItem alloc] initWithItemIdentifier:identifier] autorelease] :anItem;
    
    [item setLabel:         label];
    [item setPaletteLabel:  paletteLabel];
    [item setToolTip:       toolTip];
    [item setTarget:        target];
    [item setAction:        action];
    
    if([imageOrView isKindOfClass:[NSImage class]]){
        [item setImage:imageOrView];
    }
    else if ([imageOrView isKindOfClass:[NSView class]]){
        [item setView:imageOrView];
    }
    else {
        assert(!"Invalid itemContent: object");
    }
    
    return item;
}

- (NSToolbarItem*)initToolbarItemWithIdentifier:(NSString*)itemIdentifier item:(NSToolbarItem*)anItem {
    
    NSToolbarItem *toolbarItem = nil;
    
    if ([itemIdentifier isEqualToString:kLineWidthToolbarItemID]) {
        toolbarItem = [self toolbarItemWithIdentifier:kLineWidthToolbarItemID
                                                label:@"Stroke"
                                          paleteLabel:@"Stroke"
                                              toolTip:@"Change the bound width"
                                               target:self
                                          itemContent:ib_strokeView
                                               action:nil
                                                 item:anItem];
    }
    else if ([itemIdentifier isEqualToString:kColorsToolbarItemID]) {
        toolbarItem = [self toolbarItemWithIdentifier:kColorsToolbarItemID
                                                label:@"Colors"
                                          paleteLabel:@"Colors"
                                              toolTip:@"Change the foreground/background color"
                                               target:self
                                          itemContent:ib_colorsView
                                               action:nil
                                                 item:anItem];
    }
    else if ([itemIdentifier isEqualToString:kFontToolbarItemID]) {
        toolbarItem = [self toolbarItemWithIdentifier:kFontToolbarItemID
                                                label:@"Font"
                                          paleteLabel:@"Font"
                                              toolTip:@"Change the font of text"
                                               target:self
                                          itemContent:ib_fontView
                                               action:nil
                                                 item:anItem];
    }
    
    return toolbarItem;
}

#pragma mark - Toolbar Delegates

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar {
    return [self toolbarItems];
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar {
    return [self toolbarItems];
}

- (NSArray*)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar {
    return [self toolbarSelectableItems];
}

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag {
    
    return [self initToolbarItemWithIdentifier:itemIdentifier item:nil];
}

- (void)toolbarWillAddItem:(NSNotification *)notification {
    
    NSToolbarItem *addedItem = [[notification userInfo] objectForKey:@"item"];
    
    [self initToolbarItemWithIdentifier:[addedItem itemIdentifier] item:addedItem];
}

@end
