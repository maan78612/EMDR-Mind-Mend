import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/subscription.dart';
import 'package:emdr_mindmend/src/features/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  //Initialize Flutter Binding
  await _initMethod();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _initMethod() async {
  //Initialize Flutter Binding
  WidgetsFlutterBinding.ensureInitialized();

  //Assign publishable key to flutter_stripe
  Stripe.publishableKey = "pk_test_24PsRoB2O46Bxxxxxxxxxxxxxxxxxxxxxxxx";

  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: false,
      builder: (_, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: CustomNavigation().navigatorKey,
            title: 'Mind Mend',
            home: const Subscription(),
          ),
        );
      },
    );
  }
}
