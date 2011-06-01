//
//  SCFooterLabel.h
//  TouchCustoms
//
//  Created by Aleks Nesterow on 3/12/10.
//	aleks.nesterow@gmail.com
//	
//  Copyright © 2010 Screen Customs s.r.o.
//	All rights reserved.
//	
//	Purpose
//	UILabel that is intended to be inserted as a UITableView footer.
//	Tweaked to has the same shadow, font color and style.
//

#import <UIKit/UIKit.h>

@interface SCFooterLabel : UILabel {

}

/** 
  * You can still instantiate the label with other init* methods.
  * This method is optional, but you're encouraged to you use it.
  * 
  * Note, that in case you're going with another init method,
  * you will need to set label's width to the width of the parent 
  * UITableView manually (usually 320 px), otherwise, heightForCurrentText
  * method will return wrong value.
  */
- (id)initWithText:(NSString *)footerText;

/**
  * Call this in tableView:heightForFooterInSection: method.
  */
- (CGFloat)heightForCurrentText;

@end
