
import 'package:flutter/material.dart';
import 'package:nagad_payment_gateway/nagad_payment_gateway.dart';

class PGResponse extends StatefulWidget {
  NagadResponse nagadResponse;

  PGResponse({super.key, required this.nagadResponse});

  @override
  _PGResponseState createState() => _PGResponseState();
}

class _PGResponseState extends State<PGResponse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Merchant ID: ${widget.nagadResponse.merchantId ?? ''}'),
            Text('Order ID: ${widget.nagadResponse.orderId ?? ''}'),
            Text('Payment Ref ID: ${widget.nagadResponse.paymentRefId ?? ''}'),
            Text('Amount: ${widget.nagadResponse.amount ?? ''}'),
            Text('Client Mobile No: ${widget.nagadResponse.clientMobileNo ?? ''}'),
            Text('Merchant Mobile No: ${widget.nagadResponse.merchantMobileNo ?? ''}'),
            Text('Order Date Time: ${widget.nagadResponse.orderDateTime ?? ''}'),
            Text('Issuer Payment Date Time: ${widget.nagadResponse.issuerPaymentDateTime ?? ''}'),
            Text('Issuer Payment Ref No: ${widget.nagadResponse.issuerPaymentRefNo ?? ''}'),
            Text('Additional Merchant Info: ${widget.nagadResponse.additionalMerchantInfo ?? ''}'),
            Text('Status: ${widget.nagadResponse.status ?? ''}'),
            Text('Status Code: ${widget.nagadResponse.statusCode ?? ''}'),
            Text('Cancel Issuer Date Time: ${widget.nagadResponse.cancelIssuerDateTime ?? ''}'),
            Text('Cancel Issuer Ref No: ${widget.nagadResponse.cancelIssuerRefNo ?? ''}'),
            Text('Service Type: ${widget.nagadResponse.serviceType ?? ''}'),
          ],
        )

      ),
    );
  }

  Widget buildText(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
