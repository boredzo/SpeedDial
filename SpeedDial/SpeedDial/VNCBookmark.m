//
//  VNCBookmark.m
//  SpeedDial
//
//  Created by Peter Hosey on 2016-07-23.
//  Copyright © 2016 Peter Hosey. All rights reserved.
//

#import "VNCBookmark.h"

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

@end
