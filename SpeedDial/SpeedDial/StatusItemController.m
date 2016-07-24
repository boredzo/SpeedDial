//
//  StatusItemController.m
//  SpeedDial
//
//  Created by Peter Hosey on 2016-07-23.
//  Copyright © 2016 Peter Hosey. All rights reserved.
//

#import "StatusItemController.h"

#import "BookmarksManager.h"
#import "PreferencesWindowController.h"

@interface StatusItemController () <NSMenuDelegate>

@end

@implementation StatusItemController
{
	NSStatusItem *_statusItem;
}

- (instancetype) init {
	if ((self = [super init])) {
		_statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
		_statusItem.image = [NSImage imageNamed:@"SpeedDialStatusItemTemplate"];

		NSMenu *_Nonnull const menu = [[NSMenu alloc] initWithTitle:@""];
		menu.delegate = self;
		_statusItem.menu = menu;
	}
	return self;
}

#pragma mark NSMenuDelegate conformance

- (void)menuNeedsUpdate:(NSMenu *_Nonnull)menu {
	[menu removeAllItems];

	for (VNCBookmark *_Nonnull const bookmark in self.bookmarksManager) {
		NSMenuItem *_Nonnull const itemForBookmark = [menu addItemWithTitle:bookmark.bookmarkName
			action:@selector(openBookmark:)
			keyEquivalent:@""];
		itemForBookmark.target = self;
		itemForBookmark.representedObject = bookmark;
	}

	if (self.preferencesWindowController != nil) {
		[menu addItem:[NSMenuItem separatorItem]];
		NSMenuItem *_Nonnull const prefsMenuItem = [menu addItemWithTitle:NSLocalizedString(@"Preferences…", /*menu item in status item menu*/)
			action:@selector(showPreferences:)
			keyEquivalent:@","];
		prefsMenuItem.target = self.preferencesWindowController;
	}

	[menu addItem:[NSMenuItem separatorItem]];
	[menu addItemWithTitle:NSLocalizedString(@"Quit", /*menu item in status item menu*/)
		action:@selector(terminate:)
		keyEquivalent:@"q"];
}

#pragma mark Actions

- (IBAction) openBookmark:(_Nullable id)sender {
	NSAssert([sender isKindOfClass:[NSMenuItem class]], @"Unexpected sender of %s: %@", __func__, sender);
	NSMenuItem *_Nullable const menuItem = sender;
	VNCBookmark *_Nullable const bookmark = menuItem.representedObject;
	NSURL *_Nullable const URL = bookmark.URL;

	if (URL != nil) {
		[[NSWorkspace sharedWorkspace] openURL:URL];
	}
}

@end
