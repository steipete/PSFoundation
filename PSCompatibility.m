//
//  PSCompatibility.m
//  PSFoundation
//
//  Created by Peter Steinberger on 09.09.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "PSCompatibility.h"

BOOL isIPad()
{
  IF_3_2_OR_GREATER
  (
   if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
   {
     return YES;
   }
   );

  return NO;
}
