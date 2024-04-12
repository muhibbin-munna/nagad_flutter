<p align="center" >
  <img src="https://github.com/muhibbin-munna/nagad_flutter/blob/master/images/nagad_logo.png?raw=true" alt="Nagad Logo" height="80" >
</p>

 <h1 align="center">Nagad Online Payment
API Integration Flutter Package</h1>
<p align="center" >
</p>

This is a [Flutter package](https://pub.dev/packages/nagad_payment_gateway)  for the merchants and service providers that want to
incorporate a new online payment method provided by Nagad.

> Note : Get your merchant credentials by contacting Nagad.

### # Credentials to be provided by Nagad

```
final merchantID = "Specific Merchant id"
final merchantPrivateKey = "Merchant Private Key"
final pgPublicKey = "Nagad Payment Gateway public Key"
```
## Initialize the `Nagad` instance:
Create an instance of Credentials and provide it to the Nagad Instance: 

```
Nagad nagad = Nagad(
      credentials: const Credentials(
          merchantID: merchantID,
          merchantPrivateKey: merchantPrivateKey,
          pgPublicKey: merchantPrivateKey,
          isSandbox: true)); // switch to false for production
```
> Note: Make sure to replace the provided credentials with your Nagad Sandbox or production credentials.

### Set Additional Merchant Info
| Additional Merchant Info Fields| Length | Description |
|---------------------------------|------------------|-------------|
|serviceName|25|Service Name Provided by Merchant|
|serviceLogoURL|1~1024|Publicly accessible logo URL|
|additionalFieldName EN|20|Additional Field Name to be shown in Payment Page for Locale EN|
|additionalFieldName BN|20|Additional Field Name to be shown in Payment Page for Locale BN|
|additionalFieldValue|20|Value of Additional Field in English|

```
Expample:

{
    “serviceName” : “T Shirt”,
    “serviceLogoURL” : “tinyurl.com/sampleLogoUrl”,
    “additionalFieldNameEN” : “Color”,
    “additionalFieldNameBN” : “রং”,
    “additionalFieldValue” : “White”
}
```

>N.B: Additional Merchant Info can be anything and will be saved for further usage. However only these fields will be shown in the payment page.

## Regular Payment
To make a regular merchant payment, use the `pay` method:

### Parameters

`amount:` The amount for payment</br>
`orderID:` This is unique identifier to place order for payment. You can use current millisecondsSinceEpoch for uniqueness. 

***Request***
```
DateTime now = DateTime.now();
String orderId = 'order${now.millisecondsSinceEpoch}';
StatusAPIResponse statusAPIResponse =
                    await nagad.pay(context, amount: 10.0, orderId: orderId);
```
***Response***: 
StatusAPIResponse contains 
1. merchantId
2. orderId
3. paymentRefId
4. amount
5. clientMobileNo
6. merchantMobileNo
7. orderDateTime
8. issuerPaymentDateTime
9. issuerPaymentRefNo
10. additionalMerchantInfo
11. status
12. statusCode
13. cancelIssuerDateTime
14. cancelIssuerRefNo
15. serviceType
> N.B: Save the required information to your database if needed 

## License

[nagad_payment_gateway](https://pub.dev/packages/nagad_payment_gateway) package is licensed under the [GNU General Public License (GPL) version 3.0](https://www.gnu.org/licenses/gpl-3.0.html).

©2024

