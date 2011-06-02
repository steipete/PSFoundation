//
//  PSCategories.h
//
//  Created by Peter Steinberger on 03.05.10.
//

// checks whether or not objects are empty
#import "NilCategories.h"

// Collections ////////////////////////////////////////////////////////////////////////////////////

// BlocksKit backwards-compatibility
#import "NSArray+Linq.h"
#import "MACollectionUtilities.h"

// a variety of basic utilities
#import "NSMutableArray+SCQueue.h"
#import "NSMutableArray+MTShuffle.h"
#import "NSArrayHelper.h"

// arrayBySortingStrings, firstObject, uniqueMembers, map, collect, reject, removeFirstObject, reverse,
// scramble, Stack-Tools like pop, pull, objectUsingPredicate
#import "NSArray-Utilities.h"

// encode and decode UIKit geometry in a dictionary
#import "NSDictionary+CGStructs.h"

// NSData /////////////////////////////////////////////////////////////////////////////////////////

// Base64 decoding/encoding
#import "GTMBase64.h"

// Zlib utilities
#import "NSData+zlib.h"

// [kPSCommonCrypto] crypto stuff like MD5, SHA1, AES256
#import "NSData+CommonCrypto.h"

// override description for fun and glory!
#import "NSData+RSHexDump.h"

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
#import "NSNotificationAdditions.h"

// NSNumber ///////////////////////////////////////////////////////////////////////////////////////

// numberWithString
#import "NSNumberAdditions.h"

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

// replaceOccurrencesOfString
#import "NSMutableString+PSAdditions.h"

//gtm_stringByEscapingForHTML, gtm_stringByUnescapingFromHTML, ...
#import "GTMNSString+HTML.h"

// various string representations
#import "NSString+Conversion.h"
#import "NSString+Truncation.h"

// [kPSCommonLibXML] flattenHTML, removeWhitespace, removeAllWhitespaces, replaceAllWhitespacesWithSpace
#import "NSString+FlattenHTML.h"

// containsString, md5, longValue, longLongValue, stringByTruncatingToLength, stringByReplacingString
#import "NSString+PSFoundation.h"

// stringWithMaxLength, urlWithoutParameters, stringByReplacingRange
#import "StringUtil.h"

// dasherize, underscore, camelize, titleize
#import "NSString+InflectionSupport.h"

// gsub - string substitution
#import "NSString+GSub.h"

// NSURL ///////////////////////////////////////////////////////////////////////////////////////

#import "NSURLHelper.h"
#import "NSURL+PSFoundation.h"

// UIKit //////////////////////////////////////////////////////////////////////////////////////////

#import "SKProduct+LocalizedPrice.h"

// showWithMessage fromTabBar|fromToolbar|inView
#import "UIActionSheet+SCMethods.h"

// alertViewFromError, showWithMessage, showWithTitle message
#import "UIAlertView+SCMethods.h"

// setApplicationStyle animated
#import "UIApplication+PSFoundation.h"

#if IS_IOS // not all of the CG stuff is available in Chameleon yet.
// setPathToRoundedRect, drawGlossyRect, setBackgroundToGlossyRectOfColor
#import "UIButton+Glossy.h"
#import "UIButton+Presets.h"
#endif

#import "UIColor+PSFoundation.h"

// availableMemory, platform, isJailbroken, debugInfo
#import "UIDeviceHelper.h"

// hasAlpha, imageWithAlpha, transparentBorderImage
#import "UIImage+Alpha.h"

// roundedCornerImage
#import "UIImage+RoundedCorner.h"

// imageWithContentsOfURL, scaleToSize (...), colorizeImage
#import "UIImageHelper.h"

// cachedImageWithContentsOfFile, initWithContentsOfResolutionIndependentFile
#import "UIImage+Cache.h"
#import "UIImage+Tint.h"
#import "UIImage+ProportionalFill.h"
#import "UIImage+MTCache.h"
#import "UIImage+MTTiling.h"
#import "UIImage+MTUniversalAdditions.h"

// (UIImageView *)imageViewNamed:(NSString *)imageName;
#import "UIImageView+PSFoundation.h"

// + (UILabel *)labelWithText:(NSString *)text;
#import "UILabel+PSFoundation.h"

#import "UINavigationBar+CustomBackground.h"

#import "UIScreen+PSFoundation.h"

#import "UIScrollView+MTUIAdditions.h"

#import "UIToolbar+PSFoundation.h"

#import "UIView+Sizes.h"
#import "UIView+Animation.h"
#import "UIView+PSAdditions.m"
#import "UIView+MTUIAdditions.h"
#import "UIView+Hierarchy.h"
#import "UIViewHelper.h"

#import "UIViewControllerHelper.h"
#import "UIViewController+MTUIAdditions.h"