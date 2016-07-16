# KongaPay_iOS_SDK

##THE KongaPay iOS Framework Documentation.
The kongapay iOS framework is designed for use in iOS development environment. It can be installed and used by anyone who wishes to use the KongaPay payment service to accept payment on their native iPhone, iPad and iPod touch applications.
This framework can be integrated seamlessly into your development environment and used in your development. It was developed using Apple’s Objective C programming language, and can run in the Xcode IDE.
##KongaPay Framework Integration

#### Integration Using CocoaPads
1. If you have configured your xcode project to use cocoapods already, then open your podfile and paste the following

    ```objective-c
      pod 'KongaPayPaymentService', '~> 1.0.3'
      ```
then update your podfile by running pod update from the terminal window.
2. For those who have not configured their xcode project to use cocoapods, you can find the reference on how to do that here:
[Configure xcode to use cocoapods](http://blogs.triffort.com/?p=309)


#### Direct Integration Using Zip Files

1. Download the ZIP files from this repository
 
   **KongaPayPaymentService.framework and KongaPayPaymentService.bundle**.


2. Unzip the downloaded file and add these files into your project by dragging them into your project navigation column in your Xcode development environment. You can add them to a framework group for purpose of organization.
Don’t forget to click on the “copy items if needed “ check box while adding the framework to your project. 

###KongaPay Framework Usage

To use framework in your ViewController or view you will have to perform the following actions:

1. Import the KongaPayPaymentService framework in your ViewController or view this is demonstrated below:

      ```objective-c
      #import <KongaPayPaymentService/KongaPayPaymentService.h>
      ```

2. Implement the KongaPayPaymentComplete delegate which will contain the delegate methods. The KongaPayment delegate, contains delegate methods that provide feedback and act as a way for you to handle responses after payment.

      ```objective-c
      @interface ... ()<KongaPayPaymentCompleteDelegate>
      ```

3. Implement the KongaPayPaymentCompleteDelegate delegate methods in the
view controller or view where you wish to initiate the payment to enable you handle the response from Pre-approved payments and One-off payments. These delegate methods are listed below:

     ```objective-c
     -(void)paymentDidCompleteSuccessfully:(id)theresponseData:
     ```
This delegate method is called on a successful One-off payment process with the payment data response sent through “theresponseData” variable.


    ```objective-c
    -(void)paymentDidFailWithError:(id)theErrorData:
    ```
This delegate method is called when a One-off payment process fails with the response data sent through “therErrorData” variable.
 
 
 
    ```objective-c
    -(void)linkMerchantDidCompleteSuccessfully:(id)theresponseData
    ```
This delegate method is called on a successful Pre-approved payment call with the response data sent through “theresponseData” variable.


    ```objective-c
    -(void)linkMerchantDidFailWithError:(id)theErrorData
    ```
This delegate method is called when a Pre-approved payment fails and the response data is sent through “theErrorData” variable.


##Using the KongaPay Framework for Payment

There are two ways of using the KongaPay Framework for payment:

1.To perform a one time payment

2.To allow users authorize for pre approved payments

###One-Time Payment
 To use the framework for one-time payment you have to initialize KongaPayRegisteration Class as demonstrated below.

   ```objective-c
   KongaPayRegisteration *_regHandler = [[KongaPayRegisteration alloc] initWithPayMerchantView:@"Merchant_id"  theTransactionID: @"Transaction_id"  theAmount:@"Amount"  theClientKey:@"Client_key  isLiveEnvironment:Value"];
   ```

**Merchant_id** = Your merchant ID as a merchant wanting to use the kongaPay Payment Service. This would have been given to you when you registered with KongaPay

**Transaction_id** = The ID of the transaction which you want KongaPay to be used as a payment for. This must be unique for every transaction. You can use any value for testing purpose, but it must be unique per transaction

**Amount** = This is the cost of the item to be paid for using KongaPay Amount should be in the format 5000.00, 200.00, etc.

**Client_Key** = This is your client key given to you when you registered with KongaPay as a merchant or seller.

**Value** = a boolean value indicating the environment on which you are implementing. A value of “YES” signifies you are implementing with the live environment, while a value of “NO” signifies you are implementing with the Test environment
On successful payment the paymentDidCompleteSuccessfully delegate method listed in process 3 above is triggered, which you will handle in your Implementation. On Failure, the paymentDidFailWithError delegate method is triggered.


###Pre-approved Payment

A pre-approved payment is one in which merchants can charge a user without the user explicitly initiating such payments provided the user has authorized such transactions for a particular merchant. To use the framework for this purpose, initialize the KongaPayRegisteration Class as demonstrated below:
   ```objective-c
   KongaPayRegisteration *_regHandler = [[KongaPayRegisteration alloc] initWithLinkMerchantView:@"Merchant_id" theClientKey:@"Client_Key" isLiveEnvironment:Value];
   ```

**Merchant_id** = Your merchant ID as a merchant wanting to use the KongaPay Payment Service. This would have been given to you when you registered with KongaPay.

**Client_Key** = This is your client key given to you when you registered with KongaPay as a merchant or seller.

**Value** = a boolean value indicating the environment on which you are implementing. A value of “YES” signifies you are implementing with the live environment, while a value of “NO” signifies you are implementing with the Test environment.

On successful pre-approved payment, the linkMerchantDidCompleteSuccessfully delegate method  listed in process 3 above is triggered, with a linked token as its response object. You may be required to supply this token to perform auto billing for a subscriber of your service. On Failure, the linkMerchantDidFailWithError delegate method is triggered.




###Setting Delegate

Finally you need to set the KongaPayPaymentService delegate to your viewcontroller or view after initialisation as shown in Pre-approved Payment and One-Time Payment above. If the delegate is not set you will not get responses from the four delegate methods implemented in process 3 above.

  ```objective-c
  _regHandler.delegate = self;
  ```
###Testing Framework

Use the following default values for testing purpose in the sandbox environment

**Merchant_id** = kongaPayApp

**Client_Key** = Kpay4pp$ss

**Phone Number** = 08189460199

**PIN** = 2233

**OTP** = 1234


##Thank you and have a nice time using the KongaPay Payment iOS Framework



#Making Payments Using KongaPay Payment Token Linked with A User’s KongaPay Account

After successfully linking a User’s KongaPay Account to a Merchant’s account, Payment Token is provided to the Merchant by KongaPay which is to be used by the Merchant to make payments on behalf of the User. 
This documentation covers how to make payments on behalf of the User using the KongaPay Payment Token. This is based on the assumption that implementing Merchant has KongaPay Payment Tokens that is to be debited.

1. Generate Access Token 

All requests to KongaPay requires an Access Token. To generate an Access Token, KongaPay is to provide the merchant with both Merchant ID and Client Secret.

Definition of parameters:
merchant_id - Merchant Id provided by KongaPay. String (Maximum of 15 characters)
client_secret - Client Secret provided by KongaPay. This should be kept securely by the Merchant. String (Maximum of 30 characters)
access_code - Access Code is generated by a GET request to the Auth server. Access code is required to generate Access Token. It expires after 30 seconds. String (Maximum of 128 characters)
access_token - Access Token is required to make any request to KongaPay. It expires after 6 hours. String (Maximum of 128 characters)
refresh_token - Refresh Token can be used to get a new Access Token after the expiration of the Access Token. It expires after 14 days. String (Maximum of 128 characters)

OAuth 2.0 Authentication
This follows the standard OAuth 2.0 flow where:
Client requests an access code
KongaPay returns the access code on success of step 1 request
Client uses the access code to request access token
KongaPay returns the access token and refresh token on success of step 3 request
Client then uses the access token to request resources from the server.

Base URL for OAuth: https://staging-auth.kongapay.com

Step I
To request for an access code 
URL: {{oauth_base_url}}/authorize?response_type=code&client_id={merchant_id}&state=alive
Request Type: GET

Step II
Success Message:
{
  "status": "success",
  "data": {
    "code": "{access_code}"
  }
}

Error message:
{
  "error": "invalid_client",
  "error_description": "The client id supplied is invalid"
}

Step III
Use access code to request token
URL: {{oauth_base_url}}/token
Request Type: POST (application/json)
Parameters: 
grant_type = authorization_code
code = {access_code} (the code returned from Step II)
client_id = {merchant_id}
client_secret = {client_secret}

Step IV
Success Message to  Step III 
{
"access_token": "{access_token}",
"expires_in": 21600,
"token_type": "Bearer",
"scope": null,
"refresh_token": “{refresh_token}”
}

Error Message
{
  "error": "invalid_grant",
  "error_description": "Authorization code doesn't exist or is invalid for the client"
}

Step V-a
Using refresh token to get another get another access token
URL: {{oauth_base_url}}/token
Request Type: POST
Receives a form-data post with the following parameters
grant_type = refresh_token
refresh_token = “{refresh_token}” (the refresh token returned from step 2)
client_id = “{merchant_id}”
client_secret = “{client_id}”

Step V-b
Server returns another token.
{
  "access_token": “{access_token}”,
  "expires_in": 21600,
  "token_type": "Bearer",
  "scope": null
}

NOTE: Token/code expiration
The access token expires after 6 hours. Once the access token expires, the refresh token can be used to request for another token which will last for another 6 hours. However, refresh token expires after 14 days. Once the refresh token expires, the client needs to request another access code which will kick-start the flow again from the beginning.
Access code expires 30 secs after it was requested which means the access code must have been used to request a token within 30 secs.


2. Debiting a KongaPay Linked Account with Token

This allow Merchants to debit a linked KongaPay Account using the Payment Token provided by KongaPay.

Base URL for KongaPay: https://api-sandbox.kongapay.com/v3/

Definition of parameters:
merchant_id - Merchant Id provided by KongaPay. String (Maximum of 15).
access_token - Access Token is required to make any request to KongaPay. It expires after 6 hours. String (Maximum of 128 characters).
payment_reference - Unique payment reference to be provided by the Merchant. String (Maximum of 32 characters).
token - Payment Token provided by KongaPay after successful linking of KongaPay account to Merchant’s account either via SDK or web. String (Maximum of 150 characters).
amount - Amount to be debited in Naira.Kobo. Example 2005.45 will be read as Two Thousand Naira Forty Five Kobo. String (Maximum of 10 characters).
currency_code - The Currency code of the transaction. Only Naira (566) accepted for now. String (Maximum of 3 characters).
status - Status of the transaction. Expected “success” or “error”.
transaction_reference - Transaction Reference supplied by KongaPay after a successful transaction. String (Maximum of 20 characters).
error_message - Error message sent back from KongaPay when an error occurs. String (Maximum of 1000 characters).
error_code - Error code sent back from KongaPay when an error occurs. String (Maximum of 5 characters).

Access Code from No. 1 above is required to make payment using Payment Token.

Endpoint: {{kongapay_base_url}}/payments/wallet/merchant/{merchant_id}/pay?access_token={access_token}

Request:
Request Type: POST
Receives a JSON payload in the following format:
{
  "payment_reference": "{payment_reference}",
  "token": "{token}",
  "amount": "{amount}",
  "currency_code": "566"
}

Successful Response:
{
  "status": "success",
  "data": {
    "transaction_reference": "{transaction_reference}"
  }
}

Error response:
{
  "status": "error",
  "message": “{error_message}”,
  "code": “{error_code}”
}

3. Requery a KongaPay Transaction

This allow Merchants to requery a KongaPay transaction using the payment_reference used in making payment.

Base URL for KongaPay: https://api-sandbox.kongapay.com/v3/

Definition of parameters:
merchant_id - Merchant Id provided by KongaPay. String (Maximum of 15).
access_token - Access Token is required to make any request to KongaPay. It expires after 6 hours. String (Maximum of 128 characters).
payment_reference - Unique payment reference to be provided by the Merchant. String (Maximum of 32 characters).
token - Payment Token provided by KongaPay after successful linking of KongaPay account to Merchant’s account either via SDK or web. String (Maximum of 150 characters).
amount - Amount to be debited in Naira.Kobo. Example 2005.45 will be read as Two Thousand Naira Forty Five Kobo. String (Maximum of 10 characters).
currency_code - The Currency code of the transaction. Only Naira (566) accepted for now. String (Maximum of 3 characters).
status - Status of the transaction. Expected “success” or “error”.
transaction_reference - Transaction Reference supplied by KongaPay after a successful transaction. String (Maximum of 20 characters).
response_code - Check Response Codes and Description below.
error_message - Error message sent back from KongaPay when an error occurs. String (Maximum of 1000 characters).
error_code - Error code sent back from KongaPay when an error occurs. String (Maximum of 5 characters).

Access Code from No. 1 above is required to make payment using Payment Token.

Endpoint: 
{kongapay_base_url}/payments/{payment_reference}/merchant/{merchant_id}?access_token={access_token}

Request:
Request Type: GET

Successful Response:
{
  "status": "success",
  "data": {
    "payment_reference": "{payment_reference}",
    "amount": "{amount}",
    "transaction_status": "{transaction_status}",
    "currency_code": "566",
    "transaction_reference": "{transaction_reference}"
    "type": "incoming",
    "transaction_date": "2016-02-29 14:02:30"
  }
}


Response Codes and Description
K00 - Success
K01 - Insufficient funds
K02 - Transaction not found
K03 - Fail
