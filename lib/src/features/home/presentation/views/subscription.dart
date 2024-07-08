import 'package:emdr_mindmend/src/core/services/stripe/stripe_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Subscription extends StatelessWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Subscription"),
            30.verticalSpace,
            ElevatedButton(
              onPressed: () {
                try {
                  PaymentService().makePayment(amount: "10");
                } on Exception catch (e) {
                  debugPrint("stripe error =  ${e.toString()}");
                }
              },
              child: const Text("submit"),
            ),
          ],
        ),
      ),
    );
  }
}
