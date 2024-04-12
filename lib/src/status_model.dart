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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchantId'] = this.merchantId;
    data['orderId'] = this.orderId;
    data['paymentRefId'] = this.paymentRefId;
    data['amount'] = this.amount;
    data['clientMobileNo'] = this.clientMobileNo;
    data['merchantMobileNo'] = this.merchantMobileNo;
    data['orderDateTime'] = this.orderDateTime;
    data['issuerPaymentDateTime'] = this.issuerPaymentDateTime;
    data['issuerPaymentRefNo'] = this.issuerPaymentRefNo;
    data['additionalMerchantInfo'] = this.additionalMerchantInfo;
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['cancelIssuerDateTime'] = this.cancelIssuerDateTime;
    data['cancelIssuerRefNo'] = this.cancelIssuerRefNo;
    data['serviceType'] = this.serviceType;
    return data;
  }
}
