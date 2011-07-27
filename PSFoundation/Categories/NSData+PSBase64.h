//
//  NSData+PSBase64.h
//  PSFoundation
//
//  Copyright 2006-2008 Google Inc.
//  Licensed under Apache 2.0.  All rights reserved.
//

/** Helper for handling Base64 encodings within NSData. */
@interface NSData (PSDataBase64)

/** Base64 encodes contents of the NSData object.
 @param data A data payload.
 @return A new autoreleased NSString with the encoded payload.  nil for any error.
 @see dataByEncodingData:
 @see dataByDecodingData:
 */
+ (NSString *)stringByEncodingData:(NSData *)data;

/** Base64 decodes contents of the NSData object.
 @param data A data payload.
 @return A new autoreleased NSString with the decoded payload.  nil for any error.
 @see decodeData:
 @see encodeData:
 */
+ (NSData *)dataByDecodingString:(NSString *)string;

/** Base64 encodes contents of the NSData object.
 @param data A data payload.
 @return A new autoreleased NSData with the encoded payload.  nil for any error.
 @see dataByDecodingData:
 @see stringByEncodingData:
 */
+ (NSData *)dataByEncodingData:(NSData *)data;

/** Base64 decodes contents of the NSData object.
 @param data A data payload.
 @return A new autoreleased NSData with the decoded payload.  nil for any error.
 @see dataByEncodingData:
 @see stringByDecodingData:
 */
+ (NSData *)dataByDecodingData:(NSData *)data;

@end
