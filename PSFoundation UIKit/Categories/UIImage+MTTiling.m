//
//  UIImage+MTTiling.m
//  PSFoundation
//
//  Created by Matthias Tretter.
//  Licensed under MIT.  All rights reserved.
//

#import "UIImage+MTTiling.h"


@implementation UIImage (MTTiling)

- (void)saveTilesOfSize:(CGSize)size
            toDirectory:(NSString*)directoryPath
            usingPrefix:(NSString*)prefix
{
	CGFloat cols = [self size].width / size.width;
	CGFloat rows = [self size].height / size.height;

	int fullColumns = floorf(cols);
	int fullRows = floorf(rows);

	CGFloat remainderWidth = [self size].width - (fullColumns * size.width);
	CGFloat remainderHeight = [self size].height - (fullRows * size.height);


	if (cols > fullColumns) fullColumns++;
	if (rows > fullRows) fullRows++;

	CGImageRef fullImage = [self CGImage];

	for (int y = 0; y < fullRows; ++y) {
		for (int x = 0; x < fullColumns; ++x) {
			CGSize tileSize = size;
			if (x + 1 == fullColumns && remainderWidth > 0) {
				// Last column
				tileSize.width = remainderWidth;
			}
			if (y + 1 == fullRows && remainderHeight > 0) {
				// Last row
				tileSize.height = remainderHeight;
			}

			CGImageRef tileImage = CGImageCreateWithImageInRect(fullImage, (CGRect){{x*size.width, y*size.height}, tileSize});
            
			NSData *imageData = UIImagePNGRepresentation([UIImage imageWithCGImage:tileImage]);
            
            CGImageRelease(tileImage);
            
			NSString *path = [NSString stringWithFormat:@"%@/%@%d_%d.png",
							  directoryPath, prefix, x, y];

			[imageData writeToFile:path atomically:NO];
		}
	}
}

@end
