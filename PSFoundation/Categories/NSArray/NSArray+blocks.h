//
//  NSString+blocks.h
//  blocks
//
//  Created by Robin Lu on 9/6/09.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

@interface NSArray (BlockExtension)
- (void)each:(void (^)(id))block;
- (NSArray* )select:(BOOL (^)(id))block;
- (NSArray *)map:(id (^)(id))block;
- (id)reduce:(id)initial withBlock:(id (^)(id,id))block;
@end
