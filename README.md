<p align="center">
  <img src="https://github.com/muhibbin-munna/nagad_flutter/blob/master/images/nagad_logo.png?raw=true" alt="Nagad Logo" height="80" style="display: block; margin: 0 auto;">
</p>


 <h1 align="center">Nagad Online Payment
API Integration Flutter Package</h1>
<p align="center" >
</p>

The [nagad_payment_gateway](https://pub.dev/packages/nagad_payment_gateway)  package allows Flutter developers to integrate Nagad Online Payment into their applications. This package is ideal for merchants and service providers looking to enable digital payments using Nagad.

### Credentials Provided by Nagad

Before integrating, obtain your credentials from Nagad:

```
final merchantID = "YOUR_MERCHANT_ID"
final merchantPrivateKey = "YOUR_MERCHANT_PRIVATE_KEY"
final pgPublicKey = "NAGAD_PAYMENT_GATEWAY_PUBLIC_KEY"
```
## Initialize the `Nagad` instance:
Create an instance of Credentials and provide it to the Nagad Instance: 

```dart
Nagad nagad = Nagad(
      credentials: const Credentials(
          merchantID: merchantID,
          merchantPrivateKey: merchantPrivateKey,
          pgPublicKey: merchantPrivateKey,
          isSandbox: true)); // Set to false for production
```
> Note: Make sure to replace the provided credentials with your Nagad Sandbox or production credentials.

### Additional Merchant Info
You can provide additional details about your service to be displayed on the payment page.

### **Merchant Info Fields**
| Field Name| Max Length | Description |
|---------------------------------|------------------|-------------|
|serviceName|25|Service Name Provided by Merchant|
|serviceLogoURL|1~1024|Publicly accessible logo URL|
|additionalFieldName EN|20|Additional Field Name to be shown in Payment Page for Locale EN|
|additionalFieldName BN|20|Additional Field Name to be shown in Payment Page for Locale BN|
|additionalFieldValue|20|Value of Additional Field in English|

```dart
Map<String, dynamic> additionalMerchantInfo = {
        “serviceName” : “T Shirt”,
        “serviceLogoURL” : “tinyurl.com/sampleLogoUrl”,
        “additionalFieldNameEN” : “Color”,
        “additionalFieldNameBN” : “রং”,
        “additionalFieldValue” : “White”
    };

nagad.setAdditionalMerchantInfo(additionalMerchantInfo);
```

>N.B: additionalMerchantInfo must be in Map<String, dynamic> type. Additional Merchant Info can be anything and will be saved for further usage. However only these fields will be shown in the payment page.

## Initiate a Payment
To initiate a **Regular Payment**, use the `pay` method.

### **Payment Request**
```dart
NagadResponse nagadResponse = await nagad.regularPayment(
  context,
  amount: 10.25,
  orderId: orderId,
);
```


### **Parameters**
- `amount`: The payment amount (Recommended as `double`).
- `orderId`: A unique identifier for each payment. You can use milliseconds since epoch for uniqueness.

#### **Example for Generating Unique Order ID**
```dart
DateTime now = DateTime.now();
String orderId = 'order${now.millisecondsSinceEpoch}';
```

### **Payment Response Format**

**NagadResponse** class contains: 
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
> **Note:** Always store the required details in your database for future reference and reconciliation.


## Testing in Sandbox Mode
To test payments in **Sandbox Mode**, ensure `isSandbox: true` is set when initializing `Nagad`. Use the test credentials provided by Nagad.

## Production Deployment
When moving to production:
- Change `isSandbox: false`.
- Replace Sandbox credentials with production credentials.
- Ensure your merchant account is verified by Nagad.

## ⚠️ Security Warning
**Do not store merchant credentials directly in your Flutter application.** Instead, use a secure backend server to handle payments securely and prevent exposure of sensitive data.

## ⚠️ Best Practices
✅ **Use a backend server** to securely process payments and store credentials.  
✅ **Never store or expose** your `merchantPrivateKey` or other sensitive data in the frontend.  

## License
This package is licensed under the [GNU General Public License (GPL) version 3.0](https://www.gnu.org/licenses/gpl-3.0.html).

**© 2025** - Nagad Payment Gateway for Flutter

## Links & References
- [Official Documentation](https://github.com/muhibbin-munna/nagad_pg_php/blob/master/resource/Nagad%20Online%20Payment%20API%20Integration%20Guide%20v3.3.pdf)
- [Nagad Merchant Support](https://www.nagad.com.bd/)
