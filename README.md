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

_If you use [https://github.com/zwaldowski/BlocksKit](BlocksKit), it must be removed from your project prior to including PSFoundation, which has its own copy._

1. Clone the repository:  ````git clone git://github.com/steipete/PSFoundation.git && cd PSFoundation````
2. _(For using the refactor branch:)_  ````git checkout refactor2````
3. Clone all submodules: ````git submodule update --init````
4.  Click-and-drag PSFoundation.xcodoeproj into your project or workspace.
5.  Enter your target's settings and add PSFoundation (and any the CoreData/CoreLocation derivatives) to "Target Dependencies", then add libPSFoundation.a **(iOS)** or libPSFoundation.dylib **(Mac)** to "Link Binary with Libraries".
6.  Add `$(BUILT_PRODUCTS_DIR)/PSFoundation` to "Header Search Paths".
7.  **(iOS only):**  Add (or replace) "All Linker Flags" in your project with `-ObjC -all_load`.
8.  **(iOS only):**  Link your project against the following frameworks:
  * SystemConfiguration
  * QuartzCore
  * CoreGraphics
  * ImageIO
  * AudioToolbox
  * Security
  * CFNetwork
  * MobilecoreServices
  * libz.1.dylib
  * CoreData (_libPSFoundation-CoreData only_)
9.  `#import <PSFoundation.h>` in any file in your project.  _It is not recommended to include PSFoundation in your prefix header.

License
=======

PSFoundation itself (and all the custom code from [@steipete](https://github.com/steipete), [@zwaldowski](https://github.com/zwaldowski), and [@myell0w](https://github.com/myell0w)) is licensed under MIT.  The source code included in PSFoundation is a mix of MIT, BSD, Apache, and public domain code.  You can find the individual licenses in the LICENSES/ folder as well as in the header of most files.