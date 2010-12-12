//
//  NSError+SCMethods.m
//  TouchCustoms
//
//  Created by Aleks Nesterow on 3/14/10.
//	aleks.nesterow@gmail.com
//	
//  Copyright © 2010 Screen Customs s.r.o.
//	All rights reserved.
//

#import "NSError+SCMethods.h"

@implementation NSError (SCMethods)

+ (NSError *)errorWithDomain:(NSString *)domain code:(NSInteger)code
				 description:(NSString *)description failureReason:(NSString *)failureReason {
	
	NSError *result = [NSError errorWithDomain:domain code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
																		  description, NSLocalizedDescriptionKey,
																		  failureReason, NSLocalizedFailureReasonErrorKey,
																		  nil]];
	return result;
}

@end
