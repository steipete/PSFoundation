//
//  IKNetworkActivityManager.h
//  PSFoundation
//
//  Includes code by the following:
//   - Ilya Kulakov.       2010.
//   - Zachary Waldowski.  2011.  MIT.
//

@interface IKNetworkActivityManager : NSObject {
@private
    NSMutableSet *users;
    NSUInteger count;
}

+ (IKNetworkActivityManager *)sharedInstance;

- (IKNetworkActivityManager *)initWithCapacity:(NSInteger)capacity;

- (void)addNetworkUser:(id)aUser;
- (void)removeNetworkUser:(id)aUser;
- (void)removeAllNetworkUsers;

- (void)incrementNetworkUsage;
- (void)decrementNetworkUsage;

@end