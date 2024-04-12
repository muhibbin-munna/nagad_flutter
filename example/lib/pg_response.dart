import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nagad_payment_gateway/nagad_payment_gateway.dart';

class PGResponse extends StatefulWidget {
  StatusAPIResponse statusAPIResponse;

  PGResponse({required this.statusAPIResponse});

  @override
  _PGResponseState createState() => _PGResponseState();
}

class _PGResponseState extends State<PGResponse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Merchant ID: ${widget.statusAPIResponse.merchantId ?? ''}'),
            Text('Order ID: ${widget.statusAPIResponse.orderId ?? ''}'),
            Text('Payment Ref ID: ${widget.statusAPIResponse.paymentRefId ?? ''}'),
            Text('Amount: ${widget.statusAPIResponse.amount ?? ''}'),
            Text('Client Mobile No: ${widget.statusAPIResponse.clientMobileNo ?? ''}'),
            Text('Merchant Mobile No: ${widget.statusAPIResponse.merchantMobileNo ?? ''}'),
            Text('Order Date Time: ${widget.statusAPIResponse.orderDateTime ?? ''}'),
            Text('Issuer Payment Date Time: ${widget.statusAPIResponse.issuerPaymentDateTime ?? ''}'),
            Text('Issuer Payment Ref No: ${widget.statusAPIResponse.issuerPaymentRefNo ?? ''}'),
            Text('Additional Merchant Info: ${widget.statusAPIResponse.additionalMerchantInfo ?? ''}'),
            Text('Status: ${widget.statusAPIResponse.status ?? ''}'),
            Text('Status Code: ${widget.statusAPIResponse.statusCode ?? ''}'),
            Text('Cancel Issuer Date Time: ${widget.statusAPIResponse.cancelIssuerDateTime ?? ''}'),
            Text('Cancel Issuer Ref No: ${widget.statusAPIResponse.cancelIssuerRefNo ?? ''}'),
            Text('Service Type: ${widget.statusAPIResponse.serviceType ?? ''}'),
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
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
