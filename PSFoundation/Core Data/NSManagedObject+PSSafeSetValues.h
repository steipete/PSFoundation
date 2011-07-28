//
//  NSManagedObject+PSSafeSetValues.h
//  PSFoundation (CoreData)
//

#import <CoreData/CoreData.h>

/** A safer version of setValuesForKeysWithDictionary:.

 Includes code by the following:

 - [Tom Harrington](http://cimgf.com/2011/06/02/saving-json-to-core-data) - 2011. BSD.
 - [Matthias Tretter](https://github.com/myell0w) - 2011. MIT.

 @warning Documentation on this class/category is incomplete.

 */
@interface NSManagedObject (PSSafeSetValues)

- (void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues;
- (void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter;

@end
