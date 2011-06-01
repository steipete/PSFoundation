//
//  NSObject+BlockObservation.h
//  Version 1.0
//
//  Andy Matuschak
//  andy@andymatuschak.org
//  Public domain because I love you. Let me know how you use it.
//
// http://www.mikeash.com/pyblog/key-value-observing-done-right.html
// http://blog.andymatuschak.org/private/1070660478/tumblr_l8acac1Dlg1qzk3gw
// https://gist.github.com/153676/4eecf9d6dd54cc44f4932b97352554717a5c3547

typedef NSString AMBlockToken;
typedef void (^AMBlockTask)(id obj, NSDictionary *change);

@interface NSObject (AMBlockObservation)

- (AMBlockToken *)addObserverForKeyPath:(NSString *)keyPath task:(AMBlockTask)task;
- (AMBlockToken *)addObserverForKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue task:(AMBlockTask)task;
- (void)removeObserverWithBlockToken:(AMBlockToken *)token;

@end
