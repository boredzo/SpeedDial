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

@end
