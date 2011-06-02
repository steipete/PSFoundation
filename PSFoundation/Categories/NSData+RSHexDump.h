//
//  NSData+RSHexDump.h
//  PSFoundation
//
//  Created by Daniel Jalkut on 2/14/07.
//  Copyright 2007 Red Sweater Software. All rights reserved.
//
//	References:
//	 - http://gigliwood.com/weblog/Cocoa/Better_description_.html
//

@interface NSData (RSHexDump)

// startOffset may be negative, indicating offset from end of data
- (NSString *)descriptionFromOffset:(int)startOffset;
- (NSString *)descriptionFromOffset:(int)startOffset limitingToByteCount:(unsigned int)maxBytes;

@end
