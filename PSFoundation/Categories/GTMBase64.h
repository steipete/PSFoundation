//
//  GTMBase64.h
//  PSFoundation
//
//  Copyright 2006-2008 Google Inc.
//  Licensed under Apache 2.0.  All rights reserved.
//

/** Helper for handling Base64 and WebSafeBase64 encodings
 
 The webSafe methods use different character set and also the results aren't
 always padded to a multiple of 4 characters.  This is done so the resulting
 data can be used in urls and url query arguments without needing any
 encoding.  You must use the webSafe* methods together, the data does not
 interop with the RFC methods.
 */
@interface GTMBase64 : NSObject

///--------------------------------------
/// @name Standard Base64 (RFC) handling
///--------------------------------------

/** Base64 encodes contents of the NSData object.
 @param data A data payload.
 @return A new autoreleased NSData with the encoded payload.  nil for any error.
 @see decodeData:
 @see encodeBytes:length:
 @see stringByEncodingData:
 */
+(NSData *)encodeData:(NSData *)data;

/** Base64 decodes contents of the NSData object.
 @param data A data payload.
 @return A new autoreleased NSData with the decoded payload.  nil for any error.
 @see encodeData:
 @see decodeBytes:length:
 @see stringByDecodingData:
 */
+(NSData *)decodeData:(NSData *)data;

/** Base64 encodes the data pointed at by bytes.
 @param bytes A pointer to a list of bytes.
 @param length The length of the bytes.
 @return A new autoreleased NSData with the encoded payload.  nil for any error.
 @see decodeBytes:length:
 @see encodeData:
 */
+(NSData *)encodeBytes:(const void *)bytes length:(NSUInteger)length;

/** Base64 decodes the data pointed at by bytes.
 @param bytes A pointer to a list of bytes.
 @param length The length of the bytes.
 @return A new autoreleased NSData with the decoded payload.  nil for any error.
 @see encodeBytes:length:
 @see decodeData:
 */
+(NSData *)decodeBytes:(const void *)bytes length:(NSUInteger)length;

/** Base64 encodes contents of the NSData object.
 @param data A data payload.
 @return A new autoreleased NSString with the encoded payload.  nil for any error.
 @see encodeData:
 @see decodeData:
 @see stringByEncodingBytes:length:
 */
+(NSString *)stringByEncodingData:(NSData *)data;

/** Base64 encodes the data pointed at by |bytes|.
 @param bytes A pointer to a list of bytes.
 @param length The length of the bytes.
 @return A new autoreleased NSString with the encoded payload.  nil for any error.
 @see encodeData:
 @see decodeData:
 @see stringByEncodingData:
 */
+(NSString *)stringByEncodingBytes:(const void *)bytes length:(NSUInteger)length;

/** Base64 decodes contents of the NSData object.
 @param data A data payload.
 @return A new autoreleased NSString with the decoded payload.  nil for any error.
 @see decodeData:
 @see encodeData:
 */
+(NSData *)decodeString:(NSString *)string;

///-----------------------------------------
/// @name Modified Base64 for URL handling.
///-----------------------------------------

/** WebSafe Base64 encodes contents of the NSData object.
 @param data A data payload.
 @param padded Whether or not characters are added to make the result length a multiple of 4.
 @return A new autoreleased NSData with the encoded payload.  nil for any error.
 @see encodeData:
 @see webSafeEncodeString:
 */
+(NSData *)webSafeEncodeData:(NSData *)data
                      padded:(BOOL)padded;

/** WebSafe Base64 decodes contents of the NSData object.
 @param data A data payload.
 @param padded Whether or not characters are added to make the result length a multiple of 4.
 @return A new autoreleased NSData with the encoded payload.  nil for any error.
 @see decodeData:
 @see webSafeDecodeString:
 */
+(NSData *)webSafeDecodeData:(NSData *)data;

/** WebSafe Base64 encodes the data pointed at by bytes.
 @param bytes A pointer to a list of bytes.
 @param length The length of the bytes.
 @param padded Whether or not characters are added to make the result length a multiple of 4.
 @return A new autoreleased NSData with the encoded payload.  nil for any error.
 @see webSafeEncodeData:padded:
 */
+(NSData *)webSafeEncodeBytes:(const void *)bytes
                       length:(NSUInteger)length
                       padded:(BOOL)padded;

/** WebSafe Base64 decodes the data pointed at by bytes.
 @param bytes A pointer to a list of bytes.
 @param length The length of the bytes.
 @return A new autoreleased NSData with the decoded payload.  nil for any error.
 @see webSafeEncodeBytes:length:padded:
 @see webSafeDecodeData:
 */
+(NSData *)webSafeDecodeBytes:(const void *)bytes length:(NSUInteger)length;

/** Base64 encodes contents of the NSData object.
 @param data A data payload.
 @return A new autoreleased NSString with the encoded payload.  nil for any error.
 @param padded Whether or not characters are added to make the result length a multiple of 4.
 @see webSafeEncodeData:padded:
 @see webSafeDecodeData:
 @see stringByWebSafeEncodingBytes:length:
 */
+(NSString *)stringByWebSafeEncodingData:(NSData *)data
                                  padded:(BOOL)padded;

/** Base64 encodes the data pointed at by |bytes|.
 @param bytes A pointer to a list of bytes.
 @param length The length of the bytes.
 @param padded Whether or not characters are added to make the result length a multiple of 4.
 @return A new autoreleased NSString with the encoded payload.  nil for any error.
 @see webSafeEncodeData:padded:
 @see webSafeDecodeData:
 */
+(NSString *)stringByWebSafeEncodingBytes:(const void *)bytes
                                   length:(NSUInteger)length
                                   padded:(BOOL)padded;

/** Web-safe Base64 decodes contents of the NSData object.
 @param data A data payload.
 @return A new autoreleased NSString with the decoded payload.  nil for any error.
 @see webSafeDecodeData:
 @see webSafeEncodeData:padded;
 */
+(NSData *)webSafeDecodeString:(NSString *)string;

@end
