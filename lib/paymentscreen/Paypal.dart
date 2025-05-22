// ignore_for_file: avoid_print, prefer_const_literals_to_create_immutables, must_be_immutable, file_names

import 'package:dineout/Getx_Controller/Discount_order_controller.dart';
import 'package:dineout/Payment/Bill_paid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:get/get.dart';

class PayPalPayment extends StatefulWidget {
  String? title;
  String? bilamount;
  String? tip;
  String? restid;
  String? hotelname;
  String? address;
  String? discountamt;
  String? payedamt;
  String? walletamt;
  String? selectidPay;
  String? transactionid;
  String? discountvalue;
  String? tipamt;
  String? totelbill;
  // ignore: use_super_parameters
  PayPalPayment(
      {this.title,
      this.bilamount,
      this.tip,
      this.restid,
      this.hotelname,
      this.address,
      this.discountamt,
      this.payedamt,
      this.walletamt,
      this.selectidPay,
      this.transactionid,
      this.discountvalue,
      this.tipamt,
      this.totelbill,
      Key? key})
      : super(key: key);

  @override
  State<PayPalPayment> createState() => _PayPalPaymentState();
}

class _PayPalPaymentState extends State<PayPalPayment> {
  DiscountorderController discountorder = Get.put(DiscountorderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextButton(
          onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => UsePaypal(
                        sandboxMode: true,
                        clientId:
                            "Aa0Yim_XLAz89S4cqO-kT4pK3QbFsruHvEm8zDYX_Y-wIKgsGyv4TzL84dGgtWYUoJqTvKUh0JonIaKa",
                        secretKey:
                            "ECZEZmIjx0j_3_RStM7eT3Bc0Ehdd_yW4slqTnCtNI8WtVOVL1qwRh__u1W_8qKygnPDs0XaviNlb7-z",
                        returnURL:
                            "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=EC-35S7886705514393E",
                        cancelURL:
                            "https://dineout.zozostudio.tech/paypal/cancle.php",
                        transactions: [
                          {
                            "amount": {
                              "total": widget.payedamt,
                              "currency": "USD",
                              "details": {
                                "subtotal": widget.payedamt,
                                "shipping": '0',
                                "shipping_discount": 0
                              }
                            },
                            "description":
                                "The payment transaction description.",
                            "item_list": {
                              "items": [
                                {
                                  "name": "A demo product",
                                  "quantity": 1,
                                  "price": widget.payedamt,
                                  "currency": "USD"
                                }
                              ],

                              // shipping address is not required though
                              "shipping_address": {
                                "recipient_name": "Jane Foster",
                                "line1": "Travis County",
                                "line2": "",
                                "city": "Austin",
                                "country_code": "US",
                                "postal_code": "73301",
                                "phone": "+00000000",
                                "state": "Texas"
                              },
                            }
                          }
                        ],
                        note: "Contact us for any questions on your order.",
                        onSuccess: (Map params) {
                          print(
                              "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${widget.discountamt}");
                          print(
                              "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${widget.discountvalue}");
                          print(
                              "###############################${widget.totelbill}");
                          print(
                              "===============================${widget.payedamt}");
                          print(
                              "+++++++++++++++++++++++++++++++${widget.selectidPay}");
                          print(
                              "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${widget.restid}");
                          print(
                              "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${widget.tipamt}");
                          print(
                              "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${params["paymentId"]}");
                          Get.back();
                          discountorder.discountnow(
                              discountamount: widget.discountamt,
                              discountvalue: widget.discountvalue,
                              payedamount: widget.payedamt,
                              paymentid: widget.selectidPay,
                              restid: widget.restid,
                              tipamount: widget.tipamt,
                              totelamount: widget.totelbill,
                              transactionid: params["paymentId"],
                              wallatamount: "0");
                          Get.to(() => BillPaid(
                                address: widget.address,
                                hotelname: widget.hotelname,
                                restid: widget.restid,
                                discountvalue: widget.tip,
                                tipamt: widget.tipamt,
                                totelbill: widget.totelbill,
                                discountamt: widget.discountamt,
                                payedamt: widget.payedamt,
                                walletamt: "0",
                                selectidPay: widget.selectidPay,
                                transactionid: params["paymentId"],
                              ));
                          Get.back();
                          print("onSuccess: $params");
                        },
                        onError: (error) {
                          print("onError: $error");
                        },
                        onCancel: (params) {
                          print('cancelled: $params');
                        }),
                  ),
                )
              },
          child: const Text("Make Payment")),
    ));
  }
}
