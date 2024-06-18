import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_applepay/payment_config/payment_config.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pay/pay.dart';
import 'package:flutter_applepay/requesturl.dart' as requesturl;


class PayWidget extends StatefulWidget {
  const PayWidget({super.key});

  @override
  State<PayWidget> createState() => _PayWidgetState();
}

class _PayWidgetState extends State<PayWidget> {

  Future<void> onApplePayResult(paymentResult) async {
    try {
      final token = await Stripe.instance.createApplePayToken(paymentResult);
      final response = await creatPaymentIntent("1000", 'jpy');
      final clientSecret = response['client_secret'];
      final params = PaymentMethodParams.cardFromToken(
        paymentMethodData: PaymentMethodDataCardFromToken(
          token: token.id,
        ),
      );
      final paymentIntentResult = await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: clientSecret,
        data: params,
      );
      debugPrint('payment successful: $paymentIntentResult');
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(''),
          content: const Text("Payment Success!!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
       );
    } catch (e) {
      debugPrint('Error in payment process: $e');
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(''),
          content: const Text("Payment Failed!!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }


  Future<Map<String, dynamic>> creatPaymentIntent(String amount, String currency) async {
    const url = "${requesturl.Constants.url}/api/payment/create-payment-intent-test";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8', 
      },
      body: jsonEncode({
        'amount': amount,
        'currency': currency
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to process payment: ${response.body}');
    }
  }

  @override
  
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: ApplePayButton(
            paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay), 
            paymentItems: const [
              PaymentItem(
                label: "Total",
                amount: "1000",
              )
            ],
            onPaymentResult: onApplePayResult,
          ),
        ),
      ),
    );
  }
}

