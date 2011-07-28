//
//  NSData+PSZlib.h
//  PSFoundation
//

/** Convenience methods for gzipping and deflating NSData instances.
 
 Includes code by the following:
 
 - [Ben Copesly](https://github.com/pokeb) - 2011. BSD.
 - [Google, Inc](http://code.google.com/p/google-toolbox-for-mac/) - 2008. Apache.
 
 @warning Documentation on this class/category is incomplete.
 
 */
@interface NSData (PSDataZlib)

/// Return an autoreleased NSData w/ the result of gzipping the payload of |data|.
+ (NSData *)dataByCompressingData:(NSData *)data;

/// Return an autoreleased NSData w/ the result of decompressing the payload of |data|.
+ (NSData *)dataByInflatingData:(NSData *)data;

@end
