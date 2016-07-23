//
//  BookmarksManager.m
//  SpeedDial
//
//  Created by Peter Hosey on 2016-07-23.
//  Copyright © 2016 Peter Hosey. All rights reserved.
//

#import "BookmarksManager.h"

NSString *_Nonnull const gBookmarksListDefaultsKey = @"BookmarksList";

const SecProtocolType madeUpVNCProtocolType = 'RFB ';

@interface BookmarksManager (KeychainWrapper)

- (NSString *_Nullable) passwordForVNCURLWithUsername:(NSString *_Nullable)username hostname:(NSString *_Nonnull)hostname;
- (void) setPassword:(NSString *_Nullable)password forVNCURLWithUsername:(NSString *_Nullable)username hostname:(NSString *_Nonnull)hostname;

@end

@implementation BookmarksManager
{
	NSMutableArray <VNCBookmark *> *_bookmarks;
}

- (instancetype)init {
	if ((self = [super init])) {
		NSArray <NSDictionary *> *_Nullable const savedBookmarks = [[NSUserDefaults standardUserDefaults] objectForKey:gBookmarksListDefaultsKey];
		NSArray <VNCBookmark *> *_Nullable const deserializedBookmarks = [VNCBookmark arrayOfBookmarksFromArrayOfDictionaries:savedBookmarks];
		if (deserializedBookmarks != nil) {
			for (VNCBookmark *_Nonnull const bookmark in deserializedBookmarks) {
				if (bookmark.hostname != nil) {
					bookmark.password = [self passwordForVNCURLWithUsername:bookmark.username hostname:bookmark.hostname];
				}
			}

			_bookmarks = [deserializedBookmarks mutableCopy];
		} else {
			_bookmarks = [NSMutableArray new];
		}
	}
	return self;
}

- (void) saveBookmarks {
	NSArray <VNCBookmark *> *_Nonnull const bookmarks = [_bookmarks copy];

	NSArray <NSDictionary *> *_Nonnull const bookmarkDictionaries = [VNCBookmark arrayOfDictionariesFromArrayOfBookmarks:bookmarks];
	[[NSUserDefaults standardUserDefaults] setObject:bookmarkDictionaries forKey:gBookmarksListDefaultsKey];

	for (VNCBookmark *_Nonnull const bookmark in bookmarks) {
		if (bookmark.hostname != nil) {
		[self setPassword:bookmark.password forVNCURLWithUsername:bookmark.username hostname:bookmark.hostname];
		}
	}
}

#pragma mark -

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

#pragma mark -

- (VNCBookmark *_Nonnull) addNewEmptyBookmarkAtEnd {
	VNCBookmark *_Nonnull const newBookmark = [VNCBookmark new];
	[_bookmarks addObject:newBookmark];
	return newBookmark;
}

- (void) removeBookmarksAtIndexes:(NSIndexSet *_Nonnull)indexes {
	[_bookmarks removeObjectsAtIndexes:indexes];
}

@end

@implementation BookmarksManager (KeychainWrapper)

- (NSData *_Nullable) data:(NSData *_Nullable)data constrainedToLength:(NSUInteger)maxLength {
	if (data.length > maxLength) {
		data = [data subdataWithRange:(NSRange){ 0, maxLength }];
	}
	return data;
}

- (NSString *_Nullable) passwordForVNCURLWithUsername:(NSString *_Nullable)username hostname:(NSString *_Nonnull)hostname {
	NSData *_Nullable const usernameData = [self data:[username dataUsingEncoding:NSUTF8StringEncoding] constrainedToLength:UINT32_MAX];
	NSData *_Nonnull const hostnameData = [self data:[hostname dataUsingEncoding:NSUTF8StringEncoding] constrainedToLength:UINT32_MAX];
	UInt32 passwordLength = 0;
	void *_Nullable passwordBytes = NULL;
	OSStatus const err = SecKeychainFindInternetPassword(NULL, (UInt32)hostnameData.length, hostnameData.bytes, /*securityDomain*/ 0, NULL, (UInt32)usernameData.length, usernameData.bytes, /*path*/ 0, NULL, /*port*/ 5900, madeUpVNCProtocolType, kSecAuthenticationTypeAny, &passwordLength, &passwordBytes, /*outItem*/ NULL);
	if (err != noErr) {
		// https://github.com/boredzo/SpeedDial/issues/8 This should be an alert instead of a log message.
		NSString *_Nullable const errorString = (__bridge_transfer NSString *_Nullable)SecCopyErrorMessageString(err, /*reserved*/ NULL);
		NSLog(@"SecKeychainFindInternetPassword failed: %ld (%@)", (long)err, errorString);
		return nil;
	} else {
		NSData *_Nonnull const passwordData = [NSData dataWithBytes:passwordBytes length:passwordLength];
		NSString *_Nullable const password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
		SecKeychainItemFreeContent(/*attrList*/ NULL, passwordBytes);
		return password;
	}
}
- (void) setPassword:(NSString *_Nullable)password forVNCURLWithUsername:(NSString *_Nullable)username hostname:(NSString *_Nonnull)hostname {
	NSData *_Nullable const usernameData = [self data:[username dataUsingEncoding:NSUTF8StringEncoding] constrainedToLength:UINT32_MAX];
	NSData *_Nullable const passwordData = [self data:[password dataUsingEncoding:NSUTF8StringEncoding] constrainedToLength:UINT32_MAX];
	NSData *_Nonnull const hostnameData = [self data:[hostname dataUsingEncoding:NSUTF8StringEncoding] constrainedToLength:UINT32_MAX];
	OSStatus const err = SecKeychainAddInternetPassword(NULL, (UInt32)hostnameData.length, hostnameData.bytes, /*securityDomain*/ 0, NULL, (UInt32)usernameData.length, usernameData.bytes, /*path*/ 0, NULL, /*port*/ 5900, madeUpVNCProtocolType, kSecAuthenticationTypeAny, (UInt32)passwordData.length, passwordData.bytes, /*outItem*/ NULL);
	if (err != noErr && err != errSecDuplicateItem) {
		// https://github.com/boredzo/SpeedDial/issues/8 This should be an alert instead of a log message.
		NSString *_Nullable const errorString = (__bridge_transfer NSString *_Nullable)SecCopyErrorMessageString(err, /*reserved*/ NULL);
		NSLog(@"SecKeychainAddInternetPassword failed: %ld (%@)", (long)err, errorString);
	}
}

@end
