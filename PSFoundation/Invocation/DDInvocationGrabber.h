/*
 * Copyright (c) 2007-2009 Dave Dribin
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


/*
 *  This class is based on CInvocationGrabber:
 *
 *  Copyright (c) 2007, Toxic Software
 *  All rights reserved.
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *
 *  * Redistributions of source code must retain the above copyright notice,
 *  this list of conditions and the following disclaimer.
 *
 *  * Redistributions in binary form must reproduce the above copyright
 *  notice, this list of conditions and the following disclaimer in the
 *  documentation and/or other materials provided with the distribution.
 *
 *  * Neither the name of the Toxic Software nor the names of its
 *  contributors may be used to endorse or promote products derived from
 *  this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 *  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE
 *  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 *  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 *  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 *  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 *  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 *  THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

/**
 * @class DDInvocationGrabber
 * @discussion DDInvocationGrabber is a helper object that makes it very easy to construct instances of NSInvocation for later use. The object is inspired by NSUndoManager's prepareWithInvocationTarget method. To use a DDInvocationGrabber object, you set its target to some object, then send it a message as if it were the target object (the DDInvocationGrabber object acts as a proxy), if the target message understands the message the DDInvocationGrabber object stores the message invocation.

 DDInvocationGrabber *theGrabber = [DDInvocationGrabber invocationGrabber];
 [theGrabber setTarget:someObject]
 [theGrabber doSomethingWithParameter:someParameter]; // Send messages to 'theGrabber' as if it were 'someObject'
 NSInvocation *theInvocation = [theGrabber invocation];

 A slightly more concise version (using the covenience category) follows:

 DDInvocationGrabber *theGrabber = [DDInvocationGrabber invocationGrabber];
 [[theGrabber prepareWithInvocationTarget:someObject] doSomethingWithParameter:someParameter];
 NSInvocation *theInvocation = [theGrabber invocation];

 */
@interface DDInvocationGrabber : NSProxy
{
	id _target;
	NSInvocation * _invocation;
    BOOL _forwardInvokesOnMainThread;
    NSThread * _invocationThread;
    BOOL _waitUntilDone;
}

/**
 * @method invocationGrabber
 * @abstract Returns a newly allocated, inited, autoreleased DDInvocationGrabber object.
 */
+ (id)invocationGrabber;

- (id)target;
- (void)setTarget:(id)inTarget;

- (NSInvocation *)invocation;
- (void)setInvocation:(NSInvocation *)inInvocation;

- (BOOL)forwardInvokesOnMainThread;
- (void)setForwardInvokesOnMainThread:(BOOL)forwardInvokesOnMainThread;

#if (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
- (void)setInvokesOnThread:(NSThread *)thread;
#endif

- (BOOL)waitUntilDone;
- (void)setWaitUntilDone:(BOOL)waitUntilDone;

@end

@interface DDInvocationGrabber (DDInvocationGrabber_Conveniences)

/**
 * @method prepareWithInvocationTarget:
 * @abstract Sets the target object of the receiver and returns itself. The sender can then send a message to the
 */
- (id)prepareWithInvocationTarget:(id)inTarget;

@end
