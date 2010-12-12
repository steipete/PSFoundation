//
//  NSObject+Proxy.h
//  
//
//  Created by Corey Floyd.
//  Borrowed From Steve Degutis and Peter Hosey, with a splash of me
//

#import <UIKit/UIKit.h>

@interface NSObject (SDStuff)

- (id) nextRunloopProxy;
- (id) proxyWithDelay:(float)time;
- (id) performOnMainThreadProxy;

@end
