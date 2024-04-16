class StatusAPIResponse {
  String? merchantId;
  String? orderId;
  String? paymentRefId;
  String? amount;
  String? clientMobileNo;
  String? merchantMobileNo;
  String? orderDateTime;
  String? issuerPaymentDateTime;
  String? issuerPaymentRefNo;
  String? additionalMerchantInfo;
  String? status;
  String? statusCode;
  String? cancelIssuerDateTime;
  String? cancelIssuerRefNo;
  String? serviceType;


  StatusAPIResponse(
      {this.merchantId,
        this.orderId,
        this.paymentRefId,
        this.amount,
        this.clientMobileNo,
        this.merchantMobileNo,
        this.orderDateTime,
        this.issuerPaymentDateTime,
        this.issuerPaymentRefNo,
        this.additionalMerchantInfo,
        this.status,
        this.statusCode,
        this.cancelIssuerDateTime,
        this.cancelIssuerRefNo,
        this.serviceType});

  StatusAPIResponse.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchantId'];
    orderId = json['orderId'];
    paymentRefId = json['paymentRefId'];
    amount = json['amount'];
    clientMobileNo = json['clientMobileNo'];
    merchantMobileNo = json['merchantMobileNo'];
    orderDateTime = json['orderDateTime'];
    issuerPaymentDateTime = json['issuerPaymentDateTime'];
    issuerPaymentRefNo = json['issuerPaymentRefNo'];
    additionalMerchantInfo = json['additionalMerchantInfo'];
    status = json['status'];
    statusCode = json['statusCode'];
    cancelIssuerDateTime = json['cancelIssuerDateTime'];
    cancelIssuerRefNo = json['cancelIssuerRefNo'];
    serviceType = json['serviceType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['merchantId'] = merchantId;
    data['orderId'] = orderId;
    data['paymentRefId'] = paymentRefId;
    data['amount'] = amount;
    data['clientMobileNo'] = clientMobileNo;
    data['merchantMobileNo'] = merchantMobileNo;
    data['orderDateTime'] = orderDateTime;
    data['issuerPaymentDateTime'] = issuerPaymentDateTime;
    data['issuerPaymentRefNo'] = issuerPaymentRefNo;
    data['additionalMerchantInfo'] = additionalMerchantInfo;
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['cancelIssuerDateTime'] = cancelIssuerDateTime;
    data['cancelIssuerRefNo'] = cancelIssuerRefNo;
    data['serviceType'] = serviceType;
    return data;
  }
}
