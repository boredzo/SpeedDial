//
//  StatusItemController.h
//  SpeedDial
//
//  Created by Peter Hosey on 2016-07-23.
//  Copyright © 2016 Peter Hosey. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class BookmarksManager;
@class PreferencesWindowController;

@interface StatusItemController : NSObject

@property(weak) BookmarksManager *bookmarksManager;
@property(weak) PreferencesWindowController *preferencesWindowController;

@end
