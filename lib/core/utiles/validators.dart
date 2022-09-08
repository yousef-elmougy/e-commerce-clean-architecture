import 'package:shop_clean_architecture/core/extentions/validation_extension.dart';

validInput(String val, int min, int max, String type) {

  if (val.isNotNull) {

    if (type == "username" && val.isValidName) return "not valid username";

    if (type == "email" && val.isValidEmail) return "not valid email";

    if (type == "phone" && val.isValidPhone) return "not valid phone";

    if (type == "password" && val.isValidPassword) return "not valid password";

    if (val.isEmpty) return "can't be Empty";

    if (val.length < min) return "can't be less than $min";

    if (val.length > max) return "can't be larger than $max";
  }
}
