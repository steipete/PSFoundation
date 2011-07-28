//
//  NSManagedObject+PSAutoDescription.m
//  PSFoundation (CoreData)
//

#import "NSManagedObject+PSAutoDescription.h"
#import "NSObject+AutoDescription.h"

@implementation NSManagedObject (PSAutoDescription)

- (NSString *)description {
  return  [NSObject autoDescribe:self];
}

@end
