//
// Made by Aled Samuel 2015
//

#import <UIKit/UIKit.h>

#import <StoreKit/StoreKit.h>

@interface ASSKStoreActivity : UIActivity <SKStoreProductViewControllerDelegate, SKRequestDelegate>

@property (nonatomic, strong) NSURL *url;

@end
