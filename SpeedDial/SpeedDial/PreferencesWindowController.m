//
//  PreferencesWindowController.m
//  SpeedDial
//
//  Created by Peter Hosey on 2016-07-23.
//  Copyright © 2016 Peter Hosey. All rights reserved.
//

#import "PreferencesWindowController.h"

#import "VNCBookmark.h"

@interface PreferencesWindowController () <NSOutlineViewDataSource>

@property (weak) IBOutlet NSOutlineView *outlineView;

- (IBAction)addBookmark:(id)sender;
- (IBAction)removeBookmark:(id)sender;

@end

@implementation PreferencesWindowController
{
	NSMutableArray <VNCBookmark *> *_bookmarks;
}

- (instancetype)init {
	if ((self = [self initWithWindowNibName:NSStringFromClass(self.class)])) {
		_bookmarks = [NSMutableArray new];
	}
	return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (IBAction)addBookmark:(id)sender {
	VNCBookmark *_Nonnull const newBookmark = [VNCBookmark new];
	[_bookmarks addObject:newBookmark];
	[self.outlineView reloadItem:nil reloadChildren:YES];
	[self.outlineView editColumn:0
		row:[self.outlineView rowForItem:newBookmark]
		withEvent:nil
		select:YES];
}

- (IBAction)removeBookmark:(id)sender {
	NSIndexSet *_Nonnull const selectedRowIndexes = self.outlineView.selectedRowIndexes;
	[_bookmarks removeObjectsAtIndexes:selectedRowIndexes];
}

#pragma mark - NSOutlineViewDataSource conformance

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
	if (item == nil) {
		return _bookmarks.count;
	}
	return 0;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)idx ofItem:(id)item {
	if (item == nil) {
		return _bookmarks[idx];
	}
	return nil;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
	return NO;
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
	if (item == nil) return nil;
	VNCBookmark *_Nonnull const bookmark = item;
	return [bookmark valueForKey:tableColumn.identifier];
}

- (void)outlineView:(NSOutlineView *)outlineView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
	if (item == nil) return;
	VNCBookmark *_Nonnull const bookmark = item;
	return [bookmark setValue:object forKey:tableColumn.identifier];
}

@end
