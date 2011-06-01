/*
 The MIT License
 
 Copyright (c) 2010 Nick Farina
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE. 
*/

// SMModelObject is a very handy superclass for "Model Object" types.
// It requires the 64-bit runtime, either iOS (any version) or Snow Leopard, and LLVM Clang >=1.6.

// Additionally, as of this writing, you'll need to add the compiler flags "-Xclang -fobjc-nonfragile-abi2" in that exact
// order if you don't want to have to write @synthesize yourself. This shouldn't be necessary after the official Clang 2.0 release. More info about that here:
// http://www.mcubedsw.com/blog/index.php/site/comments/new_objective-c_features/

// Much, much credit given to André Pang and his phenomenal RMModelObject which was the inspiration for this class.
// https://github.com/andrep/RMModelObject

@interface SMModelObject : NSObject<NSCoding,NSCopying,NSFastEnumeration>
@end
