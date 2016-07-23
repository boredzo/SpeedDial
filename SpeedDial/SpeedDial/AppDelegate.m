//
//  AppDelegate.m
//  SpeedDial
//
//  Created by Peter Hosey on 2016-07-23.
//  Copyright © 2016 Peter Hosey. All rights reserved.
//

#import "AppDelegate.h"

#import "BookmarksManager.h"
#import "PreferencesWindowController.h"

@implementation AppDelegate
{
	BookmarksManager *_mgr;
	PreferencesWindowController *_wc;
}

- (void)applicationWillFinishLaunching:(NSNotification *)notification {
	_mgr = [BookmarksManager new];
	_wc = [PreferencesWindowController new];
	_wc.bookmarksManager = _mgr;
	[_wc showWindow:nil]; //TEMP
}

- (void)applicationWillTerminate:(NSNotification *)sotification {
	[_wc close];
	_wc = nil;
	_mgr = nil;
}

@end
