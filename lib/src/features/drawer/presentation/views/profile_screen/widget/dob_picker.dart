part of 'package:emdr_mindmend/src/features/drawer/presentation/views/profile_screen/edit_profile_screen.dart';

class _DOBPickerWidget extends ConsumerWidget {
  final ChangeNotifierProvider<EditProfileViewModel>
      editProfileViewModelProvider;

  const _DOBPickerWidget({required this.editProfileViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editProfileViewModel = ref.watch(editProfileViewModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    return CommonInkWell(
      onTap: () {
        _selectDateOfBirthFunction(context, editProfileViewModel, colorMode);
      },
      child: CustomInputField(
        title: "Date of Birth",
        enable: false,
        hint: "Enter date of birth",
        textInputAction: TextInputAction.done,
        controller: editProfileViewModel.dob,
        colorMode: colorMode,
      ),
    );
  }

  Future<void> _selectDateOfBirthFunction(BuildContext context,
      EditProfileViewModel editProfileViewModel, ColorMode colorMode) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2004),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                  surface: AppColorHelper.getScaffoldColor(colorMode),
                  primary: AppColors.primaryColor,
                  // Selected date's circle color
                  onPrimary: colorMode == ColorMode.light
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                  // Text color on selected date
                  onSurface: colorMode == ColorMode.light
                      ? AppColors.greyColor
                      : AppColors.whiteColor)

              // Background color of the date picker
              ),
          child: child!,
        );
      },
    );

    if (date != null) {
      editProfileViewModel.dob.controller.text =
          DateFormat('yyyy-MM-dd').format(date);
    }
  }
}
