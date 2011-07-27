//
//  NSData+PSZlib.h
//  PSFoundation
//
//  Includes code by the following:
//   - Google.     2008. Apache.
//   - Ben Copsey. 2011. BSD.
//

@interface NSData (PSDataZlib)

/// Return an autoreleased NSData w/ the result of gzipping the payload of |data|.
+ (NSData *)dataByCompressingData:(NSData *)data;

/// Return an autoreleased NSData w/ the result of decompressing the payload of |data|.
+ (NSData *)dataByInflatingData:(NSData *)data;

@end
