//
//  PSGlobal.m
//
//  Created by Peter Steinberger on 09.11.09.
//

#import "PSGlobal.h"


CGFloat PSAppWidth() {
  if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
    return [UIScreen mainScreen].bounds.size.width;
  } else {
    return [UIScreen mainScreen].bounds.size.height;
  }
}

inline NSString *MTDocumentsDirectory() {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
