//
//  NSMutableArray+SCQueue.h
//  TouchCustoms
//
//  Created by Aleks Nesterow on 2/7/10.
//	aleks.nesterow@gmail.com
//
//  Copyright © 2010 Screen Customs s.r.o.
//	All rights reserved.
//

@interface NSMutableArray (SCQueue)

- (void)enqueue:(id)object;
- (id)dequeue;

@end
