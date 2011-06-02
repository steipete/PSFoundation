//
//  NSObject+AutoDescription.m
//  PSFoundation
//
//  Created by Peter Steinberger on 09.09.10.
//  Licensed under MIT.  All rights reserved.
//

#import "NSObject+AutoDescription.h"
#import <objc/runtime.h>

@implementation NSObject(AutoDescription)

// Finds all properties of an object, and prints each one out as part of a string describing the class.
+ (NSString *) autoDescribe:(id)instance classType:(Class)classType
{
  NSUInteger count;
  objc_property_t *propList = class_copyPropertyList(classType, &count);
  NSMutableString *propPrint = [NSMutableString string];
  
  for ( int i = 0; i < count; i++ )
  {
    objc_property_t property = propList[i];
    
    const char *propName = property_getName(property);
    NSString *propNameString =[NSString stringWithCString:propName encoding:NSASCIIStringEncoding];
    
    if(propName) 
    {
      id value = [instance valueForKey:propNameString];
      // break describe cycle
      if (NSClassFromString(@"NSManagedObject") && [value isKindOfClass:NSClassFromString(@"NSManagedObject")]) {
        [propPrint appendString:[NSString stringWithFormat:@"%@=%@ ; ", propNameString, [value class]]];
      }else {
        [propPrint appendString:[NSString stringWithFormat:@"%@=%@ ; ", propNameString, value]];
      }
    }
  }
  free(propList);
  
  
  // Now see if we need to map any superclasses as well.
  Class superClass = class_getSuperclass( classType );
  if ( superClass != nil && ! [superClass isEqual:[NSObject class]] )
  {
    NSString *superString = [self autoDescribe:instance classType:superClass];
    [propPrint appendString:superString];
  }
  
  return propPrint;
}

+ (NSString *) autoDescribe:(id)instance
{
  NSString *headerString = [NSString stringWithFormat:@"%@:%p:: ",[instance class], instance];
  return [headerString stringByAppendingString:[self autoDescribe:instance classType:[instance class]]];
}

@end
