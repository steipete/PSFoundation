//
//  PSCompatibility.h
//  PSFoundation
//
//  Created by Peter Steinberger on 09.09.10.
//  Licensed under MIT. All rights reserved.
//
//  References:
//   - http://blancer.com/tutorials/i-phone/72236/tips-tricks-for-conditional-ios3-ios3-2-and-ios4-code/
//

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_2_0
#define kCFCoreFoundationVersionNumber_iPhoneOS_2_0 478.23
#endif

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_2_1
#define kCFCoreFoundationVersionNumber_iPhoneOS_2_1 478.26
#endif

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_2_2
#define kCFCoreFoundationVersionNumber_iPhoneOS_2_2 478.29
#endif

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_3_0
#define kCFCoreFoundationVersionNumber_iPhoneOS_3_0 478.47
#endif

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_3_1
#define kCFCoreFoundationVersionNumber_iPhoneOS_3_1 478.52
#endif

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_3_2
#define kCFCoreFoundationVersionNumber_iPhoneOS_3_2 478.61
#endif

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_4_0
#define kCFCoreFoundationVersionNumber_iPhoneOS_4_0 550.32
#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
#define IF_IOS4_OR_GREATER(...) \
if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iPhoneOS_4_0) \
{ \
__VA_ARGS__ \
}
#else
#define IF_IOS4_OR_GREATER(...)
#endif

#define IF_PRE_IOS4(...)  \
if (kCFCoreFoundationVersionNumber < kCFCoreFoundationVersionNumber_iPhoneOS_4_0)  \
{ \
  __VA_ARGS__ \
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 32000
#define IF_3_2_OR_GREATER(...) \
if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iPhoneOS_3_2) \
{ \
__VA_ARGS__ \
}
#else
#define IF_3_2_OR_GREATER(...)
#endif

#define IF_PRE_3_2(...) \
if (kCFCoreFoundationVersionNumber < kCFCoreFoundationVersionNumber_iPhoneOS_3_2) \
{ \
__VA_ARGS__ \
}

// special addition for Chameleon support: http://chameleonproject.org/
#if TARGET_IPHONE_SIMULATOR
#define IS_IOS 1
#define IS_MAC 0
#define IF_IOS(...) do {__VA_ARGS__} while(0);
#define IF_DESKTOP(...)
#elif TARGET_OS_IPHONE
#define IS_IOS 1
#define IS_MAC 0
#define IF_IOS(...) do {__VA_ARGS__} while(0);
#define IF_DESKTOP(...)
#else
#define IS_IOS 0
#define IS_MAC 1
#define IF_IOS(...)
#define IF_DESKTOP(...) do {__VA_ARGS__} while(0);
#endif

#define isIPad() [[UIDevice currentDevice] isTablet]