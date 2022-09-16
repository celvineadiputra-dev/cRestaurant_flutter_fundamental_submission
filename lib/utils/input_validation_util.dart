mixin InputValidationUtil {
  bool isPasswordValid(String password) {
    return password.length >= 8 && password.length <= 16;
  }

  bool isEmailValid(String email) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(email);
  }

  bool isNameValid(String name) {
    final nameRegExp = RegExp(r"^[A-Za-z][A-Za-z0-9_]{3,20}$");
    return nameRegExp.hasMatch(name);
  }
}
