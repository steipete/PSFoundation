//
//  NSData+RSHexDump.m
//  RSFoundation
//
//  Created by Daniel Jalkut on 2/14/07.
//  Copyright 2007 Red Sweater Software. All rights reserved.
//
//	Based on code from Dan Wood 
//	http://gigliwood.com/weblog/Cocoa/Better_description_.html
//
//

#import "NSData+RSHexDump.h"

const unsigned int kDefaultMaxBytesToHexDump = 1024;

@implementation NSData ( RSHexDump )

- (NSString *)description
{
	return [self descriptionFromOffset:0];
}

- (NSString *)descriptionFromOffset:(int)startOffset
{
	return [self descriptionFromOffset:startOffset limitingToByteCount:kDefaultMaxBytesToHexDump];
}

- (NSString *)descriptionFromOffset:(int)startOffset limitingToByteCount:(unsigned int)maxBytes
{
    unsigned char *bytes = (unsigned char *)[self bytes];
    unsigned int stopOffset = [self length];

	// Translate negative offset to positive, by subtracting from end
	if (startOffset < 0)
	{
		startOffset = [self length] + startOffset;
	}

	// Do we have more data than the caller wants?
	BOOL curtailOutput = NO;
	if ((stopOffset - startOffset) > maxBytes)
	{
		curtailOutput = YES;
		stopOffset = startOffset + maxBytes;
	}

	// If we're showing a subset, we'll tack in info about that
	NSString* curtailInfo = @"";
	if ((startOffset > 0) || (stopOffset < [self length]))
	{
		curtailInfo = [NSString stringWithFormat:@" (showing bytes %d through %d)", startOffset, stopOffset];
	}
	
	// Start the hexdump out with an overview of the content
	NSMutableString *buf = [NSMutableString stringWithFormat:@"NSData %d bytes%@:\n", [self length], curtailInfo];
	
	// One row of 16-bytes at a time ...
    int i, j;
    for ( i = startOffset ; i < stopOffset ; i += 16 )
    {
		// Show the row in Hex first
        for ( j = 0 ; j < 16 ; j++ )    
        {
            int rowOffset = i+j;
            if (rowOffset < stopOffset)
            {
                [buf appendFormat:@"%02X ", bytes[rowOffset]];
            }
            else
            {
                [buf appendFormat:@"   "];
            }
        }
		
		// Now show in ASCII
        [buf appendString:@"| "];   
        for ( j = 0 ; j < 16 ; j++ )
        {
            int rowOffset = i+j;
            if (rowOffset < stopOffset)
            {
                unsigned char theChar = bytes[rowOffset];
                if (theChar < 32 || theChar > 127)
                {
                    theChar ='.';
                }
                [buf appendFormat:@"%c", theChar];
            }
        }
		
		// If we're not on the last row, tack on a newline
		if (i+16 < stopOffset)
		{
			[buf appendString:@"\n"];
		}
	}
	
    return buf;	
}

@end
