//
//  NSManagedObject+AutoDescription.m
//  Created by Peter Steinberger on 09.09.10.
//

#import "NSManagedObject+AutoDescription.h"
#import "NSObject+AutoDescription.h"

@implementation NSManagedObject(AutoDescription)

- (NSString *)description {
  return  [NSObject autoDescribe:self];
}

@end
