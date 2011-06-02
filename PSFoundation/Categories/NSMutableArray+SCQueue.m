//
//  NSMutableArray+SCQueue.m
//  PSFoundation
//
//  Created by Aleks Nesterow on 2/7/10.
//	Licensed under MIT.  Copyright 2010 Screen Customs s.r.o.
//

#import "NSMutableArray+SCQueue.h"

@implementation NSMutableArray (SCQueue)

- (void)enqueue:(id)object {

	[self insertObject:object atIndex:0];
}

- (id)dequeue {
	
	id lastObject = [self lastObject];
	[self removeLastObject];
	return lastObject;
}

@end
