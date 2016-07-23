//
//  AppDelegate.m
//  SpeedDial
//
//  Created by Peter Hosey on 2016-07-23.
//  Copyright © 2016 Peter Hosey. All rights reserved.
//

#import "AppDelegate.h"

#import "PreferencesWindowController.h"

@implementation AppDelegate
{
	PreferencesWindowController *_wc;
}

- (void)applicationWillFinishLaunching:(NSNotification *)notification {
	_wc = [PreferencesWindowController new];
	[_wc showWindow:nil]; //TEMP
}

- (void)applicationWillTerminate:(NSNotification *)sotification {
	[_wc close];
	_wc = nil;
}

@end
