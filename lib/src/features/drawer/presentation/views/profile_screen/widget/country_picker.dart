part of 'package:emdr_mindmend/src/features/drawer/presentation/views/profile_screen/edit_profile_screen.dart';

class _CountryPickerWidget extends ConsumerWidget {
  final ChangeNotifierProvider<EditProfileViewModel>
      editProfileViewModelProvider;

  const _CountryPickerWidget({required this.editProfileViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editProfileViewModel = ref.watch(editProfileViewModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    return CommonInkWell(
      onTap: () {
        _selectCountry(context, editProfileViewModel, colorMode);
      },
      child: CustomInputField(
        title: "Country",
        enable: false,
        hint: "Enter country",
        textInputAction: TextInputAction.done,
        controller: editProfileViewModel.countryCon,
        colorMode: colorMode,
      ),
    );
  }

  Future<void> _selectCountry(BuildContext context,
      EditProfileViewModel editProfileViewModel, ColorMode colorMode) async {
    final inputBorder = _getInputBorder(colorMode);

    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        editProfileViewModel.countryCon.controller.text = country.name;
      },
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 0.5.sh,
        backgroundColor: AppColorHelper.getScaffoldColor(colorMode),
        textStyle: PoppinsStyles.regular(
          color: AppColorHelper.getPrimaryTextColor(colorMode),
        ).copyWith(fontSize: 15.sp),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        inputDecoration: InputDecoration(
          hintText: 'Search Country',
          filled: true,
          fillColor: AppColorHelper.getScaffoldColor(colorMode),
          hintStyle:
              PoppinsStyles.regular(color: AppColorHelper.hintColor(colorMode))
                  .copyWith(fontSize: 15.sp),
          border: inputBorder,
          enabledBorder: inputBorder,
          errorBorder: inputBorder,
          focusedBorder: inputBorder.copyWith(
              borderSide: BorderSide(color: AppColors.focusedBorderColor)),
          disabledBorder: inputBorder,
        ),
        searchTextStyle: PoppinsStyles.regular(
                color: AppColorHelper.getPrimaryTextColor(colorMode))
            .copyWith(fontSize: 15.sp),
      ),
    );
  }

  InputBorder _getInputBorder(ColorMode colorMode) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: colorMode == ColorMode.light
            ? AppColors.borderColor
            : AppColors.lightCardColor,
        width: 1,
      ),
    );
  }
}
