//
//  PSCategories.h
//
//  Created by Peter Steinberger on 03.05.10.
//

// NSArray/NSSet //////////////////////////////////////////////////////////////////////////////////
#import "NSArray+blocks.h"
#import "NSArray+Linq.h"
#import "NSMutableArray+SCQueue.h"

// arrayBySortingStrings, firstObject, uniqueMembers, map, collect, reject, removeFirstObject, reverse,
// scramble, Stack-Tools like pop, pull, objectUsingPredicate
#import "NSArray-Utilities.h"                                 // BSD

#import "NSSet+blocks.h"

#import "MACollectionUtilities.h"

// NSData /////////////////////////////////////////////////////////////////////////////////////////

// Base64 de/encoding by google
#import "GTMBase64.h"                                       // Apache 2.0

// [kPSCommonCompression] zlib additions
#import "GTMNSData+zlib.h"                                  // Apache 2.0

// [kPSCommonCrypto] crypto stuff like MD5, SHA1, AES256
#import "NSData+CommonCrypto.h"                             // New BSD

// NSDate /////////////////////////////////////////////////////////////////////////////////////////

// prettyDate, prettyDateWithReference, ps_yesterday, ps_tomorrow, ...
#import "NSDate+PSFoundation.h"                                    // own

// isToday, isTomorrow, isThisYear
#import "NSDate-Utilities.h"                                // http://github.com/erica/NSDate-Extensions


// NSDictionary////////////////////////////////////////////////////////////////////////////////////

// containsObjectForKey, isEmpty
#import "NSDictionaryHelper.h"

#import "NSDictionary+CGStructs.h"

#import "JRSwizzle.h"


// NSFileManager //////////////////////////////////////////////////////////////////////////////////

// NSDocumentsFolder(), NSLibraryFolder(), NSTmpFolder(), NSBundleFolder(), pathForItemNamed, filesInFolder...
#import "NSFileManager-Utilities.h"                         // BSD


// NSNotifications ////////////////////////////////////////////////////////////////////////////////

// postNotificationOnMainThread, postNotificationOnMainThreadWithName
#import "NSNotificationAdditions.h"                         // -


// NSNumber ///////////////////////////////////////////////////////////////////////////////////////

// numberWithString
#import "NSNumberAdditions.h"                               // own


// NSObject ///////////////////////////////////////////////////////////////////////////////////////

// dd_invokeOnMainThread, dd_invokeOnMainThreadAndWaitUntilDone, dd_invokeOnThread
#import "NSObject+DDExtensions.h"                           // BSD

// make
#import "NSObject+Utilities.h"

// helper for automatic description!
#import "NSObject+AutoDescription.h"

// http://petersteinberger.com/2010/10/how-to-mock-asihttprequest-with-ocmock-and-blocks/
#import "NSObject+Blocks.h"


// NSOperationQueue ///////////////////////////////////////////////////////////////////////////////

// sharedOperationQueue, NSObject:performSelectorInBackgroundQueue
#import "NSOperationQueue+CWSharedQueue.h"                  // -


// NSString ///////////////////////////////////////////////////////////////////////////////////////

// replaceOccurrencesOfString
#import "NSMutableString+PSAdditions.h"

//gtm_stringByEscapingForHTML, gtm_stringByUnescapingFromHTML, ...
#import "GTMNSString+HTML.h"                                // Apache 2.0

// various string representations
#import "NSString+Cat.h"                                    // -

// [kPSCommonLibXML] flattenHTML, removeWhitespace, removeAllWhitespaces, replaceAllWhitespacesWithSpace
#import "NSString+FlattenHTML.h"                            // -

// containsString, md5, longValue, longLongValue, stringByTruncatingToLength, stringByReplacingString
#import "NSStringHelper.h"                                  // BSD

// stringWithMaxLength, urlWithoutParameters, stringByReplacingRange
#import "StringUtil.h"                                      // -

// dasherize, underscore, camelize, titleize
#import "NSString+InflectionSupport.h"

// gsub - string substitution
#import "NSString+GSub.h"

// UIKit //////////////////////////////////////////////////////////////////////////////////////////

// (UIImageView *)imageViewNamed:(NSString *)imageName;
#import "UIImageView+PSLib.h"                               // own

// + (UILabel *)labelWithText:(NSString *)text;
#import "UILabel+PSLib.h"                                   // own

#import "UIToolBar+PSLib.h"

#import "UIView+Sizes.h"
#import "UIView+PSAdditions.m"

#import "UIScreen+PSAdditions.h"

// setApplicationStyle animated
#import "UIApplicationHelper.h"                             // New BSD

// setPathToRoundedRect, drawGlossyRect, setBackgroundToGlossyRectOfColor
#import "UIButton+Glossy.h"                                 // 3-clause BSD
#import "UIButton+Presets.h"

// showWithMessage fromTabBar|fromToolbar|inView
#import "UIActionSheet+SCMethods.h"                         // 4-clause BSD

// alertViewFromError, showWithMessage, showWithTitle message
#import "UIAlertView+SCMethods.h"                           // 4-clause BSD

// availableMemory, platform, isJailbroken, debugInfo
#import "UIDeviceHelper.h"                                   // BSD

// UIImage ////////////////////////////////////////////////////////////////////////////////////////

// hasAlpha, imageWithAlpha, transparentBorderImage
#import "UIImage+Alpha.h"                                   // custom, free for commercial use

// roundedCornerImage
#import "UIImage+RoundedCorner.h"                           // custom, free for commercial use

// imageWithContentsOfURL, scaleToSize (...), colorizeImage
#import "UIImageHelper.h"                                   // BSD

// cachedImageWithContentsOfFile, initWithContentsOfResolutionIndependentFile
#import "UIImage+Cache.h"
#import "UIImage+Tint.h"
#import "UIImage+ProportionalFill.h"


#import "NSError+SCMethods.h"

#import "NilCategories.h"

#import "NSObject+BlockObservation.h"
