//
//  PSNonEditableTextView.h
//  PSFoundation
//
//  Created by Peter Steinberger on 19.11.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#define PSNonEdiableTextView PSNodEditableTextView

@interface PSNonEditableTextView : UITextView {
}

+ (id)textViewForText:(NSString *)text;

@end
