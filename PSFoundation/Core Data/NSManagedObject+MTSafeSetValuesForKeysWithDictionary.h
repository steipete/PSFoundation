//
//  NSManagedObject+MTSafeSetValuesForKeysWithDictionary.h
//  PSFoundation
//
//  Created by Matthias Tretter on 02.06.11.
//  Copyright 2011 @myell0w. All rights reserved.
//
//  Taken from: http://www.cimgf.com/2011/06/02/saving-json-to-core-data/

#import <CoreData/CoreData.h>

@interface NSManagedObject (MTSafeSetValuesForKeysWithDictionary)

- (void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues;
- (void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter;

@end
