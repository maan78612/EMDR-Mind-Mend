part of'package:emdr_mindmend/src/features/settings/presentation/views/setting_screen.dart';

class _SpeedWidget extends ConsumerWidget {
  final SettingSlider slider;

  const _SpeedWidget({super.key, required this.slider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingViewModel = ref.watch(settingViewModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        children: [
          Text("Speed",
              style: PoppinsStyles.semiBold(
                  color:
                  AppColorHelper.getPrimaryTextColor(colorMode)).copyWith(fontSize: 22.sp)),
          SizedBox(width: 10.w),
          Text(
            "Low",
            style: PoppinsStyles.semiBold(
                color:
                AppColorHelper.getPrimaryTextColor(colorMode)).copyWith(fontSize: 13.sp),
          ),
          Expanded(
            child: Slider(
              value: slider == SettingSlider.auditory
                  ? settingViewModel.auditorySpeed
                  : settingViewModel.visualSpeed,
              min: 1,
              max: 3,
              inactiveColor: const Color(0xffE7E9F3),
              divisions: 2,
              thumbColor: settingViewModel.getColor(settingViewModel.ballColor),
              activeColor:
                  settingViewModel.getColor(settingViewModel.ballColor),
              onChangeEnd: (value) {
                if (settingViewModel.isPlaying) {
                  settingViewModel
                      .stopSound(); // Stop the current sound and timer
                  settingViewModel
                      .playSound(); // Start playing sound with the updated speed
                }
              },
              onChanged: (double value) {
                slider == SettingSlider.auditory
                    ? settingViewModel.setAuditorySpeed(value)
                    : settingViewModel.setVisualSpeed(value);
              },
            ),
          ),
          Text(
            "High",
            style: PoppinsStyles.semiBold(
                color:
                AppColorHelper.getPrimaryTextColor(colorMode)).copyWith(fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}
