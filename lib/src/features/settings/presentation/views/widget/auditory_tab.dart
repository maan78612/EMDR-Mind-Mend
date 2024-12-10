part of'package:emdr_mindmend/src/features/settings/presentation/views/setting_screen.dart';

class _AuditoryTab extends ConsumerWidget {
  const _AuditoryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingViewModel = ref.watch(settingViewModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    return Column(
      children: [
        toneWidget(settingViewModel, colorMode),
        25.verticalSpace,
        Divider(color: AppColorHelper.dividerColor(colorMode)),
        25.verticalSpace,
        const _SpeedWidget(slider: SettingSlider.auditory),
        if (settingViewModel.isPlaying)
          CommonInkWell(
            onTap: () {
              settingViewModel.stopSound();
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.redColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.stop,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
      ],
    );
  }

  Widget toneWidget(SettingViewModel settingViewModel, ColorMode colorMode) {
    return Padding(
      padding: EdgeInsets.only(top: 30.sp),
      child: Row(
        children: [
          Text("Tone",
              style: PoppinsStyles.semiBold(
                      color: AppColorHelper.getPrimaryTextColor(colorMode))
                  .copyWith(fontSize: 22.sp)),
          20.horizontalSpace,
          Row(
            children: List.generate(settingViewModel.toneList.length, (index) {
              return CommonInkWell(
                onTap: () {
                  settingViewModel.selectTone(index);
                },
                child: Container(
                  width: settingViewModel.selectedToneIndex == index
                      ? 35.sp
                      : 30.sp,
                  height: settingViewModel.selectedToneIndex == index
                      ? 35.sp
                      : 30.sp,
                  margin: EdgeInsets.only(right: 10.h),
                  decoration: BoxDecoration(
                      color: settingViewModel.selectedToneIndex == index
                          ? settingViewModel
                              .getColor(settingViewModel.ballColor)
                          : AppColors.whiteColor,
                      shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: settingViewModel.selectedToneIndex == index
                          ? PoppinsStyles.semiBold(color: AppColors.whiteColor)
                              .copyWith(fontSize: 15.sp)
                          : PoppinsStyles.medium(
                                  color: AppColors.lightSecondaryTextColor)
                              .copyWith(fontSize: 15.sp),
                    ),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
