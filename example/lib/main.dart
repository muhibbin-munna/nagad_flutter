import 'package:example/pg_response.dart';
import 'package:flutter/material.dart';
import 'package:nagad_payment_gateway/nagad_payment_gateway.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nagad Payment Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Nagad Payment'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Nagad nagad;
  String error = '';

  @override
  void initState() {
    super.initState();

    nagad = Nagad(
        credentials: const NagadCredentials(
            merchantID: '', // Provide the merchantID
            merchantPrivateKey: '', // Provide the merchantPrivateKey
            pgPublicKey: '', // Provide the pgPublicKey
            isSandbox: true // set false for production
        )
    );

    nagad.setAdditionalMerchantInfo({
      'serviceName': 'Brand',
      'serviceLogoURL':
          'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png',
      'additionalFieldNameEN': 'Type',
      'additionalFieldNameBN': 'টাইপ',
      'additionalFieldValue': 'Payment',
    });
  }

  /// Function to initiate the payment process
  Future<void> _makePayment() async {
    setState(() => error = ''); // Clearing any previous error messages

    // Generating a unique order ID
    String orderId = 'order${DateTime.now().millisecondsSinceEpoch}';

    try {
      // Initiating a regular payment
      NagadResponse nagadResponse = await nagad.regularPayment(
        context,
        amount: 10.25,
        orderId: orderId,
      );

      // Navigating to the response page to show payment details
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PGResponse(nagadResponse: nagadResponse),
        ),
      );
    } catch (e) {
      // Handling errors and updating the UI
      setState(() => error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _makePayment,
              child: const Text('Make Payment'),
            ),
            const SizedBox(height: 20),
            if (error.isNotEmpty)
              Text(
                error,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
