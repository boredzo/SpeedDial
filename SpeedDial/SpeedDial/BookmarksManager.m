//
//  BookmarksManager.m
//  SpeedDial
//
//  Created by Peter Hosey on 2016-07-23.
//  Copyright © 2016 Peter Hosey. All rights reserved.
//

#import "BookmarksManager.h"

@implementation BookmarksManager
{
	NSMutableArray <VNCBookmark *> *_bookmarks;
}

- (instancetype)init {
	if ((self = [super init])) {
		_bookmarks = [NSMutableArray new];
	}
	return self;
}

- (NSUInteger) count {
	return _bookmarks.count;
}
- (VNCBookmark *_Nonnull) objectAtIndexedSubscript:(NSUInteger)idx {
	return [_bookmarks objectAtIndexedSubscript:idx];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
	objects:(__unsafe_unretained id  _Nonnull *)buffer
	count:(NSUInteger)len
{
	return [_bookmarks countByEnumeratingWithState:state
		objects:buffer
		count:len];
}

- (VNCBookmark *_Nonnull) addNewEmptyBookmarkAtEnd {
	VNCBookmark *_Nonnull const newBookmark = [VNCBookmark new];
	[_bookmarks addObject:newBookmark];
	return newBookmark;
}

- (void) removeBookmarksAtIndexes:(NSIndexSet *_Nonnull)indexes {
	[_bookmarks removeObjectsAtIndexes:indexes];
}

@end
