import 'package:emdr_mindmend/src/core/commons/custom_button.dart';
import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/loader.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/utilities/custom_snack_bar.dart';
import 'package:emdr_mindmend/src/features/home/domain/models/subscription.dart';
import 'package:emdr_mindmend/src/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionScreen extends ConsumerWidget {
  final ChangeNotifierProvider<HomeViewModel> homeViewModelProvider;

  const SubscriptionScreen({super.key, required this.homeViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.watch(homeViewModelProvider);
    return CustomLoader(
      isLoading: homeViewModel.isLoading,
      child: Scaffold(
        backgroundColor: AppColors.whiteBg,
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
            child: const Icon(Icons.close, color: AppColors.blackColor),
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
                children: List.generate(homeViewModel.subscriptionList.length,
                    (index) {
                  final subscriptionData =
                      homeViewModel.subscriptionList[index];
                  return subscriptionTile(
                      subscription: subscriptionData,
                      homeViewModel: homeViewModel);
                }),
              ),
              const Spacer(),
              CustomButton(
                bgColor: AppColors.primaryColor,
                isEnable: homeViewModel.isBtnEnable,
                onPressed: () {
                  homeViewModel.setSubscription(
                      showSnackBarMsg: ({
                    required SnackBarType snackType,
                    required String message,
                  }) =>
                          Utils.showSnackBar(message, snackType, context));
                },
                title: "Continue",
                textColor: AppColors.whiteColor,
              ),
              30.verticalSpace,
              CustomButton(
                bgColor: AppColors.whiteColor,
                onPressed: () {},
                title: "Start free trial",
                textColor: AppColors.primaryColor,
                borderColor: AppColors.primaryColor,
              ),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget subscriptionTile(
      {required SubscriptionModel subscription,
      required HomeViewModel homeViewModel}) {
    return GestureDetector(
      onTap: () async {
        homeViewModel.selectSubscription(subscription);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 16.sp),
        margin: EdgeInsets.symmetric(vertical: 10.sp),
        decoration: BoxDecoration(
            color: subscription.id == homeViewModel.selectedSubscription?.id
                ? AppColors.primaryColor.withOpacity(0.12)
                : AppColors.whiteBg,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            border: Border.all(
                color: subscription.id == homeViewModel.selectedSubscription?.id
                    ? AppColors.primaryColor
                    : AppColors.borderColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (subscription.amount > 0) ...[
                  Text(
                    subscription.amount.toString(),
                    style: PoppinsStyles.bold.copyWith(
                        fontSize: 30.sp, color: AppColors.primaryColor),
                  ),
                  Text("  /",
                      style: PoppinsStyles.semiBold.copyWith(
                        fontSize: subscription.amount <= 0 ? 30 : 14.sp,
                        color: subscription.amount <= 0
                            ? AppColors.primaryColor
                            : const Color(0xff999999),
                      )),
                ],
                Text(subscription.name,
                    style: PoppinsStyles.semiBold.copyWith(
                      fontSize: subscription.amount <= 0 ? 30 : 14.sp,
                      color: subscription.amount <= 0
                          ? AppColors.primaryColor
                          : const Color(0xff999999),
                    ))
              ],
            ),
            18.verticalSpace,
            Text(
              subscription.duration == "12 months"
                  ? "Yearly Plan"
                  : subscription.duration == "1 month"
                      ? "Monthly Plan"
                      : subscription.duration,
              style: PoppinsStyles.semiBold.copyWith(fontSize: 14.sp),
            ),
            10.verticalSpace,
            if (subscription.amount > 0)
              Text(
                subscription.description,
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
