//
//  PSGradientView.h
//  PSFoundation
//
//  Includes code by the following:
//   - Matt Gallagher.    2009. Public domain.
//   - Sam Soffes.        2011. Public domain.
//   - Zachary Waldowski. 2011. MIT.
//

@interface PSGradientView : UIView

@property (copy) NSArray *colors;
@property (copy) NSArray *locations;
@property (assign) BOOL horizontal;

@end
