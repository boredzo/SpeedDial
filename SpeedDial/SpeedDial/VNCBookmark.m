//
//  VNCBookmark.m
//  SpeedDial
//
//  Created by Peter Hosey on 2016-07-23.
//  Copyright © 2016 Peter Hosey. All rights reserved.
//

#import "VNCBookmark.h"

NSString *_Nonnull const gBookmarkDictionaryKeyBookmarkName = @"BookmarkName";
NSString *_Nonnull const gBookmarkDictionaryKeyUsername = @"Username";
//Note: No password key because we store those in the Keychain.
NSString *_Nonnull const gBookmarkDictionaryKeyHostname = @"Hostname";

@implementation VNCBookmark

- (NSURL *) URL {
	//We have to VNC *somewhere*.
	if (self.hostname == nil) {
		return nil;
	}
	//Password but no username isn't valid.
	if (self.password != nil && self.username == nil) {
		return nil;
	}

	NSURLComponents *_Nonnull const components = [NSURLComponents new];
	components.scheme = @"vnc";
	components.user = self.username;
	components.password = self.password;
	components.host = self.hostname;
	return [components URL];
}

+ (NSArray <VNCBookmark *> *_Nullable) arrayOfBookmarksFromArrayOfDictionaries:(NSArray <NSDictionary *> *_Nullable)savedBookmarks {
	if (savedBookmarks == nil) return nil;

	NSMutableArray <VNCBookmark *> *_Nonnull const bookmarks = [[NSMutableArray alloc] initWithCapacity:savedBookmarks.count];
	for (NSDictionary *_Nonnull const dict in savedBookmarks) {
		VNCBookmark *_Nonnull const bookmark = [VNCBookmark new];
		bookmark.bookmarkName = dict[gBookmarkDictionaryKeyBookmarkName];
		bookmark.username = dict[gBookmarkDictionaryKeyUsername];
		bookmark.hostname = dict[gBookmarkDictionaryKeyHostname];
		[bookmarks addObject:bookmark];
	}

	return bookmarks;
}

+ (NSArray <NSDictionary *> *_Nonnull) arrayOfDictionariesFromArrayOfBookmarks:(NSArray <VNCBookmark *> *_Nonnull)bookmarks {
	NSParameterAssert(bookmarks != nil);

	NSMutableArray <NSDictionary *> *_Nonnull const bookmarksToSave = [[NSMutableArray alloc] initWithCapacity:bookmarks.count];
	for (VNCBookmark *_Nonnull const bookmark in bookmarks) {
		NSMutableDictionary *_Nonnull const dict = [[NSMutableDictionary alloc] initWithCapacity:3];
		dict[gBookmarkDictionaryKeyBookmarkName] = bookmark.bookmarkName;
		dict[gBookmarkDictionaryKeyUsername] = bookmark.username;
		dict[gBookmarkDictionaryKeyHostname] = bookmark.hostname;
		[bookmarksToSave addObject:dict];
	}

	return bookmarksToSave;
}

@end
