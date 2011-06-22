//
//  UIViewExtras.m
//
// (c) 2008, Ramin Firoozye. Openly licensed under BSD for personal or
// commercial use.
//
// HOW TO IMPLEMENT:
//
// - Include this file in our iPhone XCode project and build it for debugging.
// - Um, that's pretty much it.
//
// HOW TO USE IT:
//
// - Set a breakpoint in your code, somewhere after a view has been loaded
//   (i.e. in your 'viewDidLoad' method).
// - Open the debugger console and type 'po {name-of-your-view-variable}'<ret>
// - Ordinarily, showing a UIView* derived object gets you this:
//
//   (gdb) po _front
//   <BCCardSideView: 0x106b020>
//
// With this file built into your project, you will get a dump of the object
// with a full recursive traversal of all subviews. Here's what the same statement
// above looks like with UIViewExtras enabled:
//
// (gdb) po _front
// + BCCardSideView retain:3 - tag:0 - bgcolor:(r:0 g:0 b:0 a:1.00)
//    bounds: x:0 y:0 w:130 h:80 - frame: x:5 y:5 w:130 h:80 - center: x:70, y:45
// ++ BCCardBackgroundView retain:4 - tag:0 - bgcolor:(r:255 g:255 b:0 a:1.00)
//     bounds: x:0 y:0 w:130 h:80 - frame: x:5 y:5 w:130 h:80 - center: x:70, y:45
// ++ BCCardTextView retain:4 - tag:0 - bgcolor:(r:0 g:255 b:255 a:1.00)
//     bounds: x:0 y:0 w:100 h:20 - frame: x:0 y:0 w:100 h:20 - center: x:50, y:10
//     text (len:4 - color:r:0 g:255 b:0 a:0.00): 'name'
// ++ BCCardTextView retain:4 - tag:0 - bgcolor:(r:255 g:255 b:0 a:0.00)
//     bounds: x:0 y:0 w:100 h:20 - frame: x:0 y:20 w:100 h:20 - center: x:50, y:30
//     text (len:5 - color:r:0 g:255 b:0 a:0.00): 'title'
// ++ BCCardTextView retain:4 - tag:0 - bgcolor:(r:0 g:0 b:255 a:1.00)
//     bounds: x:0 y:0 w:100 h:20 - frame: x:0 y:40 w:100 h:20 - center: x:50, y:50
//     text (len:5 - color:r:0 g:255 b:0 a:0.00): 'email'
// ++ BCCardTextView retain:4 - tag:0 - bgcolor:(r:255 g:0 b:0 a:1.00)
//     bounds: x:0 y:0 w:60 h:20 - frame: x:0 y:60 w:60 h:20 - center: x:30, y:70
//     text (len:7 - color:r:0 g:255 b:0 a:0.00): 'phone.1'
//
// For each view object you see:
//
// - The retain count.
// - The tag value (if specified).
// - The background color value in RGBA. RGB values are scaled up to 0..255.
//   Alpha is shown between 0 and 1.
// - View bounds rectangle (x, y, width, height)
// - View frame rectangle (x, y, width, height)
// - View center (x, y)
//
// If view is a Label or TextField, you also get:
// - Length of text
// - RGB value for text itself (vs. the background)
// - Actual value of the 'text' inside the field.
//
// Subviews are indented by multiple "+" signs. So the top-level has one '+'
// all its subviews have two '+' signs, *their* subviews will each have
// three '+' signs etc.
//
// The full source code is in this file. Feel free to augment and contribute
// back to the common pool.
//

@implementation UIView (NSObject)

- (NSString*) listColor:(UIColor*) color
{
	int r = 0, g = 0, b = 0;
	CGFloat alpha = 1.0;
	CGFloat* colors;
	if (color) {
		colors = (CGFloat *) CGColorGetComponents(color.CGColor);
		if (colors) {
			r = (int) (255 * colors[0]);
			g = (int) (255 * colors[1]);
			b = (int) (255 * colors[2]);
			alpha = colors[3];
		}
	}
    return [NSString stringWithFormat:@"r:%d g:%d b:%d a:%.2f", r, g, b, alpha];
}

- (void) describeText:(NSMutableString*)str view:(UIView *)v indent:(int)level
{
	CGFloat bx = 0.0, by = 0.0, bw = 0.0, bh = 0.0;
	CGFloat fx = 0.0, fy = 0.0, fw = 0.0, fh = 0.0;
	CGFloat cx = 0.0, cy = 0.0;
	NSString *indentString1 = [[NSString stringWithString:@""] stringByPaddingToLength:level withString:@"+" startingAtIndex:0];
	NSString *indentString2 = [[NSString stringWithString:@""] stringByPaddingToLength:level+2 withString:@" " startingAtIndex:0];

	if (v) {
		CGRect bd = v.bounds;
		bx = bd.origin.x;
		by = bd.origin.y;
		bw = bd.size.width;
		bh = bd.size.height;
		CGRect fd = v.frame;
		fx = fd.origin.x;
		fy = fd.origin.y;
		fw = fd.size.width;
		fh = fd.size.height;
		cx = v.center.x;
		cy = v.center.y;

		[str appendFormat:@"+%@ %s - tag:%d - bgcolor:(%@)\n"
		 @"%@ bounds: x:%.0f y:%.0f w:%.0f h:%.0f - frame: x:%.0f y:%.0f w:%.0f h:%.0f - center: x:%.0f, y:%.0f\n",
		indentString1, object_getClassName(v), v.tag, [self listColor:v.backgroundColor],
		 indentString2, bx, by, bw, bh, fx, fy, fw, fh, cx, cy];
		if ([v isKindOfClass:[UILabel class]]) {
			UILabel* label = (UILabel*) v;
			if (label.text)
				[str appendFormat:@"%@ text (len:%d - color:%@): '%@'\n", indentString2, [label.text length],
				 [self listColor:label.textColor],
				 label.text];
		} else
		if ([v isKindOfClass:[UITextField class]]) {
			UITextField* tf = (UITextField*) v;
			if (tf.text)
				[str appendFormat:@"%@ text (len:%d - color:%@): '%@'\n", indentString2, [tf.text length],
				[self listColor:tf.textColor],
				tf.text];
		}
	} else {
		[str appendFormat:@"%@--null--\n"];
	}
}

- (NSString *)describeOne:(NSMutableString *)result view:(UIView*)view indent:(int)level
{
	[self describeText:result view:view indent:level];

	for (UIView* subview in view.subviews) {
		[self describeOne:result view:subview indent:level+1];
	}
	return result;
}

#if kPSDetailedUIViewDescription
- (NSString *)description {
	UIView* topView = (UIView *) self;
	int	indentLevel = 0;
	NSMutableString* result = [[[NSMutableString alloc] init] autorelease];

	[self describeOne:result view:topView indent:indentLevel];
	return result;
}
#endif

@end
