//
//  SKProduct+LocalizedPrice.h
//
//  Created by Peter Steinberger on 19.03.10.
//

#if kPSCommonStoreKit

#import <StoreKit/StoreKit.h>

// http://troybrant.net/blog/2010/01/in-app-purchases-a-full-walkthrough/
@interface SKProduct (LocalizedPrice)

@property (nonatomic, readonly) NSString *localizedPrice;

@end
#endif
