//
//  VNCBookmark.h
//  SpeedDial
//
//  Created by Peter Hosey on 2016-07-23.
//  Copyright © 2016 Peter Hosey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VNCBookmark : NSObject

@property(nullable, copy) NSString *bookmarkName;
@property(nullable, copy) NSString *username;
@property(nullable, copy) NSString *password;
@property(nullable, copy) NSString *hostname;

///Create an NSURL that represents the contents of this bookmark.
@property(nonatomic, readonly, nullable) NSURL *URL;

///Deserialize bookmark dictionaries that you might have got from NSUserDefaults.
+ (NSArray <VNCBookmark *> *_Nullable) arrayOfBookmarksFromArrayOfDictionaries:(NSArray <NSDictionary *> *_Nullable)savedBookmarks;
///Serialize bookmark dictionaries so that you can store them in NSUserDefaults.
+ (NSArray <NSDictionary *> *_Nonnull) arrayOfDictionariesFromArrayOfBookmarks:(NSArray <VNCBookmark *> *_Nonnull)bookmarks;

@end
