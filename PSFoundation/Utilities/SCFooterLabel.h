//
//  SCFooterLabel.h
//  PSFoundation
//
//  Created by Aleks Nesterow on 3/12/10.
//	Licensed under MIT.  Copyright 2010 Screen Customs s.r.o.
//

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
