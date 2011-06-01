//
//  NSSet+blocks.h
//  BGCD
//
//  Created by Corey Floyd on 11/16/09.
//  Copyright 2009 Flying Jalapeño Software. All rights reserved.
//

@interface NSSet (BlockExtension)
- (void)each:(void (^)(id))block;
- (NSSet* )select:(BOOL (^)(id))block;
- (NSSet *)map:(id (^)(id))block;
- (id)reduce:(id)initial withBlock:(id (^)(id,id))block;
@end

