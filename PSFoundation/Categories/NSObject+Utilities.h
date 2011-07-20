//
//  NSObject+Utilities.h
//  PSFoundation
//
//  Includes code by the following:
//   - Vincent Gable.      2009.
//   - Peter Steinberger.  2010.  MIT.
//   - Zachary Waldowski.  2011.  MIT.
//

@interface NSObject (PSFoundation)

+ (id) make;

@property (nonatomic,readonly,getter=isEmpty) BOOL empty;

- (void) performSelector: (SEL) selector afterDelay: (NSTimeInterval) delay;

@end
