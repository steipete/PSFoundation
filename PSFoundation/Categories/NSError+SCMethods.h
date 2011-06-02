//
//  NSError+SCMethods.h
//  PSFoundation
//
//  Created by Aleks Nesterow on 3/14/10.
//	Licensed under MIT.  Copyright 2010 Screen Customs s.r.o.
//

@interface NSError (SCMethods)

+ (NSError *)errorWithDomain:(NSString *)domain code:(NSInteger)code description:(NSString *)description failureReason:(NSString *)failReason;
+ (NSError *)errorWithDomain:(NSString *)domain code:(NSInteger)code description:(NSString *)description;

@end
