// Global constant for app

const String APP_NAME = 'Smart Rabbit';
const String IS_FIRST_LOGIN = 'isFirstLogin';
const String X_TOKEN = 'X-Token';
const String USER_ID = 'User_ID';
const double MAIN_MARGIN = 12.0;
const Pattern EMAIL_PATTERN =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
const double LABEL_MARGIN = 5.0;

// User Error
const int NO_ERROR = 0;
const int CAN_NOT_VERIFY_TOKEN = 1;
const int UID_DUPLICATED = 2;
const int NOT_REGISTERED_PHONE_NUMBER = 3;
const int FB_LOGIN_FAILED = 4;
const int COMMON_ERROR = 5;
const int UNAUTHORIZED = 401;

enum LITERACY_TYPE {
  other,
  highschool,
  university,
  college,
  post_graduate
}

enum SALARY_TYPE {
  less_one,
  one_to_three,
  three_to_five,
  five_to_seven,
  more_seven
}