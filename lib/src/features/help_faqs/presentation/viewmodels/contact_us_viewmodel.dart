import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/custom_text_controller.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/features/help_faqs/data/repositories/help_faq_repository_impl.dart';
import 'package:emdr_mindmend/src/features/help_faqs/domain/repositories/help_faq_repository.dart';
import 'package:flutter/material.dart';

class ContactUsViewModel with ChangeNotifier {
  final HelpFaqRepository _helpFaqRepository = HelpFaqRepositoryImpl();

  final CustomTextController nameController = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());
  final CustomTextController emailController = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());
  final CustomTextController messageController = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());

  bool _isBtnEnable = false;

  bool get isBtnEnable => _isBtnEnable;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void onChange(
      {required CustomTextController con,
      String? Function(String?)? validator,
      required String value}) {
    if (validator != null) {
      con.error = validator(value);
    }
    setEnableBtn();
  }

  void setEnableBtn() {
    if (nameController.controller.text.isNotEmpty &&
        emailController.controller.text.isNotEmpty &&
        messageController.controller.text.isNotEmpty) {
      if (nameController.error == null &&
          emailController.error == null &&
          messageController.error == null) {
        _isBtnEnable = true;
      } else {
        _isBtnEnable = false;
      }
    } else {
      _isBtnEnable = false;
    }

    notifyListeners();
  }

  Future<void> submitContactUs(
      {required Function({
        required SnackBarType snackType,
        required String message,
      }) showSnackBarMsg}) async {
    try {
      setLoading(true);

      final body = {
        "email": emailController.controller.text,
        "name": nameController.controller.text,
        "message": messageController.controller.text
      };
      await _helpFaqRepository.contactUs(body: body);
      CustomNavigation().pop();
      showSnackBarMsg(message: "Message sent", snackType: SnackBarType.success);
    } catch (e) {
      showSnackBarMsg(message: e.toString(), snackType: SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }
}
