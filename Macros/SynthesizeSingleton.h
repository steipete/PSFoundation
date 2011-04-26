//
//  SynthesizeSingleton.h
//  CocoaWithLove
//
//  Created by Matt Gallagher on 20/10/08.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
 \
static classname *shared##classname = nil; \
 \
+ (classname *)shared##classname \
{ \
  static dispatch_once_t pred; \
  dispatch_once(&pred, ^{ shared##classname = [[self alloc] init]; }); \
  return shared##classname; \
} \
 \
+ (id)allocWithZone:(NSZone *)zone \
{ \
  static dispatch_once_t pred; \
  dispatch_once(&pred, ^{ shared##classname = [[self allocWithZone:zone] init]; }); \
  return shared##classname; \
} \
 \
- (id)copyWithZone:(NSZone *)zone \
{ \
    NSAssert(NO, @"Don't you dare copy a singleton!");\
	return self; \
} \
 \
- (id)retain \
{ \
    NSAssert(NO, @"Don't you dare retain a singleton!");\
	return self; \
} \
 \
- (NSUInteger)retainCount \
{ \
	return NSUIntegerMax; \
} \
 \
- (void)release \
{ \
  NSAssert(NO, @"Don't you dare release a singleton!");\
} \
 \
- (id)autorelease \
{ \
    NSAssert(NO, @"Don't you dare autorelease a singleton!");\
	return self; \
}
