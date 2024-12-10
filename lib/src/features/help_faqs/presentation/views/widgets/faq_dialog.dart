part of 'package:emdr_mindmend/src/features/help_faqs/presentation/views/help_faqs_library.dart';

class FaqDialog extends ConsumerWidget {
  const FaqDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorMode = ref.watch(colorModeProvider);
    return Scaffold(
        backgroundColor: AppColorHelper.getScaffoldColor(colorMode),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                10.verticalSpace,
                _logo(),
                40.verticalSpace,
                Card(
                  elevation: 5,
                  color: colorMode == ColorMode.light
                      ? AppColors.whiteColor
                      : AppColors.darkCardColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        30.verticalSpace,
                        Text(
                          "Help & FAQ’s  ",
                          style: PoppinsStyles.bold(
                                  color: AppColorHelper.getPrimaryTextColor(
                                      colorMode))
                              .copyWith(fontSize: 22.sp),
                        ),
                        10.verticalSpace,
                        _tiles(
                            img: AppImages.contactUs,
                            title: 'Contact  us ',
                            onTap: () {
                              CustomNavigation().push(_ContactUsScreen());
                            },
                            colorMode: colorMode),
                        _tiles(
                            img: AppImages.faq,
                            title: 'FAQ’s',
                            onTap: () {
                              CustomNavigation().push(_HelpFaqScreen());
                            },
                            colorMode: colorMode),
                        30.verticalSpace,
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _logo() {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(AppImages.logo, height: 80.h, fit: BoxFit.contain),
    );
  }

  Widget _tiles(
      {required String img,
      required String title,
      required Function onTap,
      required ColorMode colorMode}) {
    return Padding(
      padding: EdgeInsets.only(top: 20.sp),
      child: CommonInkWell(
        onTap: () => onTap(),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorMode == ColorMode.light
                      ? const Color(0xffD1FDBA)
                      : AppColors.primaryColor),
              child: Image.asset(
                img,
                width: 15.sp,
                height: 15.sp,
                fit: BoxFit.contain,
                color: colorMode == ColorMode.light
                    ? const Color(0xff106E27)
                    : Colors.white,
              ),
            ),
            16.horizontalSpace,
            Text(
              title,
              style: PoppinsStyles.medium(
                      color: AppColorHelper.getPrimaryTextColor(colorMode))
                  .copyWith(fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
