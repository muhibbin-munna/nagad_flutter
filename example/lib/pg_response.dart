import 'package:flutter/material.dart';
import 'package:nagad_payment_gateway/nagad_payment_gateway.dart';

class PGResponse extends StatelessWidget {
  final NagadResponse nagadResponse;

  const PGResponse({super.key, required this.nagadResponse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Status')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildText('Merchant ID', nagadResponse.merchantId),
            buildText('Order ID', nagadResponse.orderId),
            buildText('Payment Ref ID', nagadResponse.paymentRefId),
            buildText('Amount', nagadResponse.amount),
            buildText('Client Mobile No', nagadResponse.clientMobileNo),
            buildText('Merchant Mobile No', nagadResponse.merchantMobileNo),
            buildText('Order Date Time', nagadResponse.orderDateTime),
            buildText('Issuer Payment Date Time',
                nagadResponse.issuerPaymentDateTime),
            buildText(
                'Issuer Payment Ref No', nagadResponse.issuerPaymentRefNo),
            buildText('Additional Merchant Info',
                nagadResponse.additionalMerchantInfo),
            buildText('Status', nagadResponse.status),
            buildText('Status Code', nagadResponse.statusCode),
            buildText(
                'Cancel Issuer Date Time', nagadResponse.cancelIssuerDateTime),
            buildText('Cancel Issuer Ref No', nagadResponse.cancelIssuerRefNo),
            buildText('Service Type', nagadResponse.serviceType),
          ],
        ),
      ),
    );
  }

  Widget buildText(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '$label: ${value ?? 'null'}',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
