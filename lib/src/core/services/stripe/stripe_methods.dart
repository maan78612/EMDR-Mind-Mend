import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/services/network/api_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentService {
  Future<bool> makePayment({
    required double amount,
    String currency = "USD",
    required String userName
  }) async {
    try {
      /// Create Payment Intent
      Map<String, dynamic> paymentIntent =
          await _createPaymentIntent(amount, currency);

      /// Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          style: ThemeMode.light,
          merchantDisplayName: userName,
        ),
      );

      /// Display Payment Sheet
      return await _displayPaymentSheet();
    } catch (err) {
      rethrow;
    }
  }

  Future<dynamic> _createPaymentIntent(double amount, String currency) async {
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

      return response;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<bool> _displayPaymentSheet() async {
    debugPrint("_displayPaymentSheet");
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } on StripeException catch (e) {
      throw Exception(e.error.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  int calculateAmount(double amount) {
    return (amount * 100).toInt();
  }
}
