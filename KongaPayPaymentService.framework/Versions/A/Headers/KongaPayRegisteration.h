//
//  KongaPayRegisteration.h
//  KongaPayPaymentService
//
//  Created by ehiss on 12/21/15.
//  Copyright © 2015 KongaPay. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol KongaPayPaymentCompleteDelegate <NSObject>

@optional -(void)paymentDidCompleteSuccessfully:(id)theresponseData;
@optional -(void)paymentDidFailWithError:(id)theErrorData;
@required -(void)linkMerchantDidCompleteSuccessfully:(id)theresponseData;
@required -(void)linkMerchantDidFailWithError:(id)theErrorData;

@end

@interface KongaPayRegisteration : UIView

@property (nonatomic, weak) id<KongaPayPaymentCompleteDelegate>delegate;
- (instancetype)initWithPayMerchantView:(UIView *)theView theMerchantID:(NSString *)merchantID theTransactionID:(NSString *)transactionID theAmount:(NSString *)amountPayable theClientKey:(NSString *)clientKey isLiveEnviroment:(BOOL)liveEnviroment;

- (instancetype)initWithLinkMerchantView:(UIView *)theView theMerchantID:(NSString *)merchantID theClientKey:(NSString *)clientKey isLiveEnviroment:(BOOL)liveEnviroment;

@end
