//
//  NSError+SCMethods.h
//  TouchCustoms
//
//  Created by Aleks Nesterow on 3/14/10.
//	aleks.nesterow@gmail.com
//  Extended by Peter Steinberger
//
//  Copyright © 2010 Screen Customs s.r.o.
//	All rights reserved.
//
//	Purpose
//	Extension methods for NSError.
//

@interface NSError (SCMethods)

+ (NSError *)errorWithDomain:(NSString *)domain code:(NSInteger)code description:(NSString *)description failureReason:(NSString *)failReason;
+ (NSError *)errorWithDomain:(NSString *)domain code:(NSInteger)code description:(NSString *)description;

@end
