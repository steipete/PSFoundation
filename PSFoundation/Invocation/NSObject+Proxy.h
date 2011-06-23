//
//  NSObject+Proxy.h
//  PSFoundation
//
//  Includes code by the following:
//   - Corey Floyd.
//   - Steve Degutis.
//   - Peter Hosey.
//

@interface NSObject (SDStuff)

- (id) nextRunloopProxy;
- (id) proxyWithDelay:(float)time;
- (id) performOnMainThreadProxy;

@end
