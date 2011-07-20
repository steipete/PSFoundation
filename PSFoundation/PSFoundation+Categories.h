//
//  PSCategories.h
//
//  Created by Peter Steinberger on 03.05.10.
//

// Collections ////////////////////////////////////////////////////////////////////////////////////

#import "NSArray+PSFoundation.h"
#import "NSArray+Structures.h"
#import "NSArray+Filtering.h"

#import "NSDictionary+PSFoundation.h"
#import "NSDictionary+CGStructs.h"

#import "NSSet+PSFoundation.h"

// NSData /////////////////////////////////////////////////////////////////////////////////////////

// Base64 decoding/encoding
#import "GTMBase64.h"

// Zlib utilities
#import "GTMNSData+zlib.h"

// [kPSCommonCrypto] crypto stuff like MD5, SHA1, AES256
#import "NSData+CommonCrypto.h"

// override description for fun and glory!
#import "NSData+RSHexDump.h"

#import "NSData+MTAdditions.h"

// NSDate /////////////////////////////////////////////////////////////////////////////////////////

// prettyDate, prettyDateWithReference, ps_yesterday, ps_tomorrow, ...
#import "NSDate+PSFoundation.h"
#import "NSDate+MTAdditions.h"

// isToday, isTomorrow, isThisYear
#import "NSDate+Utilities.h"

#import "TimeFormatters.h"

// NSError ///////////////////////////////////////////////////////////////////////////////////////

#import "NSError+SCMethods.h"

// NSFileManager //////////////////////////////////////////////////////////////////////////////////

#import "NSFileManager+PSFoundation.h"

// NSNotifications ////////////////////////////////////////////////////////////////////////////////

// postNotificationOnMainThread, postNotificationOnMainThreadWithName
#import "NSNotification+PSFoundation.h"

// NSNumber ///////////////////////////////////////////////////////////////////////////////////////

// numberWithString
#import "NSNumber+PSFoundation.h"

// NSObject ///////////////////////////////////////////////////////////////////////////////////////

// dd_invokeOnMainThread, dd_invokeOnMainThreadAndWaitUntilDone, dd_invokeOnThread
#import "NSObject+DDExtensions.h"

// make
#import "NSObject+Utilities.h"

// helper for automatic description!
#import "NSObject+AutoDescription.h"

// exposes the 10.6+/iOS associated objects API  (incl. BlocksKit)
#import "NSObject+AssociatedObjects.h"

// take a wild guess.  Go on, guess!
#import "NSObject+Swizzle.h"

// NSOperationQueue ///////////////////////////////////////////////////////////////////////////////

// sharedOperationQueue, NSObject:performSelectorInBackgroundQueue
#import "NSOperationQueue+CWSharedQueue.h"

// NSString ///////////////////////////////////////////////////////////////////////////////////////

// urlWithoutParameters
#import "NSString+URL.h"

// various string representations
#import "NSString+Conversion.h"

// stringWithMaxLength, stringByTruncatingToLength
#import "NSString+Truncation.h"

// flattenHTML, removeing whitespace
#import "NSString+HTML.h"

// containsString, hashing
#import "NSString+PSFoundation.h"

// stringByReplacingString, replaceOccurrencesOfString, stringByReplacingRange, gsub
#import "NSString+Replacement.h"

// dasherize, underscore, camelize, titleize
#import "NSString+InflectionSupport.h"

// NSURL ///////////////////////////////////////////////////////////////////////////////////////

#import "NSURL+PSFoundation.h"
