//
//  NSData+PSZlib.m
//  PSFoundation
//

#import "NSData+PSZlib.h"
#import "NSObject+Utilities.h"
#import <zlib.h>

#define kChunkSize 1024

@implementation NSData (PSDataZlib)

+ (NSData *)dataByCompressingData:(NSData *)data {
    if (data.empty)
        return nil;
    
    int retCode = Z_OK, status = Z_OK;
    Bytef *bytes = (Bytef *)data.bytes;
    uInt length = data.length, halfLength = length/2;
    
    z_stream zStream;
    zStream.zalloc = Z_NULL;
	zStream.zfree = Z_NULL;
	zStream.opaque = Z_NULL;
	zStream.avail_in = 0;
	zStream.next_in = 0;
    
    if ((retCode = deflateInit2(&zStream, Z_DEFAULT_COMPRESSION, Z_DEFLATED, 31, 8, Z_DEFAULT_STRATEGY)) != Z_OK)
        return nil;
    
    // hint the size at 1/4 the input size
    NSMutableData *result = [NSMutableData dataWithCapacity:length/4];
    
	zStream.next_in = bytes;
	zStream.avail_in = length;
	zStream.avail_out = 0;
    
	NSInteger bytesProcessedAlready = zStream.total_out;
	while (zStream.avail_out == 0) {
		if (zStream.total_out-bytesProcessedAlready >= result.length)
			[result increaseLengthBy:halfLength];
        
		zStream.next_out = result.mutableBytes + zStream.total_out-bytesProcessedAlready;
		zStream.avail_out = length - (zStream.total_out-bytesProcessedAlready);
		status = deflate(&zStream, Z_FINISH);
        
		if (status == Z_STREAM_END)
			break;
		else if (status != Z_OK)
			return nil;
	}
    
	// Set real length
	[result setLength: zStream.total_out-bytesProcessedAlready];
    
    deflateEnd(&zStream);
    
    return result;

}

+ (NSData *)dataByInflatingData:(NSData *)data {
    if (data.empty)
        return nil;
    
    const void *bytes = data.bytes;
    NSUInteger length = data.length;
    
    // TODO: support 64bit inputs
    // avail_in is a uInt, so if length > UINT_MAX we actually need to loop
    // feeding the data until we've gotten it all in.  not supporting this
    // at the moment.
    NSAssert(length <= UINT_MAX, @"Currently don't support >32bit lengths");
    
    z_stream strm;
    bzero(&strm, sizeof(z_stream));
    
    // setup the input
    strm.avail_in = (unsigned int)length;
    strm.next_in = (unsigned char*)bytes;
    
    int windowBits = 15; // 15 to enable any window size
    windowBits += 32; // and +32 to enable zlib or gzip header detection.
    int retCode;
    if ((retCode = inflateInit2(&strm, windowBits)) != Z_OK) {
        // COV_NF_START - no real way to force this in a unittest (we guard all args)
        NSLog(@"Failed to init for inflate, error %d", retCode);
        return nil;
        // COV_NF_END
    }
    
    // hint the size at 4x the input size
    NSMutableData *result = [NSMutableData dataWithCapacity:(length*4)];
    unsigned char output[kChunkSize];
    
    // loop to collect the data
    do {
        // update what we're passing in
        strm.avail_out = kChunkSize;
        strm.next_out = output;
        retCode = inflate(&strm, Z_NO_FLUSH);
        if ((retCode != Z_OK) && (retCode != Z_STREAM_END)) {
            NSLog(@"Error trying to inflate some of the payload, error %d",
                  retCode);
            inflateEnd(&strm);
            return nil;
        }
        // collect what we got
        unsigned gotBack = kChunkSize - strm.avail_out;
        if (gotBack > 0) {
            [result appendBytes:output length:gotBack];
        }
        
    } while (retCode == Z_OK);
    
    // make sure there wasn't more data tacked onto the end of a valid compressed
    // stream.
    if (strm.avail_in != 0) {
        NSLog(@"thought we finished inflate w/o using all input, %u bytes left",
              strm.avail_in);
        result = nil;
    }
    // the only way out of the loop was by hitting the end of the stream
    NSAssert(retCode == Z_STREAM_END,
             @"thought we finished inflate w/o getting a result of stream end, code %d",
             retCode);
    
    // clean up
    inflateEnd(&strm);
    
    return result;
}

@end
