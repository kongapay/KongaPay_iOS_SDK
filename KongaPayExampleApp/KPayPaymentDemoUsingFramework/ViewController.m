//
//  ViewController.m
//  KPayPaymentDemoUsingFramework
//
//  Created by ehiss on 12/22/15.
//  Copyright © 2015 KongaPay. All rights reserved.
//

#import "ViewController.h"
#import <KongaPayPaymentService/KongaPayPaymentService.h>

@interface ViewController ()<KongaPayPaymentCompleteDelegate>
{
    KongaPayRegisteration *_regHandler;
    IBOutlet UITextField *theTransactionId;
    IBOutlet UITextField *theamount;
    IBOutlet UIImageView *liveImageView;
    IBOutlet UIImageView *sandboxImageView;
    BOOL isLive;
    BOOL environmentSelected;
}
-(IBAction)payUsingKongaPay:(UIButton *)sender;
-(IBAction)selectEnvironment:(UIButton *)sender;
@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)payUsingKongaPay:(UIButton *)sender
{
    //NSLog(@"you want to pay using konga pay abi");
    if (! environmentSelected)
    {
        UIAlertView *alertWithMessage=[[UIAlertView alloc]initWithTitle:@"select an environment" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertWithMessage show];
        
        return;
    }
    
    else if([theTransactionId.text isEqualToString:@""] && sender.tag == 1)
    {
        UIAlertView *alertWithMessage=[[UIAlertView alloc]initWithTitle:@"Enter a Transaction reference" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertWithMessage show];
        
        return;
    }
    else if ([theamount.text isEqualToString:@""] && sender.tag == 1)
    {
        UIAlertView *alertWithMessage=[[UIAlertView alloc]initWithTitle:@"Enter an amount" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertWithMessage show];
        
        return;
    }
    else
    {
        
        if(sender.tag == 1)
        {
            _regHandler = [[KongaPayRegisteration alloc] initWithPayMerchantView:@"kongaPayApp" theTransactionID:theTransactionId.text theAmount:theamount.text theClientKey:@"Kpay4pp$ss" isLiveEnviroment:isLive];
            _regHandler.delegate = self;
        }
        else
        {
            _regHandler = [[KongaPayRegisteration alloc] initWithLinkMerchantView:@"kongaPayApp" theClientKey:@"Kpay4pp$ss" isLiveEnviroment:isLive];
            _regHandler.delegate = self;
        }
    }
    
    //[self.view addSubview:_regHandler];
}

-(IBAction)selectEnvironment:(UIButton *)sender
{
    environmentSelected = YES;
    if(sender.tag == 1)
    {
        liveImageView.image = [UIImage imageNamed:@"checkbox_checked.png"];
        sandboxImageView.image = [UIImage imageNamed:@"btn_check_inactive"];
        
        isLive= YES;
        
    }
    else
    {
        sandboxImageView.image = [UIImage imageNamed:@"checkbox_checked.png"];
        liveImageView.image = [UIImage imageNamed:@"btn_check_inactive"];
        
        isLive= NO;
    }
    
}


-(void)paymentDidCompleteSuccessfully:(id)theresponseData
{
    //Framework user implements whatever callback he wishes after successfull payment
    NSLog(@"payment has been completed with the following data %@", theresponseData);
}
-(void)paymentDidFailWithError:(id)theErrorData
{
    //framework user implement whatever call back he requires after payment fails
    NSLog(@"payment failed with the following data %@", theErrorData);
}

-(void)linkMerchantDidCompleteSuccessfully:(id)theresponseData
{
    NSLog(@"linking has been completed with the following data %@", theresponseData);
}
-(void)linkMerchantDidFailWithError:(id)theErrorData
{
    NSLog(@"linking failed with the following data %@", theErrorData);
}



@end
