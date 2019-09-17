import './constants.dart';

class Utils {
  static int genderToInt(GENDER gender) {
    switch (gender) {
      case GENDER.male:
        return 1;
      case GENDER.female:
        // TODO: Handle this case.
        return 2;
      case GENDER.other:
        // TODO: Handle this case.
        return 3;
      default:
        return 1;
    }
  }
}