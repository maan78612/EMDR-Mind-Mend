import 'dart:convert';
import 'package:emdr_mindmend/src/core/services/network/api_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentService {


  Future<void> makePayment(
      {required String amount, String currency = "USD"}) async {
    try {
      /// Create Payment Intent
      final paymentIntent = await _createPaymentIntent(amount, currency);

      /// Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Ikay',
        ),
      );

      /// Display Payment Sheet
      await _displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<Map<String, dynamic>?> _createPaymentIntent(
      String amount, String currency) async {
    try {
      final body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      final response = await NetworkApi.instance.post(
        url: "https://api.stripe.com/v1/payment_intents",
        body: body,
        customHeader: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      return json.decode(response.data);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<void> _displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {

      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      debugPrint('$e');
    }
  }

  int calculateAmount(String amount) {
    return (int.parse(amount)) * 100;
  }
}
