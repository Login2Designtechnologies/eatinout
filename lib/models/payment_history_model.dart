class PaymentHistoryModel {
  String? restaurantId;
  String? restaurantTitle;
  String? city;
  String? address;
  String? transactionId;
  String? createdAt;
  String? gst;
  String? commission;
  String? offerClaimedTitle;
  String? transactionStatus;
  String? refundStatus;
  String? customerName;
  String? customerEmail;
  String? customerNumber;
  String? customerId;
  String? totalAmount;
  String? tipAmount;
  String? discountAmount;
  String? payedAmount;
  String? discount;
  String? walletAmount;
  String? paymentMethod;

  PaymentHistoryModel(
      {this.restaurantId,
      this.restaurantTitle,
      this.city,
      this.address,
      this.transactionId,
      this.createdAt,
      this.gst,
      this.commission,
      this.offerClaimedTitle,
      this.transactionStatus,
      this.refundStatus,
      this.customerName,
      this.customerEmail,
      this.customerNumber,
      this.customerId,
      this.totalAmount,
      this.tipAmount,
      this.discountAmount,
      this.payedAmount,
      this.discount,
      this.walletAmount,
      this.paymentMethod});

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurant_id'];
    restaurantTitle = json['restaurant_title'];
    city = json['city'];
    address = json['address'];
    transactionId = json['transaction_id'];
    createdAt = json['created_at'];
    gst = json['gst'];
    commission = json['commission'];
    offerClaimedTitle = json['offer_claimed_title'];
    transactionStatus = json['transaction_status'];
    refundStatus = json['refund_status'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerNumber = json['customer_number'];
    customerId = json['customer_id'];
    totalAmount = json['total_amount'];
    tipAmount = json['tip_amount'];
    discountAmount = json['discount_amount'];
    payedAmount = json['payed_amount'];
    discount = json['discount'];
    walletAmount = json['wallet_amount'];
    paymentMethod = json['payment_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_id'] = this.restaurantId;
    data['restaurant_title'] = this.restaurantTitle;
    data['city'] = this.city;
    data['address'] = this.address;
    data['transaction_id'] = this.transactionId;
    data['created_at'] = this.createdAt;
    data['gst'] = this.gst;
    data['commission'] = this.commission;
    data['offer_claimed_title'] = this.offerClaimedTitle;
    data['transaction_status'] = this.transactionStatus;
    data['refund_status'] = this.refundStatus;
    data['customer_name'] = this.customerName;
    data['customer_email'] = this.customerEmail;
    data['customer_number'] = this.customerNumber;
    data['customer_id'] = this.customerId;
    data['total_amount'] = this.totalAmount;
    data['tip_amount'] = this.tipAmount;
    data['discount_amount'] = this.discountAmount;
    data['payed_amount'] = this.payedAmount;
    data['discount'] = this.discount;
    data['wallet_amount'] = this.walletAmount;
    data['payment_method'] = this.paymentMethod;
    return data;
  }
}
