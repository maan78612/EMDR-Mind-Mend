import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/services/stripe/stripe_methods.dart';
import 'package:emdr_mindmend/src/core/utilities/custom_snack_bar.dart';
import 'package:emdr_mindmend/src/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Subscription extends ConsumerStatefulWidget {
  const Subscription({super.key});

  @override
  ConsumerState<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends ConsumerState<Subscription> {
  final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
    return HomeViewModel();
  });

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider).getSubscriptionList(
              showSnackBarMsg: ({
            required SnackBarType snackType,
            required String message,
          }) =>
                  Utils.showSnackBar(message, snackType,
                      CustomNavigation().navigatorKey.currentState!.context));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = ref.watch(homeViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Upgrade Premium",
          style: PoppinsStyles.medium.copyWith(fontSize: 18.sp),
        ),
        leading: CommonInkWell(
          onTap: () {
            CustomNavigation().pop();
          },
          child: const Icon(Icons.arrow_back_ios, color: AppColors.blackColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: hMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            20.verticalSpace,
            Text(
              "Choose Member Plan",
              style: PoppinsStyles.bold.copyWith(fontSize: 20.sp),
            ),
            30.verticalSpace,
            Column(
              children:
                  List.generate(homeViewModel.subscriptionList.length, (index) {
                final subscriptionData = homeViewModel.subscriptionList[index];
                return subscriptionTile(
                    amount: subscriptionData.amount,
                    name: subscriptionData.name,
                    duration: subscriptionData.duration,
                    description: subscriptionData.description);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget subscriptionTile(
      {required double amount,
      required String duration,
      required String name,
      required String description}) {
    return GestureDetector(
      onTap: ()=>PaymentService().makePayment(amount: '1'),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 16.sp),
        margin: EdgeInsets.symmetric(vertical: 10.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            border: Border.all(color: AppColors.borderColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    if (amount > 0)
                      TextSpan(
                        text: "${amount.toString()}/",
                        style: PoppinsStyles.bold.copyWith(
                            fontSize: 30.sp, color: AppColors.primaryColor),
                      ),
                    TextSpan(
                        text: name,
                        style: PoppinsStyles.semiBold.copyWith(
                          fontSize: amount <= 0 ? 30 : 14.sp,
                          color: amount <= 0
                              ? AppColors.primaryColor
                              : const Color(0xff999999),
                        ))
                  ],
                )),
            18.verticalSpace,
            Text(
              duration == "12 months"
                  ? "Yearly Plan"
                  : duration == "1 month"
                      ? "Monthly Plan"
                      : duration,
              style: PoppinsStyles.semiBold.copyWith(fontSize: 14.sp),
            ),
            10.verticalSpace,
            if (amount > 0)
              Text(
                description,
                style: PoppinsStyles.regular.copyWith(
                  fontSize: 14.sp,
                  color: const Color(0xff999999),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
