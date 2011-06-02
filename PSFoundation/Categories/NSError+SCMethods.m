//
//  NSError+SCMethods.m
//  PSFoundation
//
//  Created by Aleks Nesterow on 3/14/10.
//	Licensed under MIT.  Copyright 2010 Screen Customs s.r.o.
//

#import "NSError+SCMethods.h"

@implementation NSError (SCMethods)

+ (NSError *)errorWithDomain:(NSString *)domain code:(NSInteger)code
                 description:(NSString *)description {

	NSError *result = [NSError errorWithDomain:domain code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                        description, NSLocalizedDescriptionKey,
                                                                        nil]];
	return result;
}


+ (NSError *)errorWithDomain:(NSString *)domain code:(NSInteger)code
				 description:(NSString *)description failureReason:(NSString *)failureReason {
	
	NSError *result = [NSError errorWithDomain:domain code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
																		  description, NSLocalizedDescriptionKey,
																		  failureReason, NSLocalizedFailureReasonErrorKey,
																		  nil]];
	return result;
}

@end
