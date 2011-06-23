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

#import "DDInvocationGrabber.h"
#import "NSObject+Utilities.h"

@implementation DDInvocationGrabber

+ (id)invocationGrabber {
    PS_RETURN_AUTORELEASED([DDInvocationGrabber alloc]);
}

- (id)init {
    _target = nil;
    _invocation = nil;
    _forwardInvokesOnMainThread = NO;
    _invocationThread = nil;
    _waitUntilDone = NO;
    
    return self;
}

- (void)dealloc {
    PS_RELEASE_NIL(_target);
    PS_RELEASE_NIL(_invocation);
    PS_DEALLOC();
}

#pragma mark -

- (id)target
{
    return _target;
}

- (void)setTarget:(id)inTarget
{
    if (_target != inTarget)
	{
        PS_RELEASE(_target);
        _target = PS_RETAIN(inTarget);
	}
}

- (NSInvocation *)invocation
{
    return _invocation;
}

- (void)setInvocation:(NSInvocation *)inInvocation
{
    if (_invocation != inInvocation) {
        PS_RELEASE(_invocation);
        _target = PS_RETAIN(inInvocation);
	}
}

- (BOOL)forwardInvokesOnMainThread; {
    return _forwardInvokesOnMainThread;
}

- (void)setForwardInvokesOnMainThread:(BOOL)forwardInvokesOnMainThread;
{
    _forwardInvokesOnMainThread = forwardInvokesOnMainThread;
}

#if (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
- (void)setInvokesOnThread:(NSThread *)thread;
{
    _invocationThread = thread;
}
#endif

- (BOOL)waitUntilDone;
{
    return _waitUntilDone;
}

- (void)setWaitUntilDone:(BOOL)waitUntilDone;
{
    _waitUntilDone = waitUntilDone;
}

#pragma mark -

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    return [[self target] methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)ioInvocation
{
    [ioInvocation setTarget:[self target]];
    [self setInvocation:ioInvocation];
    BOOL invokeOnOtherThread = _forwardInvokesOnMainThread || (_invocationThread != nil);
    if (invokeOnOtherThread && !_waitUntilDone)
    {
        [_invocation retainArguments];
    }
    
    if (_forwardInvokesOnMainThread)
    {
        [_invocation performSelectorOnMainThread:@selector(invoke)
                                      withObject:nil
                                   waitUntilDone:_waitUntilDone];
    }
    
#if (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
    if (_invocationThread != nil)
    {
        [_invocation performSelector:@selector(invoke)
                            onThread:_invocationThread
                          withObject:nil
                       waitUntilDone:_waitUntilDone];
    }
#endif
}

@end

#pragma mark -

@implementation DDInvocationGrabber (DDnvocationGrabber_Conveniences)

- (id)prepareWithInvocationTarget:(id)inTarget
{
    [self setTarget:inTarget];
    return(self);
}

@end
