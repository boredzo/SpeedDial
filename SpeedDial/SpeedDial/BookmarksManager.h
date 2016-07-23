//
//  BookmarksManager.h
//  SpeedDial
//
//  Created by Peter Hosey on 2016-07-23.
//  Copyright © 2016 Peter Hosey. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VNCBookmark.h"

@interface BookmarksManager : NSObject

@property(nonatomic, readonly) NSUInteger count;
- (VNCBookmark *_Nonnull) objectAtIndexedSubscript:(NSUInteger)idx;

- (VNCBookmark *_Nonnull) addNewEmptyBookmarkAtEnd;

- (void) removeBookmarksAtIndexes:(NSIndexSet *_Nonnull)indexes;

@end
