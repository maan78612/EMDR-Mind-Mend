class TextFieldValidator {
  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Required field is empty";
    } else if (value.length <= 5) {
      return "Password must be greater than 5";
    }
    return null;
  }

  static String? validateUid(String? value) {
    if (value!.isEmpty) {
      return "Required field is empty";
    }
    if (!RegExp(r"\d").hasMatch(value)) {
      return "Uid must have 1 number";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Email is Required";
    }

    if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      return "Please enter a valid Email Address";
    }

    return null;
  }

  static String? validatePersonName(String? value) {
    if (value!.isEmpty) return "Required field is empty";

    return null;
  }
  static String? validateField(String? value) {
    if (value!.isEmpty) return "Required field is empty";

    return null;
  }
}
