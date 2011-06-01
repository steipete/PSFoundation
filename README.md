Overview
========

PSFoundation - a Christmas gift from dear @steipete - is more or less a second Foundation, with great tools that aid the development of UIKit apps both on iOS and the Mac.  Best of all, it's App Store safe and used in a number of released apps.

What's In The Box?
==================

* Categories that extend most Foundation and UIKit classes, with functions you always wished you had, really.
  * Blocks-based macros and selectors for collection classes.
  * Better, block-based invocation.
  * Easer view management.
  * ... and much more! 
* Helper for automatic archiving/unarchiving (TPAutoArchiver)
* HUD classes (MBProgressHUD and DSActivityView)
* Invocation Helper (DDInvocationGrabber, NSInvocation+blocks)
* Keychain Helper (SFHFKeychainUtils)
* Logger (a fork of cocoa-lumberjack + NSLogger-Integration, HOLog, Log (for easy printing))
* SynthesizeSingleton
* IKNetworkActivityManager
* Reachability (with modifications)
* Apple SoundEffect (with modifications)
* GradientButtons, a stock UIButton subclass
* Block-based UIAlertView and UIActionSheet
* A StatusBar-Saver
* Hundreds of easy-to-use macros for compatibility and faster coding
* MAZeroWeakReferences for safe delegates
* EGOCache & EGOImageLoader (for dead easy html image loading)
* Appirater (for more App Store ratings)
* PSCompatibility (fast macros for IOS4/3.2/3.1)
* MCRelease, MCReleaseNil, custom assert macros...
* Table View Helpers
  * PSGenericView/PSGenericView - for super fast drawRect-cells
  * GradientView / ShadowedTableView / UACellBackgroundView - more visual awesomeness!
* Core Data Helpers
  * ActiveRecord (a fork of https://github.com/magicalpanda/activerecord-fetching-for-core-data)
  * SafeFetchedResultsController (the NSFetchedResultsController subclass you wished you found earlier!)* PSTableViewController (like UITableViewController, just with subview support)

Getting Started
===============

Clone or download the repository.

In Xcode 4, click-and-drag (or add using File > Add Files to Project) the PSFoundation XCode project into a project or workspace.  Enter your target's settings and ad PSFoundation (and any of the CoreData/CoreLocation derivatives) to "Target Dependencies", then add libPSFoundation.a (and the derivatives) to "Link Binary with Libraries".  libPSFoundation will appear in red both in that section and in the source list; don't worry, this is a known bug with Xcode.  Additionally, set "Header Search Paths" to `$(BUILT_PRODUCTS_DIR)/**`.

If you're running on iOS, add (or replace) "All Linker Flags" in your project with `-ObjC -all_load`.  The downside to this is that you will have to link the frameworks that Xcode usually weak links by default (see below), but, on the upside, your app won't crash when using PSFoundation's categories.

_If you use [https://github.com/zwaldowski/BlocksKit](BlocksKit), it must be removed from your project before including PSFoundation, which has its own version._

Use of the iOS static library requires linking against the following frameworks or libraries in the parent project:
 * SystemConfiguration
 * QuartzCore
 * CoreGraphics
 * AudioToolbox
 * Security
 * CFNetwork
 * MobilecoreServices
 * libz.1.dylib

Usage of the CoreData and CoreLocation libraries require linking against CoreData and ImageIO, respectively.

For use in Mac apps, no extra frameworks are required; PSFoundation.dylib already links against everything.

Once all of that is done, simply `#import <PSFoundation.h>` in any file in your project.  _It is not recommended to include PSFoundation in your prefix header._

License
=======

PSFoundation itself (and all the custom code from [https://github.com/steipete](steipete), [https://github.com/zwaldowski](zwaldowski), and [https://github.com/myell0w](myell0w)) is licensed under MIT.  The source code included in PSFoundation is a mix of MIT, BSD, Apache, and public domain code.  You can find the individual licenses in the LICENSES/ folder as well as in the header of each file.