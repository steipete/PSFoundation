//
//  NSObject+Proxy.h
//  PSFoundation
//
//  Includes code by the following:
//   - Corey Floyd.
//   - Steve Degutis.
//

@interface NSObject (SDStuff)

- (id) nextRunloopProxy;
- (id) proxyWithDelay:(float)time;

@end
