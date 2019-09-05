import 'package:mobx/mobx.dart';

import '../models/user.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  User user = User();

  @action
  void setUser(Map<String, dynamic> data) {
    User userState = User.fromJson(data);
    user = userState;
  }
}