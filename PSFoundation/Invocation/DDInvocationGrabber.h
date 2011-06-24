//
//  DDInvocationGrabber.h
//  PSFoundation
//  
//  Includes code by the following:
//   - Dave Dribin.       2009.  MIT.
//   - Toxic Software.    2007.  BSD.
//   - Zachary Waldowski. 2011.  MIT.
//

/**
 * @class DDInvocationGrabber
 * @discussion DDInvocationGrabber is a helper object that makes it very easy to construct instances of NSInvocation for later use. The object is inspired by NSUndoManager's prepareWithInvocationTarget method. To use a DDInvocationGrabber object, you set its target to some object, then send it a message as if it were the target object (the DDInvocationGrabber object acts as a proxy), if the target message understands the message the DDInvocationGrabber object stores the message invocation.

 DDInvocationGrabber *theGrabber = [DDInvocationGrabber invocationGrabber];
 [theGrabber setTarget:someObject]
 [theGrabber doSomethingWithParameter:someParameter]; // Send messages to 'theGrabber' as if it were 'someObject'
 NSInvocation *theInvocation = [theGrabber invocation];

 A slightly more concise version follows:

 DDInvocationGrabber *theGrabber = [DDInvocationGrabber invocationGrabberWithTarget:someObject];
 [theGrabber doSomethingWithParameter:someParameter];
 NSInvocation *theInvocation = [theGrabber invocation];
 */

@interface DDInvocationGrabber : NSProxy

+ (id)invocationGrabber;
+ (id)invocationGrabberWithTarget:(id)target;
- (id)prepareWithInvocationTarget:(id)inTarget;

@property (nonatomic, retain) id target;
@property (nonatomic, retain) NSInvocation *invocation;
@property (nonatomic, retain, setter = setInvokesOnThread:) NSThread *invocationThread;
@property (nonatomic, assign) BOOL forwardInvokesOnMainThread;
@property (nonatomic, assign) BOOL waitUntilDone;

@end