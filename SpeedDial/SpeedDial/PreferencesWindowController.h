//
//  PreferencesWindowController.h
//  SpeedDial
//
//  Created by Peter Hosey on 2016-07-23.
//  Copyright © 2016 Peter Hosey. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class BookmarksManager;

@interface PreferencesWindowController : NSWindowController

@property(weak) BookmarksManager *bookmarksManager;

@end
