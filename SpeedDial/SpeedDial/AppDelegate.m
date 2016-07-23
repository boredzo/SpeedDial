//
//  AppDelegate.m
//  SpeedDial
//
//  Created by Peter Hosey on 2016-07-23.
//  Copyright © 2016 Peter Hosey. All rights reserved.
//

#import "AppDelegate.h"

#import "StatusItemController.h"
#import "BookmarksManager.h"
#import "PreferencesWindowController.h"

@implementation AppDelegate
{
	StatusItemController *_sic;
	BookmarksManager *_mgr;
	PreferencesWindowController *_wc;
}

- (void)applicationWillFinishLaunching:(NSNotification *)notification {
	_sic = [StatusItemController new];
	_mgr = [BookmarksManager new];

	_wc = [PreferencesWindowController new];
	_wc.bookmarksManager = _mgr;

	_sic.bookmarksManager = _mgr;
	_sic.preferencesWindowController = _wc;
}

- (void)applicationWillTerminate:(NSNotification *)sotification {
	[_mgr saveBookmarks];

	[_wc close];
	_wc = nil;
	_mgr = nil;
	_sic = nil;
}

@end
