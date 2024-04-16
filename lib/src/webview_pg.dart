import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final String callBackUrl;
  final String ipAddress;
  final bool isSandbox;
  const WebViewContainer({super.key, required this.callBackUrl, required this.ipAddress, required this.isSandbox});

  @override
  _WebViewContainerState createState() => _WebViewContainerState(callBackUrl);
}

class _WebViewContainerState extends State<WebViewContainer> {
  final String callBackUrl;

  _WebViewContainerState(this.callBackUrl);

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..loadRequest(Uri.parse(callBackUrl))
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(NavigationDelegate(
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) async {
        String refId = '';
        if(request.url.contains('check-out/abort')){
          refId = extractDataFromUrl(request.url) ?? '';
        }else if(request.url.contains('https://www.callbackurlflutter.com')){
          Uri uri = Uri.parse(request.url);
          Map<String, String> queryParams = uri.queryParameters;
          refId = queryParams["payment_ref_id"] ?? '';
        }
        if(refId.isNotEmpty){
          var response = await verifyPayment(widget.ipAddress, refId);
          Navigator.of(context).pop(response);
        }
        return NavigationDecision.prevent;
      },
    ));

    return SafeArea(
      child: Scaffold(
        body: WebViewWidget(controller: controller)
      ),
    );
  }

  Future<String> verifyPayment(ipAddress, paymentRefId) async {
    try {
      String baseUrl = widget.isSandbox? "https://sandbox-ssl.mynagad.com": "https://api.mynagad.com";
      final String url = '$baseUrl/api/dfs/verify/payment/$paymentRefId';

      http.Response response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'X-KM-IP-V4': ipAddress,
        'X-KM-Client-Type': 'MOBILE_APP',
        'X-KM-Api-Version': 'v-0.2.0',
      },);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw 'Failed to verify payment. Error: ${response.statusCode}, ${response.body}';
      }
    } catch (error) {
      throw 'Failed to verify payment';
    }
  }

  String? extractDataFromUrl(String url) {
    Uri uri = Uri.parse(url);
    List<String> segments = uri.pathSegments;
    int index = segments.indexOf('abort');
    if (index != -1 && index + 1 < segments.length) {
      return segments[index + 1];
    } else {
      return null;
    }
  }
}
