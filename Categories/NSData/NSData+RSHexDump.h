//
//  NSData+RSHexDump.h
//  RSFoundation
//
//  Created by Daniel Jalkut on 2/14/07.
//  Copyright 2007 Red Sweater Software. All rights reserved.
//
//	Based on code from Dan Wood 
//	http://gigliwood.com/weblog/Cocoa/Better_description_.html
//

@interface NSData (RSHexDump)

- (NSString *)description;

// startOffset may be negative, indicating offset from end of data
- (NSString *)descriptionFromOffset:(int)startOffset;
- (NSString *)descriptionFromOffset:(int)startOffset limitingToByteCount:(unsigned int)maxBytes;

@end
