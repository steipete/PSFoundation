//
//  JMWhenTappedBlockKeeper.m
//
//  Created by Jake Marsh on 3/7/11.
//  Copyright 2011 Rubber Duck Software. All rights reserved.
//

#if NS_BLOCKS_AVAILABLE

#import "JMWhenTappedBlockKeeper.h"

JMWhenTappedBlockKeeper *_sharedInstance = nil;

@implementation JMWhenTappedBlockKeeper

+ (JMWhenTappedBlockKeeper *) sharedInstance {
	if(!_sharedInstance) {
		_sharedInstance = [[JMWhenTappedBlockKeeper alloc] init];
	}

	return _sharedInstance;
}

- (id) init {    
    if ((self = [super init])) {
        _whenTappedBlocks = [[NSMutableDictionary alloc] init];
        _whenTouchedDownBlocks = [[NSMutableDictionary alloc] init];
        _whenTouchedUpBlocks = [[NSMutableDictionary alloc] init];
    }

    return self;
}

- (void) setBlock:(WhenTappedBlock)b forWhenViewIsTapped:(UIView *)v {
	WhenTappedBlock blockToSet = [b copy];

	[_whenTappedBlocks setObject:blockToSet forKey:[NSString stringWithFormat:@"%D", [v hash]]];

	[blockToSet release];
}
- (void) setBlock:(WhenTouchedDownBlock)b forWhenViewIsTouchedDown:(UIView *)v {
	WhenTouchedDownBlock blockToSet = [b copy];

	[_whenTouchedDownBlocks setObject:blockToSet forKey:[NSString stringWithFormat:@"%D", [v hash]]];

	[blockToSet release];
}
- (void) setBlock:(WhenTouchedUpBlock)b forWhenViewIsTouchedUp:(UIView *)v {
	WhenTouchedUpBlock blockToSet = [b copy];

	[_whenTouchedUpBlocks setObject:blockToSet forKey:[NSString stringWithFormat:@"%D", [v hash]]];

	[blockToSet release];
}

- (WhenTappedBlock) whenTappedBlockForView:(UIView *)v {
	WhenTappedBlock b = [_whenTappedBlocks objectForKey:[NSString stringWithFormat:@"%D", [v hash]]];

	return [[b copy] autorelease];
}
- (WhenTouchedDownBlock) whenTouchedDownBlockForView:(UIView *)v {
	if ([_whenTouchedDownBlocks objectForKey:[NSString stringWithFormat:@"%D", [v hash]]]) {
		WhenTouchedDownBlock b = [_whenTouchedDownBlocks objectForKey:[NSString stringWithFormat:@"%D", [v hash]]];
		
		return [[b copy] autorelease];		
	} else {
		return nil;
	}
}
- (WhenTouchedUpBlock) whenTouchedUpBlockForView:(UIView *)v {
	if([_whenTouchedUpBlocks objectForKey:[NSString stringWithFormat:@"%D", [v hash]]]) {
		WhenTouchedUpBlock b = [_whenTouchedUpBlocks objectForKey:[NSString stringWithFormat:@"%D", [v hash]]];
		
		return [[b copy] autorelease];		
	} else {
		return nil;
	}
}

#pragma mark UIGestureRecognizerDelegate Methods

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
	return YES;
}

- (void) dealloc {
    [_whenTappedBlocks release];
	[_whenTouchedDownBlocks release];
	[_whenTouchedUpBlocks release];

    [super dealloc];
}

@end

#endif