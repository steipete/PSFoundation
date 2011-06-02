//
//  NSMutableArray+SCQueue.h
//  PSFoundation
//
//  Created by Aleks Nesterow on 2/7/10.
//	Licensed under MIT.  Copyright 2010 Screen Customs s.r.o.
//

@interface NSMutableArray (SCQueue)

- (void)enqueue:(id)object;
- (id)dequeue;

@end
