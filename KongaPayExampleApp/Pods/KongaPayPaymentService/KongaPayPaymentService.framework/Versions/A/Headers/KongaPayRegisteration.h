//
//  KongaPayRegisteration.h
//  KongaPayPaymentService
//
//  Created by ehiss on 12/21/15.
//  Copyright © 2015 KongaPay. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol KongaPayPaymentCompleteDelegate <NSObject>

@optional
 -(void)paymentDidCompleteSuccessfully:(id)theresponseData;
-(void)paymentDidFailWithError:(id)theErrorData;
-(void)linkMerchantDidCompleteSuccessfully:(id)theresponseData;
-(void)linkMerchantDidFailWithError:(id)theErrorData;

@end

@interface KongaPayRegisteration : UIView

@property (nonatomic, weak) id<KongaPayPaymentCompleteDelegate>delegate;
- (instancetype)initWithPayMerchantView:(NSString *)merchantID theTransactionID:(NSString *)transactionID theAmount:(NSString *)amountPayable theClientKey:(NSString *)clientKey isLiveEnviroment:(BOOL)liveEnviroment;

- (instancetype)initWithLinkMerchantView:(NSString *)merchantID theClientKey:(NSString *)clientKey isLiveEnviroment:(BOOL)liveEnviroment;

@end
