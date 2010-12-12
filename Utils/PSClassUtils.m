//
//  PSClassUtils.m
//
//  Created by Peter Steinberger on 08.01.10.
//

#import "PSClassUtils.h"


@implementation PSClassUtils

+ (void)swizzleSelector:(SEL)orig ofClass:(Class)c withSelector:(SEL)newSelector;
{
  Method origMethod = class_getInstanceMethod(c, orig);
  Method newMethod = class_getInstanceMethod(c, newSelector);
  
  if (class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
  {
    class_replaceMethod(c, newSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
  }
  else
  {
    method_exchangeImplementations(origMethod, newMethod);
  }
}

@end
